#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_tomahawk;

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x2
// Checksum 0xbf4610ad, Offset: 0x1d0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_tomahawk", &__init__, undefined, undefined);
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 0, eflags: 0x0
// Checksum 0xf69fedc, Offset: 0x218
// Size: 0x522
function __init__() {
    clientfield::register("toplayer", "tomahawk_in_use", 1, 2, "int", &tomahawk_in_use, 0, 1);
    clientfield::register("toplayer", "" + #"upgraded_tomahawk_in_use", 1, 1, "int", &tomahawk_in_use, 0, 1);
    clientfield::register("scriptmover", "play_tomahawk_fx", 1, 2, "int", &play_tomahawk_pickup_fx, 0, 0);
    clientfield::register("actor", "play_tomahawk_hit_sound", 1, 1, "int", &function_5f1d3a31, 0, 0);
    clientfield::register("toplayer", "tomahawk_rumble", 1, 2, "counter", &tomahawk_rumble, 0, 0);
    clientfield::register("actor", "tomahawk_impact_fx", 1, 2, "int", &tomahawk_impact_fx, 0, 0);
    clientfield::register("allplayers", "tomahawk_charge_up_fx", 1, 2, "counter", &tomahawk_charge_up_fx, 0, 0);
    var_2a409e1b = getminbitcountfornum(3);
    clientfield::register("scriptmover", "tomahawk_trail_fx", 1, var_2a409e1b, "int", &tomahawk_trail_fx, 0, 0);
    clientfield::register("missile", "tomahawk_trail_fx", 1, var_2a409e1b, "int", &tomahawk_trail_fx, 0, 0);
    setupclientfieldcodecallbacks("toplayer", 1, "tomahawk_in_use");
    setupclientfieldcodecallbacks("toplayer", 1, "" + #"upgraded_tomahawk_in_use");
    level._effect[#"tomahawk_pickup"] = #"hash_589d0bc9c10726fb";
    level._effect[#"tomahawk_pickup_upgrade"] = #"zombie/fx_powerup_on_solo_zmb";
    level._effect[#"tomahawk_trail"] = #"hash_77b995b902df3cd9";
    level._effect[#"tomahawk_trail_ug"] = #"hash_5384d01e513526";
    level._effect[#"tomahawk_charged_trail"] = #"hash_3d47ab5cd1e7b732";
    level._effect[#"hash_f0d62b29afe4b7c"] = #"hash_5c8911bafb8efe53";
    level._effect[#"tomahawk_impact"] = #"hash_681b2b47d9fb71c9";
    level._effect[#"tomahawk_impact_ug"] = #"hash_26ef5fefeb29c436";
    level._effect[#"tomahawk_fire_dot"] = #"hash_5686def5b4c85661";
    level._effect[#"tomahawk_charge_up"] = #"hash_909f7d24e4e84e3";
    level._effect[#"tomahawk_charge_up_ug"] = #"hash_de4b918ea7d5e3c";
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0x57df74eb, Offset: 0x748
// Size: 0x84
function tomahawk_in_use(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    /#
        if (newval == 1) {
            iprintlnbold("<dev string:x30>");
            return;
        }
        iprintlnbold("<dev string:x42>");
    #/
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0x7536371d, Offset: 0x7d8
// Size: 0x23a
function play_tomahawk_pickup_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self util::waittill_dobj(localclientnum);
    if (bwasdemojump) {
        if (newval == 1) {
            if (isdefined(self.n_fx_id)) {
                stopfx(localclientnum, self.n_fx_id);
                self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
            }
            return;
        }
        if (newval == 2) {
            if (isdefined(self.n_fx_id)) {
                stopfx(localclientnum, self.n_fx_id);
                self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
            }
        }
        return;
    }
    if (newval == 1) {
        if (isdefined(self.n_fx_id)) {
            stopfx(localclientnum, self.n_fx_id);
        }
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
        return;
    }
    if (newval == 2) {
        if (isdefined(self.n_fx_id)) {
            stopfx(localclientnum, self.n_fx_id);
        }
        self.n_fx_id = util::playfxontag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0x4c130273, Offset: 0xa20
// Size: 0x7c
function function_5f1d3a31(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self playsound(localclientnum, #"wpn_tomahawk_impact", self.origin + (0, 0, 75));
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0xbb9b4506, Offset: 0xaa8
// Size: 0x1ea
function tomahawk_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_624ebdc7)) {
        deletefx(localclientnum, self.n_trail_fx, 1);
        self.n_trail_fx = undefined;
    }
    if (!isdefined(self.var_81f1d8d4)) {
        self.var_81f1d8d4 = self playloopsound(#"hash_5e3cfa1a476b30c4");
    }
    if (newval == 1) {
        self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"tomahawk_trail"], self, "tag_fx");
        return;
    }
    if (newval == 2) {
        self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"tomahawk_trail_ug"], self, "tag_fx");
        return;
    }
    if (newval == 3) {
        self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"tomahawk_charged_trail"], self, "tag_fx");
        return;
    }
    if (newval == 4) {
        self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"hash_f0d62b29afe4b7c"], self, "tag_fx");
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0xfc025b05, Offset: 0xca0
// Size: 0x1c4
function tomahawk_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_415f4b07)) {
        deletefx(localclientnum, self.var_415f4b07, 1);
        self.var_415f4b07 = undefined;
    }
    str_tag = "J_Head";
    var_4212efc0 = "j_spineupper";
    if (self.archetype == "zombie_dog") {
        str_tag = "J_Head";
        var_4212efc0 = "J_Spine1";
    }
    if (newval == 1) {
        self.var_415f4b07 = util::playfxontag(localclientnum, level._effect[#"tomahawk_impact"], self, str_tag);
        util::playfxontag(localclientnum, level._effect[#"tomahawk_fire_dot"], self, var_4212efc0);
        return;
    }
    if (newval == 2) {
        self.var_415f4b07 = util::playfxontag(localclientnum, level._effect[#"tomahawk_impact_ug"], self, str_tag);
        util::playfxontag(localclientnum, level._effect[#"tomahawk_fire_dot"], self, var_4212efc0);
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0x1fa224bc, Offset: 0xe70
// Size: 0x134
function tomahawk_charge_up_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_ebad8041)) {
        deletefx(localclientnum, self.var_ebad8041, 1);
        self.var_ebad8041 = undefined;
    }
    if (newval == 1) {
        self.var_ebad8041 = util::playfxontag(localclientnum, level._effect[#"tomahawk_charge_up"], self, "tag_origin");
        self thread function_f55dbec1();
        return;
    }
    if (newval == 2) {
        self.var_ebad8041 = util::playfxontag(localclientnum, level._effect[#"tomahawk_charge_up_ug"], self, "tag_origin");
        self thread function_f55dbec1();
    }
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 1, eflags: 0x0
// Checksum 0x8fcb9972, Offset: 0xfb0
// Size: 0xb6
function function_f55dbec1(localclientnum) {
    self notify(#"hash_5de847b4a6f10108");
    self endon(#"hash_5de847b4a6f10108");
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.var_64de9cf6)) {
        self.var_64de9cf6 = 1;
    }
    self playsound(0, "wpn_tomahawk_charge_" + self.var_64de9cf6);
    self.var_64de9cf6++;
    wait 1.5;
    self.var_64de9cf6 = 1;
}

// Namespace zm_weap_tomahawk/zm_weap_tomahawk
// Params 7, eflags: 0x0
// Checksum 0xa5250b58, Offset: 0x1070
// Size: 0xc2
function tomahawk_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        switch (newvalue) {
        case 1:
            self playrumbleonentity(localclientnum, "zm_weap_chakram_catch_rumble");
            break;
        case 2:
            self playrumbleonentity(localclientnum, "zm_weap_chakram_throw_rumble");
            break;
        }
    }
}

