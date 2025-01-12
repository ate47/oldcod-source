#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_lightning_chain;
#using scripts\zm_common\zm_utility;

#namespace zm_aat_kill_o_watt;

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 0, eflags: 0x2
// Checksum 0x9eef1361, Offset: 0x170
// Size: 0x34
function autoexec __init__system__() {
    system::register("zm_aat_kill_o_watt", &__init__, undefined, undefined);
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 0, eflags: 0x0
// Checksum 0x19ba27a, Offset: 0x1b0
// Size: 0x194
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_kill_o_watt", #"hash_17fd44c733f7c66b", "t7_icon_zm_aat_dead_wire");
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_fed63439, 0, 0);
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_fed63439, 0, 0);
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_33ee68a9, 0, 0);
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_33ee68a9, 0, 0);
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 7, eflags: 0x0
// Checksum 0xc860bc0c, Offset: 0x350
// Size: 0x16e
function function_33ee68a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_f0ebe9c = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_elec_torso", self, self zm_utility::function_a7776589(1));
        self.var_5d789256 = util::playfxontag(localclientnum, "zm_weapons/fx8_aat_elec_eye", self, "j_eyeball_le");
        if (!isdefined(self.var_9705bfd5)) {
            self.var_9705bfd5 = self playloopsound("zmb_aat_kilowatt_stunned_lp");
        }
        return;
    }
    if (isdefined(self.var_f0ebe9c)) {
        stopfx(localclientnum, self.var_f0ebe9c);
        self.var_f0ebe9c = undefined;
        stopfx(localclientnum, self.var_5d789256);
        self.var_5d789256 = undefined;
        if (isdefined(self.var_9705bfd5)) {
            self stoploopsound(self.var_9705bfd5);
            self.var_9705bfd5 = undefined;
        }
    }
}

// Namespace zm_aat_kill_o_watt/zm_aat_kill_o_watt
// Params 7, eflags: 0x0
// Checksum 0x5ee6ab37, Offset: 0x4c8
// Size: 0xa4
function function_fed63439(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, "zm_weapons/fx8_aat_elec_exp", self gettagorigin(self zm_utility::function_a7776589()));
    self playsound(localclientnum, #"zmb_aat_kilowatt_explode");
}

