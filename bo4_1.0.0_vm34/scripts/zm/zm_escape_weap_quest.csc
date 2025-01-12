#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\weapons\zm_weap_tomahawk;
#using scripts\zm_common\zm_utility;

#namespace zm_escape_weap_quest;

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x2
// Checksum 0x244f6006, Offset: 0x1e0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_escape_weap_quest", &__init__, undefined, undefined);
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 0, eflags: 0x0
// Checksum 0x5aef0c6f, Offset: 0x228
// Size: 0x322
function __init__() {
    n_bits = getminbitcountfornum(4);
    clientfield::register("scriptmover", "" + #"hash_5ecbfb9042fc7f38", 1, 1, "int", &function_ae9df213, 0, 0);
    clientfield::register("actor", "" + #"hash_588871862d19b97d", 1, 1, "int", &function_6f2273c2, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_2be4ce9b84bd3b58", 1, 1, "counter", &function_56319967, 0, 0);
    clientfield::register("actor", "" + #"hash_338ecd1287d0623b", 1, 1, "counter", &function_10ba8e30, 0, 0);
    clientfield::register("scriptmover", "" + #"tomahawk_pickup_fx", 1, n_bits, "int", &function_5c41cd66, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_51657261e835ac7c", 1, n_bits, "int", &function_240e9f6d, 0, 0);
    level._effect[#"hell_portal"] = "maps/zm_escape/fx8_wolf_portal_hell";
    level._effect[#"hell_portal_close"] = "maps/zm_escape/fx8_wolf_portal_hell_close";
    level._effect[#"soul_charged"] = "maps/zm_escape/fx8_wolf_soul_charged";
    level._effect[#"soul_charge_start"] = "maps/zm_escape/fx8_wolf_soul_charge_start";
    level._effect[#"soul_charge_impact"] = "maps/zm_escape/fx8_wolf_soul_charge_impact_sm";
    level._effect[#"wolf_bite_blood"] = "maps/zm_escape/fx8_wolf_soul_charge_impact";
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 7, eflags: 0x0
// Checksum 0xb6915299, Offset: 0x558
// Size: 0x24a
function function_ae9df213(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_4b0e0833)) {
            stopfx(localclientnum, self.var_4b0e0833);
        }
        self.var_4b0e0833 = util::playfxontag(localclientnum, level._effect[#"hell_portal"], self, "tag_origin");
        self playsound(localclientnum, #"hash_6e048d37333004da");
        if (!isdefined(self.var_951bec56)) {
            self.var_951bec56 = self playloopsound(#"hash_f80ff339436a985");
        }
        return;
    }
    if (isdefined(self.var_4b0e0833)) {
        stopfx(localclientnum, self.var_4b0e0833);
        self.var_4b0e0833 = undefined;
    }
    self playsound(localclientnum, #"hash_4435f84f2c7dd54f");
    if (isdefined(self.var_951bec56)) {
        self stoploopsound(self.var_951bec56);
    }
    self.var_4b0e0833 = util::playfxontag(localclientnum, level._effect[#"hell_portal_close"], self, "tag_origin");
    wait 0.5;
    if (isdefined(self.var_59782c3d)) {
        stopfx(localclientnum, self.var_59782c3d);
    }
    self.var_59782c3d = util::playfxontag(localclientnum, level._effect[#"soul_charged"], self, "tag_origin");
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 7, eflags: 0x0
// Checksum 0x63ad591e, Offset: 0x7b0
// Size: 0xee
function function_6f2273c2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (isdefined(self.var_ea2c1a2)) {
            stopfx(localclientnum, self.var_ea2c1a2);
        }
        self.var_ea2c1a2 = util::playfxontag(localclientnum, level._effect[#"soul_charge_start"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_ea2c1a2)) {
        stopfx(localclientnum, self.var_ea2c1a2);
        self.var_ea2c1a2 = undefined;
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 7, eflags: 0x0
// Checksum 0xf4f53ee9, Offset: 0x8a8
// Size: 0xa2
function function_56319967(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_415f4b07)) {
        stopfx(localclientnum, self.var_415f4b07);
    }
    self.var_415f4b07 = util::playfxontag(localclientnum, level._effect[#"soul_charge_impact"], self, "TAG_MOUTH_FX");
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 7, eflags: 0x0
// Checksum 0x1f589a93, Offset: 0x958
// Size: 0xa2
function function_10ba8e30(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_415f4b07)) {
        stopfx(localclientnum, self.var_415f4b07);
    }
    self.var_415f4b07 = util::playfxontag(localclientnum, level._effect[#"wolf_bite_blood"], self, "tag_origin");
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 7, eflags: 0x0
// Checksum 0xe66f1c95, Offset: 0xa08
// Size: 0x13a
function function_5c41cd66(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 0) {
        if (isdefined(self.n_fx_id)) {
            killfx(localclientnum, self.n_fx_id);
            self.n_fx_id = undefined;
        }
        return;
    }
    if (newval > 0) {
        e_player = getentbynum(localclientnum, newval - 1);
        a_e_players = getlocalplayers();
        if (array::contains(a_e_players, e_player)) {
            self.n_fx_id = playfx(localclientnum, level._effect[#"tomahawk_pickup"], self.origin - (0, 0, 24));
        }
    }
}

// Namespace zm_escape_weap_quest/zm_escape_weap_quest
// Params 7, eflags: 0x0
// Checksum 0x9d936d7, Offset: 0xb50
// Size: 0x122
function function_240e9f6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 0) {
        if (isdefined(self.var_9968204f)) {
            killfx(localclientnum, self.var_9968204f);
            self.var_9968204f = undefined;
        }
        return;
    }
    e_player = getentbynum(localclientnum, newval - 1);
    a_e_players = getlocalplayers();
    if (array::contains(a_e_players, e_player)) {
        self.var_9968204f = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup_upgrade"], self, "tag_origin");
    }
}

