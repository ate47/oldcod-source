#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_63c7213c;

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x6
// Checksum 0x922f0b9c, Offset: 0x250
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_3c43448fdb77ea73", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 0, eflags: 0x0
// Checksum 0xe323bd5c, Offset: 0x298
// Size: 0x178
function function_70a657d8() {
    clientfield::register("scriptmover", "soul_capture_zombie_tracker", 1, 2, "int", &soul_capture_zombie_tracker, 0, 0);
    clientfield::register("actor", "soul_capture_zombie_fire", 1, 1, "int", &soul_capture_zombie_fire, 0, 0);
    clientfield::register("actor", "soul_capture_zombie_float", 1, 1, "int", &soul_capture_zombie_float, 0, 0);
    clientfield::register("scriptmover", "soul_capture_crystal_leave", 1, 2, "int", &soul_capture_crystal_leave, 0, 0);
    clientfield::register("scriptmover", "soul_capture_crystal_timer", 1, 2, "int", &soul_capture_crystal_timer, 0, 0);
    level.var_1ffd81e8 = [];
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 7, eflags: 0x0
// Checksum 0xf24a4e20, Offset: 0x418
// Size: 0x102
function soul_capture_zombie_tracker(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self.var_f6a6e73d)) {
        stopfx(fieldname, self.var_f6a6e73d);
        self.var_f6a6e73d = undefined;
    }
    if (bwastimejump <= 0) {
        return;
    }
    switch (bwastimejump) {
    case 1:
        str_fx = "maps/zm_red/fx8_reward_brazier_fire_blue";
        break;
    case 2:
        str_fx = "maps/zm_red/fx8_reward_brazier_fire_orange";
        break;
    }
    self.var_f6a6e73d = util::playfxontag(fieldname, str_fx, self, "tag_origin");
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 7, eflags: 0x0
// Checksum 0xff4a1df5, Offset: 0x528
// Size: 0xb6
function soul_capture_zombie_fire(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!isdefined(self.var_f6a6e73d)) {
            self.var_f6a6e73d = util::playfxontag(fieldname, "maps/zm_red/fx8_mq_zmb_torso_blue", self, "j_spine4");
        }
        return;
    }
    if (isdefined(self.var_f6a6e73d)) {
        stopfx(fieldname, self.var_f6a6e73d);
        self.var_f6a6e73d = undefined;
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 7, eflags: 0x0
// Checksum 0xbc37e11e, Offset: 0x5e8
// Size: 0xb6
function soul_capture_zombie_float(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (!isdefined(self.var_cf2d69fa)) {
            self.var_cf2d69fa = util::playfxontag(fieldname, "maps/zm_escape/fx8_wolf_soul_charge_start", self, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_cf2d69fa)) {
        stopfx(fieldname, self.var_cf2d69fa);
        self.var_cf2d69fa = undefined;
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 7, eflags: 0x0
// Checksum 0xb4773623, Offset: 0x6a8
// Size: 0x2b4
function soul_capture_crystal_leave(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.v_base_pos)) {
        self.v_base_pos = self.origin;
    }
    if (bwastimejump == 2) {
        if (!isdefined(self.n_fx)) {
            self playsound(fieldname, #"hash_4ca84d69902e28f0");
            self.var_762fe2b8 = self playloopsound(#"hash_405936dc98db4120");
            self.b_success = 1;
            self.var_3953fe48 = playfx(fieldname, #"hash_20abeff3c8039985", self.v_base_pos, (1, 0, 0), (0, 0, 1));
            self playrumbleonentity(fieldname, "sr_world_event_soul_capture_crystal_leave_rumble");
        }
        return;
    }
    if (bwastimejump == 1) {
        self playsound(fieldname, #"hash_4ca84d69902e28f0");
        self.var_762fe2b8 = self playloopsound(#"hash_405936dc98db4120");
        self.var_a8746926 = playfx(fieldname, #"hash_35db648c6a1e11b9", self.v_base_pos, (0, 0, 1), (1, 0, 0));
        self playrumbleonentity(fieldname, "sr_world_event_soul_capture_crystal_leave_rumble");
        return;
    }
    if (isdefined(self.var_7d46d76d)) {
        self thread function_19c8082b(fieldname);
    }
    if (isdefined(self.var_a8746926)) {
        stopfx(fieldname, self.var_a8746926);
        self.var_a8746926 = undefined;
    }
    if (isdefined(self.var_762fe2b8)) {
        self stoploopsound(self.var_762fe2b8);
        self playsound(fieldname, #"hash_7f3e03d7e76384d1");
        self.var_762fe2b8 = undefined;
    }
    self stoprumble(fieldname, "sr_world_event_soul_capture_crystal_leave_rumble");
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x0
// Checksum 0x9c3c5ec9, Offset: 0x968
// Size: 0xa4
function function_19c8082b(localclientnum) {
    v_base_pos = self.v_base_pos;
    var_7bafdb14 = self.var_3a131b11;
    stopfx(localclientnum, var_7bafdb14);
    var_3a131b11 = playfx(localclientnum, #"hash_6ab1e59eccd24354", v_base_pos, (1, 0, 0), (0, 0, 1));
    wait 3;
    stopfx(localclientnum, var_3a131b11);
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 7, eflags: 0x0
// Checksum 0x1f5be14, Offset: 0xa18
// Size: 0xbe
function soul_capture_crystal_timer(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 2) {
        self.var_23a40178 = 0;
        self thread function_3ac4bafe(fieldname);
        return;
    }
    if (bwastimejump == 1) {
        self.var_23a40178 = 1;
        self thread function_3ac4bafe(fieldname);
        return;
    }
    self notify(#"hash_1c82c1a18aeaec5d");
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x0
// Checksum 0xd3c0f437, Offset: 0xae0
// Size: 0x3a0
function function_3ac4bafe(localclientnum) {
    self notify("65159887d187d761");
    self endon("65159887d187d761");
    self endoncallback(&function_634985a0, #"death", #"hash_1c82c1a18aeaec5d");
    if (!isdefined(self.n_timer)) {
        var_1aee173f = bullettrace(self.origin + (0, 0, 200), self.origin + (0, 0, -10000), 0, self)[#"position"];
        for (i = 0; i < 20; i++) {
            theta = i / 20 * -180 + self.angles[1] - 90;
            var_ea8a7e41 = var_1aee173f + (cos(theta) * 800, sin(theta) * 800, 0);
            var_ea8a7e41 = bullettrace(var_ea8a7e41 + (0, 0, 200), var_ea8a7e41 + (0, 0, -10000), 0, self)[#"position"];
            self.var_9c8a5349[i] = playfx(localclientnum, #"hash_53fa47ea950b4394", var_ea8a7e41, (1, 0, 0), (0, 0, 1));
        }
        self.n_timer = 60;
        self.var_faa93a0b = 0;
        self.var_8f2c9fb8 = self.var_9c8a5349.size - 1;
    }
    var_90807e43 = int(60 / 20 * 2);
    while (self.n_timer > 0) {
        wait 1;
        if (self.var_23a40178) {
            self.n_timer--;
        }
        if (self.n_timer % var_90807e43 == 0) {
            if (isdefined(self.var_9c8a5349[self.var_faa93a0b])) {
                stopfx(localclientnum, self.var_9c8a5349[self.var_faa93a0b]);
            }
            if (isdefined(self.var_9c8a5349[self.var_8f2c9fb8])) {
                stopfx(localclientnum, self.var_9c8a5349[self.var_8f2c9fb8]);
            }
            self.var_faa93a0b++;
            self.var_8f2c9fb8--;
        }
    }
    foreach (n_fx_id in self.var_9c8a5349) {
        stopfx(localclientnum, n_fx_id);
    }
}

// Namespace namespace_63c7213c/namespace_63c7213c
// Params 1, eflags: 0x0
// Checksum 0xcab0b87c, Offset: 0xe88
// Size: 0x98
function function_634985a0(*str_notify) {
    foreach (n_fx_id in self.var_9c8a5349) {
        stopfx(self.localclientnum, n_fx_id);
    }
}

