#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\lightning_chain;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_900a0996;

// Namespace namespace_900a0996/namespace_900a0996
// Params 0, eflags: 0x1 linked
// Checksum 0x4a73183, Offset: 0x198
// Size: 0x194
function function_d4a047b9() {
    if (!is_true(level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_kill_o_watt", #"hash_17fd44c733f7c66b", "t7_icon_zm_aat_dead_wire");
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_d2ca081b, 0, 0);
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_explosion", 1, 1, "counter", &function_d2ca081b, 0, 0);
    clientfield::register("actor", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_846837f, 0, 0);
    clientfield::register("vehicle", "zm_aat_kill_o_watt" + "_zap", 1, 1, "int", &function_846837f, 0, 0);
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 7, eflags: 0x1 linked
// Checksum 0xa809eda8, Offset: 0x338
// Size: 0x196
function function_846837f(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        str_fx_tag = self aat::function_467efa7b(1);
        if (!isdefined(str_fx_tag)) {
            str_fx_tag = "tag_origin";
        }
        self.var_548620a = util::playfxontag(fieldname, "zm_weapons/fx8_aat_elec_torso", self, str_fx_tag);
        self.var_9fddda59 = util::playfxontag(fieldname, "zm_weapons/fx8_aat_elec_eye", self, "j_eyeball_le");
        if (!isdefined(self.var_6a8124b)) {
            self.var_6a8124b = self playloopsound("zmb_aat_kilowatt_stunned_lp");
        }
        return;
    }
    if (isdefined(self.var_548620a)) {
        stopfx(fieldname, self.var_548620a);
        self.var_548620a = undefined;
        stopfx(fieldname, self.var_9fddda59);
        self.var_9fddda59 = undefined;
        if (isdefined(self.var_6a8124b)) {
            self stoploopsound(self.var_6a8124b);
            self.var_6a8124b = undefined;
        }
    }
}

// Namespace namespace_900a0996/namespace_900a0996
// Params 7, eflags: 0x1 linked
// Checksum 0xb096f257, Offset: 0x4d8
// Size: 0xd4
function function_d2ca081b(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self)) {
        v_fx_origin = self gettagorigin(self aat::function_467efa7b(1));
        if (!isdefined(v_fx_origin)) {
            v_fx_origin = self.origin;
        }
        playfx(bwastimejump, "zm_weapons/fx8_aat_elec_exp", v_fx_origin);
        self playsound(bwastimejump, #"zmb_aat_kilowatt_explode");
    }
}

