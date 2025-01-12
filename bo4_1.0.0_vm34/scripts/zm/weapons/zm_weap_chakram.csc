#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_chakram;

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x2
// Checksum 0x808c1f71, Offset: 0x280
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_chakram", &__init__, undefined, undefined);
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 0, eflags: 0x0
// Checksum 0x9bf8a213, Offset: 0x2c8
// Size: 0x67a
function __init__() {
    clientfield::register("actor", "zombie_slice_right", 1, 2, "counter", &function_bbeb4c2c, 1, 0);
    clientfield::register("actor", "zombie_slice_left", 1, 2, "counter", &function_38924d95, 1, 0);
    clientfield::register("allplayers", "chakram_melee_hit", 1, 1, "counter", &chakram_melee_hit, 1, 0);
    clientfield::register("actor", "chakram_head_pop_fx", 1, 1, "int", &chakram_head_pop_fx, 1, 0);
    clientfield::register("vehicle", "chakram_head_pop_fx", 1, 1, "int", &chakram_head_pop_fx, 1, 0);
    clientfield::register("scriptmover", "chakram_throw_trail_fx", 1, 1, "int", &chakram_throw_trail_fx, 0, 0);
    clientfield::register("scriptmover", "chakram_throw_impact_fx", 1, 1, "int", &chakram_throw_impact_fx, 0, 0);
    clientfield::register("actor", "chakram_throw_special_impact_fx", 1, 1, "counter", &chakram_throw_special_impact_fx, 0, 0);
    clientfield::register("allplayers", "chakram_whirlwind_fx", 1, 1, "int", &chakram_whirlwind_fx, 0, 0);
    clientfield::register("actor", "chakram_whirlwind_shred_fx", 1, 1, "counter", &chakram_whirlwind_shred_fx, 1, 0);
    clientfield::register("vehicle", "chakram_whirlwind_shred_fx", 1, 1, "counter", &chakram_whirlwind_shred_fx, 1, 0);
    clientfield::register("toplayer", "chakram_speed_buff_postfx", 1, 1, "counter", &chakram_speed_buff_postfx, 0, 0);
    clientfield::register("toplayer", "chakram_rumble", 1, 3, "counter", &chakram_rumble, 0, 0);
    level._effect[#"sword_bloodswipe_r_1p"] = #"zombie/fx_sword_slash_right_1p_zod_zmb";
    level._effect[#"sword_bloodswipe_l_1p"] = #"zombie/fx_sword_slash_left_1p_zod_zmb";
    level._effect[#"hash_720f204e4406ddbf"] = #"hash_59cdb0226e644934";
    level._effect[#"hash_15593b3f860346f5"] = #"hash_1e957556dba822e6";
    level._effect[#"hash_5f9bb382a47d637d"] = #"hash_68100f653a5baf2f";
    level._effect[#"hash_6dca5478f1baf5ce"] = #"hash_1ff88e4b147015b2";
    level._effect[#"hash_3364e81f269deca0"] = #"hash_656272f0184ae1fc";
    level._effect[#"hash_5c2ba805602ea484"] = #"hash_3904517ed3636935";
    level._effect[#"hash_455a47023bc1da46"] = #"hash_2109d3278a7b54fa";
    level._effect[#"hash_bc1e5225071e47d"] = #"hash_2ca473741924f0c";
    level._effect[#"hash_29c798afb4256dc0"] = #"hash_37cfda7fcc57f0f";
    level._effect[#"hash_6759261c70e31d0a"] = #"hash_2103c7278a76d4e8";
    level._effect[#"hash_6ac964121fa8b4bf"] = #"hash_212ef7da466574ba";
    level._effect[#"hash_49a09babc9ee918a"] = #"hash_1ac3342ef816a481";
    level._effect[#"hash_c995c57914ab2b4"] = #"hash_1157c7544a4dd8cf";
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0xfbc35bcb, Offset: 0x950
// Size: 0xb4
function function_bbeb4c2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        if (newval == 1) {
            util::playfxontag(localclientnum, level._effect[#"sword_bloodswipe_r_1p"], self, "j_spine4");
        }
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x3b8a4012, Offset: 0xa10
// Size: 0xb4
function function_38924d95(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (util::is_mature() && !util::is_gib_restricted_build()) {
        if (newval == 1) {
            util::playfxontag(localclientnum, level._effect[#"sword_bloodswipe_l_1p"], self, "j_spine4");
        }
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0xd1cbe20a, Offset: 0xad0
// Size: 0x90
function chakram_melee_hit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        playviewmodelfx(localclientnum, level._effect[#"hash_15593b3f860346f5"], "tag_fx8");
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x8378b1, Offset: 0xb68
// Size: 0x7c
function chakram_head_pop_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"hash_5f9bb382a47d637d"], self, "j_head");
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x54ce7710, Offset: 0xbf0
// Size: 0x126
function chakram_throw_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.fx_trail = util::playfxontag(localclientnum, level._effect[#"hash_6dca5478f1baf5ce"], self, "tag_fx");
        if (!isdefined(self.snd_looper)) {
            self.snd_looper = self playloopsound(#"hash_3cd6bae1469848f1", 1);
        }
        return;
    }
    if (isdefined(self.fx_trail)) {
        stopfx(localclientnum, self.fx_trail);
    }
    if (isdefined(self.snd_looper)) {
        self stoploopsound(self.snd_looper);
        self.snd_looper = undefined;
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x424d6e49, Offset: 0xd20
// Size: 0xac
function chakram_throw_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect[#"hash_3364e81f269deca0"], self.origin, self.angles);
        playsound(localclientnum, #"hash_72a17706cb2656cd", self.origin);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x15cfda17, Offset: 0xdd8
// Size: 0xa4
function chakram_throw_special_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        util::playfxontag(localclientnum, level._effect[#"hash_3364e81f269deca0"], self, "j_spine4");
        playsound(localclientnum, #"hash_72a17706cb2656cd", self.origin);
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x716da7a6, Offset: 0xe88
// Size: 0x5c
function chakram_speed_buff_postfx(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    self thread postfx::playpostfxbundle(#"hash_1663ca7cc81f9b17");
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x13f618c6, Offset: 0xef0
// Size: 0x3ac
function chakram_whirlwind_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_eda6d4f7)) {
            self.var_eda6d4f7 = self playloopsound(#"hash_75e91bf08cd631e8");
        }
        self.var_b7a8a266 = util::playfxontag(localclientnum, level._effect[#"hash_c995c57914ab2b4"], self, "j_spine4");
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.var_bf0367e2 = playfxoncamera(localclientnum, level._effect[#"hash_6759261c70e31d0a"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
            self thread postfx::playpostfxbundle(#"pstfx_zm_chakram_whirlwind");
            self playrumblelooponentity(localclientnum, "zm_weap_chakram_whirlwind_rumble");
        } else {
            util::playfxontag(localclientnum, level._effect[#"hash_5c2ba805602ea484"], self, "tag_origin");
            wait 1;
            if (isdefined(self) && !isdefined(self.var_bf0367e2)) {
                self.var_bf0367e2 = util::playfxontag(localclientnum, level._effect[#"hash_455a47023bc1da46"], self, "tag_origin");
            }
        }
        return;
    }
    self playsound(localclientnum, #"hash_4f78bd85d9a43e3c");
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        self postfx::stoppostfxbundle("pstfx_zm_chakram_whirlwind");
        self stoprumble(localclientnum, "zm_weap_chakram_whirlwind_rumble");
    }
    if (isdefined(self.var_eda6d4f7)) {
        self stoploopsound(self.var_eda6d4f7);
        self.var_eda6d4f7 = undefined;
    }
    if (isdefined(self.var_b7a8a266)) {
        stopfx(localclientnum, self.var_b7a8a266);
    }
    if (isdefined(self.var_bf0367e2)) {
        stopfx(localclientnum, self.var_bf0367e2);
        self.var_bf0367e2 = undefined;
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            playfxoncamera(localclientnum, level._effect[#"hash_6ac964121fa8b4bf"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
            return;
        }
        util::playfxontag(localclientnum, level._effect[#"hash_bc1e5225071e47d"], self, "tag_origin");
    }
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0x474cebc2, Offset: 0x12a8
// Size: 0x74
function chakram_whirlwind_shred_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::playfxontag(localclientnum, level._effect[#"hash_49a09babc9ee918a"], self, "j_spine4");
}

// Namespace zm_weap_chakram/zm_weap_chakram
// Params 7, eflags: 0x0
// Checksum 0xb6405692, Offset: 0x1328
// Size: 0xfa
function chakram_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        switch (newvalue) {
        case 2:
            self playrumbleonentity(localclientnum, "zm_weap_chakram_catch_rumble");
            break;
        case 4:
            self playrumbleonentity(localclientnum, "zm_weap_chakram_melee_rumble");
            break;
        case 5:
            self playrumbleonentity(localclientnum, "zm_weap_chakram_throw_rumble");
            break;
        }
    }
}

