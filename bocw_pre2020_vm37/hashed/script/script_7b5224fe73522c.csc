#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_cf2b4f27;

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 0, eflags: 0x6
// Checksum 0x837f63c7, Offset: 0x240
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_62a392bb15b68ccd", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 0, eflags: 0x5 linked
// Checksum 0xf976fefa, Offset: 0x290
// Size: 0xdc
function private function_70a657d8() {
    clientfield::register("actor", "fx_frost_blast_clientfield", 1, 3, "int", &function_78f4a9dc, 1, 0);
    clientfield::register("toplayer", "fx_frost_blast_1p_lv1_clientfield", 1, 1, "counter", &function_e557117b, 1, 0);
    clientfield::register("toplayer", "fx_frost_blast_1p_lv3_clientfield", 1, 1, "counter", &function_fea42db5, 1, 0);
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 7, eflags: 0x1 linked
// Checksum 0x4c11ec9c, Offset: 0x378
// Size: 0x64
function function_e557117b(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playviewmodelfx(bwastimejump, "zm_weapons/fx9_fld_frost_blast_lvl1_1p", "tag_torso");
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 7, eflags: 0x1 linked
// Checksum 0x32f26d10, Offset: 0x3e8
// Size: 0x64
function function_fea42db5(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playviewmodelfx(bwastimejump, "zm_weapons/fx9_fld_frost_blast_lvl3_1p", "tag_torso");
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 7, eflags: 0x1 linked
// Checksum 0x43612a94, Offset: 0x458
// Size: 0x21a
function function_78f4a9dc(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 0:
        self thread function_46e16bf3(fieldname, 0);
        break;
    case 1:
    case 2:
    case 3:
    case 4:
        if (!isdefined(self.var_1b11d1e)) {
            self.var_1b11d1e = self playloopsound(#"hash_23c0dcda2b5c03b1");
        }
        self thread function_46e16bf3(fieldname, 1);
        break;
    case 5:
        if (self.archetype == #"zombie_dog") {
            self.var_565ef52d = util::playfxontag(fieldname, "zm_weapons/fx9_fld_frost_blast_lvl5_hound_torso", self, "j_spine2");
        } else {
            self.var_565ef52d = util::playfxontag(fieldname, "zm_weapons/fx9_fld_frost_blast_lvl5_zombie_torso", self, "j_spine4");
        }
        if (self.archetype === #"zombie_dog") {
            self thread function_ef31a880(fieldname);
        }
        if (!isdefined(self.var_1b11d1e)) {
            self.var_1b11d1e = self playloopsound(#"hash_23c0dcda2b5c03b1");
        }
        self thread function_46e16bf3(fieldname, 1);
        break;
    }
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 2, eflags: 0x1 linked
// Checksum 0x84dc52e1, Offset: 0x680
// Size: 0x2b8
function function_46e16bf3(localclientnum, b_freeze) {
    self notify(#"end_frosty");
    self endoncallback(&function_ed5b4054, #"death", #"end_frosty");
    self playrenderoverridebundle("rob_test_character_ice");
    if (!isdefined(self.var_82fb67e7)) {
        self.var_82fb67e7 = 0;
    }
    if (b_freeze) {
        var_875c79c1 = self.var_82fb67e7 + 0.5;
    }
    while (true) {
        self function_78233d29("rob_test_character_ice", "", "Threshold", self.var_82fb67e7);
        if (b_freeze) {
            self.var_82fb67e7 += 0.2;
        } else {
            self.var_82fb67e7 -= 0.05;
        }
        if (b_freeze && (self.var_82fb67e7 >= var_875c79c1 || self.var_82fb67e7 >= 1)) {
            break;
        } else if (self.var_82fb67e7 <= 0) {
            self stoprenderoverridebundle("rob_test_character_ice");
            if (isdefined(self.var_565ef52d)) {
                stopfx(localclientnum, self.var_565ef52d);
                self.var_565ef52d = undefined;
            }
            if (isdefined(self.var_1b11d1e)) {
                self stoploopsound(self.var_1b11d1e);
                self.var_1b11d1e = undefined;
            }
            break;
        } else if (gibclientutils::isgibbed(localclientnum, self, 2)) {
            self stoprenderoverridebundle("rob_test_character_ice");
            if (isdefined(self.var_565ef52d)) {
                killfx(localclientnum, self.var_565ef52d);
                self.var_565ef52d = undefined;
            }
            if (isdefined(self.var_1b11d1e)) {
                self stoploopsound(self.var_1b11d1e);
                self.var_1b11d1e = undefined;
            }
            break;
        }
        wait 0.1;
    }
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 0, eflags: 0x1 linked
// Checksum 0xafc93d9a, Offset: 0x940
// Size: 0xe2
function function_ed5b4054() {
    players = getlocalplayers();
    foreach (player in players) {
        localclientnum = player getlocalclientnumber();
        if (isdefined(self.var_565ef52d)) {
            stopfx(localclientnum, self.var_565ef52d);
            self.var_565ef52d = undefined;
        }
    }
}

// Namespace namespace_cf2b4f27/namespace_cf2b4f27
// Params 1, eflags: 0x1 linked
// Checksum 0xada6405d, Offset: 0xa30
// Size: 0x74
function function_ef31a880(localclientnum) {
    self notify("777e4f0c23695408");
    self endon("777e4f0c23695408");
    var_565ef52d = self.var_565ef52d;
    self waittill(#"death");
    if (isdefined(var_565ef52d)) {
        killfx(localclientnum, var_565ef52d);
    }
}

