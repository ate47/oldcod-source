#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;

#namespace zm_ai_stoker;

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x2
// Checksum 0xe5a96930, Offset: 0x2a8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_ai_stoker", &__init__, undefined, undefined);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 0, eflags: 0x0
// Checksum 0xcb6fbcf, Offset: 0x2f0
// Size: 0x174
function __init__() {
    if (ai::shouldregisterclientfieldforarchetype("stoker")) {
        clientfield::register("actor", "crit_spot_reveal_clientfield", 1, getminbitcountfornum(4), "int", &crit_spot_reveal, 0, 0);
        clientfield::register("actor", "stoker_fx_start_clientfield", 1, 3, "int", &stoker_fx_start, 0, 0);
        clientfield::register("actor", "stoker_fx_stop_clientfield", 1, 3, "int", &stoker_fx_stop, 0, 0);
        clientfield::register("actor", "stoker_death_explosion", 1, 2, "int", &stoker_death_explosion, 0, 0);
    }
    ai::add_archetype_spawn_function("stoker", &stoker_spawn_init);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x0
// Checksum 0xb24e2a34, Offset: 0x470
// Size: 0x64
function stoker_spawn_init(localclientnum) {
    self._eyeglow_fx_override = "zm_ai/fx8_stoker_eye_glow";
    self._eyeglow_tag_override = "tag_eye";
    self zm::createzombieeyes(localclientnum);
    self callback::on_shutdown(&on_entity_shutdown);
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x0
// Checksum 0xd7c46879, Offset: 0x4e0
// Size: 0x2c
function on_entity_shutdown(localclientnum) {
    if (isdefined(self)) {
        self zm::deletezombieeyes(localclientnum);
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 7, eflags: 0x4
// Checksum 0x60497693, Offset: 0x518
// Size: 0x9c
function private crit_spot_reveal(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self mapshaderconstant(localclientnum, 0, "scriptVector" + newvalue, 0, 1, 0, 0);
        self playsound(0, #"hash_9cde96bded002d5");
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 7, eflags: 0x4
// Checksum 0x33b22b52, Offset: 0x5c0
// Size: 0x2f2
function private stoker_fx_start(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (!isdefined(self.currentfx)) {
        self.currentfx = [];
    }
    if (!self hasdobj(localclientnum)) {
        return;
    }
    switch (newvalue) {
    case 1:
        break;
    case 2:
        if (!isdefined(self.currentfx[2])) {
            self.currentfx[2] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_charge_shovel", self, "tag_fx_shovel");
        }
        break;
    case 3:
        if (!isdefined(self.currentfx[3])) {
            self.currentfx[3] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_clavicle_le");
            self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
        }
        break;
    case 4:
        if (!isdefined(self.currentfx[4])) {
            self.currentfx[4] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_clavicle_ri");
            self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
        }
        break;
    case 5:
        if (!isdefined(self.currentfx[5])) {
            self.currentfx[4] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_head");
            self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
        }
        break;
    case 6:
        if (!isdefined(self.currentfx[6])) {
            self.currentfx[6] = util::playfxontag(localclientnum, "zm_ai/fx8_stoker_dmg_weak_point", self, "j_wrist_le");
            self playsound(localclientnum, #"hash_2dc7f5a5e2c5af20");
        }
        break;
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 7, eflags: 0x4
// Checksum 0xd760a542, Offset: 0x8c0
// Size: 0x252
function private stoker_fx_stop(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (!isdefined(self.currentfx)) {
        self.currentfx = [];
    }
    if (!self hasdobj(localclientnum)) {
        return;
    }
    switch (newvalue) {
    case 1:
        break;
    case 2:
        if (isdefined(self.currentfx[2])) {
            stopfx(localclientnum, self.currentfx[2]);
        }
        self.currentfx[2] = undefined;
        break;
    case 3:
        if (isdefined(self.currentfx[3])) {
            stopfx(localclientnum, self.currentfx[3]);
        }
        self.currentfx[3] = undefined;
        break;
    case 4:
        if (isdefined(self.currentfx[4])) {
            stopfx(localclientnum, self.currentfx[4]);
        }
        self.currentfx[4] = undefined;
        break;
    case 5:
        if (isdefined(self.currentfx[5])) {
            stopfx(localclientnum, self.currentfx[5]);
        }
        self.currentfx[5] = undefined;
        break;
    case 6:
        if (isdefined(self.currentfx[6])) {
            stopfx(localclientnum, self.currentfx[6]);
        }
        self.currentfx[6] = undefined;
        break;
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 7, eflags: 0x0
// Checksum 0xab7f4b7e, Offset: 0xb20
// Size: 0x152
function stoker_death_explosion(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    switch (newvalue) {
    case 1:
        util::lock_model("c_t8_zmb_titanic_stoker_body1_gibbed");
        self thread function_81f2c6c("c_t8_zmb_titanic_stoker_body1_gibbed");
        break;
    case 2:
        self notify(#"unlock_model");
        physicsexplosionsphere(localclientnum, self gettagorigin("j_shoulder_le"), 400, 0, 3);
        self thread function_1bfade3a(localclientnum);
        playsound(localclientnum, #"hash_5c4876ace1c2aa10", self gettagorigin("j_shoulder_le"));
        break;
    }
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0x80b99918, Offset: 0xc80
// Size: 0x446
function private function_1bfade3a(localclientnum) {
    var_c35705dc = self.origin;
    var_7a968a14 = self gettagorigin("j_knee_le");
    var_344e62fa = self gettagangles("j_knee_le");
    var_6dab3690 = self gettagorigin("j_clavicle_le");
    var_aead115e = self gettagangles("j_clavicle_le");
    var_141745d2 = self gettagorigin("j_shouldertwist_le");
    var_347905d4 = self gettagangles("j_shouldertwist_le");
    var_9a648048 = [];
    if (!isdefined(var_9a648048)) {
        var_9a648048 = [];
    } else if (!isarray(var_9a648048)) {
        var_9a648048 = array(var_9a648048);
    }
    var_9a648048[var_9a648048.size] = vectornormalize(anglestoforward(self.angles));
    if (!isdefined(var_9a648048)) {
        var_9a648048 = [];
    } else if (!isarray(var_9a648048)) {
        var_9a648048 = array(var_9a648048);
    }
    var_9a648048[var_9a648048.size] = vectornormalize(anglestoright(self.angles));
    if (!isdefined(var_9a648048)) {
        var_9a648048 = [];
    } else if (!isarray(var_9a648048)) {
        var_9a648048 = array(var_9a648048);
    }
    var_9a648048[var_9a648048.size] = var_9a648048[1] * -1;
    var_9a648048 = array::randomize(var_9a648048);
    var_91bd3e3d = var_9a648048[0] + (0, 0, randomfloatrange(0.4, 0.8));
    e_clavicle = createdynentandlaunch(localclientnum, "c_t8_zmb_titanic_stoker_clavicle1_gibbed", var_6dab3690, var_aead115e, var_6dab3690, var_91bd3e3d * randomfloatrange(0.6, 1.2));
    wait 0.1;
    var_91bd3e3d = var_9a648048[1] + (0, 0, randomfloatrange(0.4, 0.8));
    e_arm = createdynentandlaunch(localclientnum, "c_t8_zmb_titanic_stoker_upperarm1_gibbed", var_141745d2, var_347905d4, var_141745d2, var_91bd3e3d * randomfloatrange(0.6, 1.2));
    wait 0.1;
    var_91bd3e3d = var_9a648048[2] + (0, 0, randomfloatrange(0.4, 0.8));
    e_boot = createdynentandlaunch(localclientnum, "c_t8_zmb_titanic_stoker_boot1_gibbed", var_7a968a14, var_344e62fa, var_7a968a14, var_91bd3e3d * randomfloatrange(0.6, 1.2));
}

// Namespace zm_ai_stoker/zm_ai_stoker
// Params 1, eflags: 0x4
// Checksum 0xa8656bb2, Offset: 0x10d0
// Size: 0x4c
function private function_81f2c6c(model) {
    self waittilltimeout(10, #"death", #"unlock_model");
    util::unlock_model(model);
}

