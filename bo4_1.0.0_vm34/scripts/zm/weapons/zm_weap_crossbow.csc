#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_hero_weapon;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_weap_crossbow;

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x2
// Checksum 0x3eeea81f, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_crossbow", &__init__, undefined, undefined);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 0, eflags: 0x0
// Checksum 0x29fee938, Offset: 0x1b8
// Size: 0x394
function __init__() {
    level._effect[#"hash_37c2ef99d645cf87"] = #"hash_446cf10b26252043";
    level._effect[#"hash_690509b9a2ec2ef3"] = #"hash_446cf10b26252043";
    level._effect[#"hash_25f2b145ee5374d9"] = #"hash_72432f697d87397d";
    level._effect[#"hash_70d2a1e399efcc91"] = #"hash_50be4928aa2fb3d4";
    level._effect[#"hash_70d98de399f5c943"] = #"hash_50c53528aa35b086";
    level._effect[#"hash_650bbbea29506d1e"] = #"hash_2b4f0b7b45b86a3d";
    level.var_5e9eed4a = [];
    clientfield::register("missile", "" + #"hash_6308b5ed3cbd99e3", 1, 1, "counter", &function_9815f8e7, 1, 0);
    clientfield::register("actor", "" + #"hash_37c2ef99d645cf87", 1, 1, "int", &function_3a6dffd7, 1, 0);
    clientfield::register("scriptmover", "" + #"hash_37c2ef99d645cf87", 1, 1, "int", &function_3a6dffd7, 1, 0);
    clientfield::register("actor", "" + #"hash_690509b9a2ec2ef3", 1, 1, "int", &function_9a78a7a3, 1, 0);
    clientfield::register("allplayers", "" + #"hash_290836b72f987780", 1, 1, "int", &function_14b3f3f6, 1, 0);
    clientfield::register("allplayers", "" + #"hash_6c3560ab45e186ec", 1, 1, "counter", &function_171ffb6e, 1, 0);
    clientfield::register("allplayers", "" + #"hash_b38c687db71dae", 1, 1, "int", &function_7ffeae8c, 1, 0);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 7, eflags: 0x0
// Checksum 0x43e844c4, Offset: 0x558
// Size: 0x160
function function_7ffeae8c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_d4181339)) {
        self.var_d4181339 = [];
    }
    if (newval) {
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self.var_d4181339[localclientnum] = playtagfxset(localclientnum, "weapon_zm_scorpion_1p", self);
        }
        return;
    }
    if (self zm_utility::function_a96d4c46(localclientnum) && isdefined(self.var_d4181339[localclientnum])) {
        foreach (fx in self.var_d4181339[localclientnum]) {
            killfx(localclientnum, fx);
        }
        self.var_d4181339[localclientnum] = undefined;
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 7, eflags: 0x0
// Checksum 0x8f5d3a49, Offset: 0x6c0
// Size: 0x74
function function_9815f8e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect[#"hash_650bbbea29506d1e"], self.origin);
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 7, eflags: 0x0
// Checksum 0x91b58d2, Offset: 0x740
// Size: 0x13a
function function_14b3f3f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self zm_utility::function_a96d4c46(localclientnum) && !isdefined(self.var_4c39d80c)) {
            if (isdefined(self gettagorigin("tag_flash2"))) {
                self.var_4c39d80c = playviewmodelfx(localclientnum, level._effect[#"hash_25f2b145ee5374d9"], "tag_flash2");
            }
        }
        return;
    }
    if (isdefined(self) && self zm_utility::function_a96d4c46(localclientnum) && isdefined(self.var_4c39d80c)) {
        stopfx(localclientnum, self.var_4c39d80c);
        self.var_4c39d80c = undefined;
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 7, eflags: 0x0
// Checksum 0xf6d8045e, Offset: 0x888
// Size: 0x11c
function function_171ffb6e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self zm_utility::function_a96d4c46(localclientnum) && isdefined(self gettagorigin("tag_flash2"))) {
            playviewmodelfx(localclientnum, level._effect[#"hash_70d2a1e399efcc91"], "tag_flash2");
            return;
        }
        if (isdefined(self gettagorigin("tag_flash2"))) {
            util::playfxontag(localclientnum, level._effect[#"hash_70d98de399f5c943"], self, "tag_flash2");
        }
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 7, eflags: 0x0
// Checksum 0x4134fc75, Offset: 0x9b0
// Size: 0x276
function function_3a6dffd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    str_tag = "j_spine4";
    v_origin = self gettagorigin("j_spine4");
    if (!isdefined(v_origin)) {
        str_tag = "tag_origin";
    }
    if (newval) {
        self.var_dd309789 = 1;
        if (!isdefined(level.var_5e9eed4a)) {
            level.var_5e9eed4a = [];
        } else if (!isarray(level.var_5e9eed4a)) {
            level.var_5e9eed4a = array(level.var_5e9eed4a);
        }
        if (!isinarray(level.var_5e9eed4a, self)) {
            level.var_5e9eed4a[level.var_5e9eed4a.size] = self;
        }
        if (!isdefined(self.var_c419028a)) {
            self.var_c419028a = util::playfxontag(localclientnum, level._effect[#"hash_37c2ef99d645cf87"], self, str_tag);
        }
        if (!isdefined(self.var_cd03a19d)) {
            self playsound(localclientnum, "wpn_scorpion_zombie_impact");
            self.var_cd03a19d = self playloopsound("wpn_scorpion_zombie_lp", 1);
        }
        return;
    }
    self.var_dd309789 = undefined;
    arrayremovevalue(level.var_5e9eed4a, self);
    if (isdefined(self.var_c419028a)) {
        stopfx(localclientnum, self.var_c419028a);
        self.var_c419028a = undefined;
    }
    if (isdefined(self.var_cd03a19d)) {
        self stoploopsound(self.var_cd03a19d);
        self.var_cd03a19d = undefined;
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 7, eflags: 0x0
// Checksum 0x2edf066c, Offset: 0xc30
// Size: 0x1c6
function function_9a78a7a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    str_tag = "j_spine4";
    v_origin = self gettagorigin("j_spine4");
    if (!isdefined(v_origin)) {
        str_tag = "tag_origin";
    }
    if (newval) {
        self.var_b4fdbf25 = 1;
        if (!isdefined(self.var_be6b7220)) {
            self.var_be6b7220 = util::playfxontag(localclientnum, level._effect[#"hash_690509b9a2ec2ef3"], self, str_tag);
            self thread function_e928b6cf(localclientnum);
        }
        if (!isdefined(self.var_3a2bb163)) {
            self playsound(localclientnum, "wpn_scorpion_zombie_impact");
            self.var_3a2bb163 = self playloopsound("wpn_scorpion_zombie_lp", 1);
        }
        return;
    }
    self.var_b4fdbf25 = undefined;
    if (isdefined(self.var_be6b7220)) {
        stopfx(localclientnum, self.var_be6b7220);
    }
    if (isdefined(self.var_3a2bb163)) {
        self stoploopsound(self.var_3a2bb163);
        self.var_3a2bb163 = undefined;
    }
}

// Namespace zm_weap_crossbow/zm_weap_crossbow
// Params 1, eflags: 0x0
// Checksum 0x431000da, Offset: 0xe00
// Size: 0x18c
function function_e928b6cf(localclientnum) {
    level.var_5e9eed4a = array::remove_undefined(level.var_5e9eed4a);
    level.var_5e9eed4a = array::remove_dead(level.var_5e9eed4a);
    var_9a0f2544 = arraygetclosest(self.origin, level.var_5e9eed4a, 160);
    if (isdefined(var_9a0f2544)) {
        var_755fb04 = var_9a0f2544 zm_utility::function_a7776589();
        var_2a205ae6 = self zm_utility::function_a7776589();
        var_8613b5c6 = level beam::launch(var_9a0f2544, var_755fb04, self, var_2a205ae6, "beam8_elec_catalyst_arc_attack");
        while (isdefined(self) && isdefined(var_9a0f2544) && isdefined(self.var_b4fdbf25) && self.var_b4fdbf25 && isdefined(var_9a0f2544.var_dd309789) && var_9a0f2544.var_dd309789) {
            waitframe(1);
        }
        level beam::kill(var_9a0f2544, var_755fb04, self, var_2a205ae6, "beam8_elec_catalyst_arc_attack");
    }
}

