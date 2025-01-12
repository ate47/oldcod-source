#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\util_shared;

#namespace dog;

// Namespace dog/dog_shared
// Params 0, eflags: 0x0
// Checksum 0xc8f630fe, Offset: 0x108
// Size: 0x134
function init_shared() {
    if (!isdefined(level.system_dog)) {
        level.system_dog = {};
        clientfield::register("clientuimodel", "hudItems.dogState", 1, 2, "int", undefined, 0, 0);
        clientfield::register("actor", "dogState", 1, 1, "int", &function_84323ae4, 0, 0);
        clientfield::register("actor", "ks_dog_bark", 1, 1, "counter", &function_776d4d8e, 0, 0);
        clientfield::register("actor", "ks_shocked", 1, 1, "int", &function_8d79465f, 0, 0);
    }
}

// Namespace dog/dog_shared
// Params 7, eflags: 0x4
// Checksum 0xa4d968fa, Offset: 0x248
// Size: 0x9c
function private function_84323ae4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp");
    }
}

// Namespace dog/dog_shared
// Params 7, eflags: 0x0
// Checksum 0xee72af8, Offset: 0x2f0
// Size: 0xdc
function function_776d4d8e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (newval) {
        if (isdefined(self) && self hasdobj(localclientnum)) {
            self setflaggedanimknobrestart(#"hash_506d2ece42569653", #"ai_nomad_dog_additive_bark_01", 1, 0.1, 1);
        }
    }
}

// Namespace dog/dog_shared
// Params 7, eflags: 0x0
// Checksum 0xbf18a6e8, Offset: 0x3d8
// Size: 0xcc
function function_8d79465f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_17dd02d3)) {
            stopfx(localclientnum, self.var_17dd02d3);
        }
        self.var_17dd02d3 = util::playfxontag(localclientnum, "weapon/fx8_hero_sig_lightning_death_dog", self, "j_spine3");
        return;
    }
    if (isdefined(self.var_17dd02d3)) {
        stopfx(localclientnum, self.var_17dd02d3);
    }
}

