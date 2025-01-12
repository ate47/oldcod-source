#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_silver_main_quest;

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xca801395, Offset: 0xa0
// Size: 0x11c
function init() {
    if (!zm_utility::is_ee_enabled()) {
        return;
    }
    clientfield::register("scriptmover", "" + #"hash_8358a32177aa60e", 1, 1, "int", &function_f03e2a9, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_6ac50b8c31412793", 1, 1, "int", &function_fde99b33, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_654274a0648df21d", 1, 1, "int", &function_779a8e5b, 0, 0);
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x4aaa7307, Offset: 0x1c8
// Size: 0xac
function function_f03e2a9(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        self.var_ea21645e = util::playfxontag(fieldname, #"hash_2421d7984fb8e652", self, "tag_origin");
        return;
    }
    if (isdefined(self.var_ea21645e)) {
        stopfx(fieldname, self.var_ea21645e);
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x4b7a0ef4, Offset: 0x280
// Size: 0x74
function function_fde99b33(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        util::playfxontag(fieldname, #"zombie/fx_powerup_on_caution_zmb", self, "tag_origin");
    }
}

// Namespace zm_silver_main_quest/zm_silver_main_quest
// Params 7, eflags: 0x1 linked
// Checksum 0x8db1e686, Offset: 0x300
// Size: 0x74
function function_779a8e5b(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        util::playfxontag(fieldname, #"hash_b7f3ee30d88e1bc", self, "tag_origin");
    }
}

