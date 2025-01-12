#using scripts\core_common\aat_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_aat_brain_decay;

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 0, eflags: 0x2
// Checksum 0x6bb5986c, Offset: 0x198
// Size: 0x34
function autoexec __init__system__() {
    system::register("zm_aat_brain_decay", &__init__, undefined, undefined);
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 0, eflags: 0x0
// Checksum 0x83b8f161, Offset: 0x1d8
// Size: 0x1ac
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_brain_decay", #"hash_3c1c6f0860be6c5", "t7_icon_zm_aat_turned");
    clientfield::register("actor", "zm_aat_brain_decay", 1, 1, "int", &function_a356b695, 0, 0);
    clientfield::register("vehicle", "zm_aat_brain_decay", 1, 1, "int", &function_a356b695, 0, 0);
    clientfield::register("actor", "zm_aat_brain_decay_exp", 1, 1, "counter", &zm_aat_brain_decay_explosion, 0, 0);
    clientfield::register("vehicle", "zm_aat_brain_decay_exp", 1, 1, "counter", &zm_aat_brain_decay_explosion, 0, 0);
    renderoverridebundle::function_9f4eff5e(#"hash_5afb2d74423459bf", "rob_sonar_set_friendly_zm", &function_22d07f48);
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 7, eflags: 0x0
// Checksum 0xa19b0755, Offset: 0x390
// Size: 0x26c
function function_a356b695(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self renderoverridebundle::function_15e70783(localclientnum, #"zm_friendly", #"hash_5afb2d74423459bf");
    if (newval) {
        self setdrawname(#"hash_3a9d51a39880facd", 1);
        self.var_6ed9e89f = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_brain_decay_eye", self, "j_eyeball_le");
        self.var_c41a0072 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_brain_decay_torso", self, self zm_utility::function_a7776589(1));
        if (!isdefined(self.var_2b23054b)) {
            self.var_2b23054b = self playloopsound(#"hash_6064261162c8a2e");
        }
        if (isdefined(self.var_e015d462)) {
            self [[ self.var_e015d462 ]](localclientnum, newval);
        }
        return;
    }
    if (isdefined(self.var_6ed9e89f)) {
        stopfx(localclientnum, self.var_6ed9e89f);
        self.var_6ed9e89f = undefined;
    }
    if (isdefined(self.var_77537613)) {
        stopfx(localclientnum, self.var_77537613);
        self.var_77537613 = undefined;
    }
    if (isdefined(self.var_c41a0072)) {
        stopfx(localclientnum, self.var_c41a0072);
        self.var_c41a0072 = undefined;
    }
    if (isdefined(self.var_2b23054b)) {
        self stoploopsound(self.var_2b23054b);
        self.var_2b23054b = undefined;
    }
    if (isdefined(self.var_e015d462)) {
        self [[ self.var_e015d462 ]](localclientnum, newval);
    }
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 2, eflags: 0x0
// Checksum 0xc20e9489, Offset: 0x608
// Size: 0x5a
function function_22d07f48(localclientnum, str_bundle) {
    if (!self function_31d3dfec() || isdefined(level.var_fc04f28d) && level.var_fc04f28d) {
        return false;
    }
    return true;
}

// Namespace zm_aat_brain_decay/zm_aat_brain_decay
// Params 7, eflags: 0x0
// Checksum 0x4a507303, Offset: 0x670
// Size: 0x84
function zm_aat_brain_decay_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, "zm_weapons/fx8_aat_brain_decay_head", self, "j_head");
    self playsound(0, #"hash_422ccb7ddff9b3f4");
}

