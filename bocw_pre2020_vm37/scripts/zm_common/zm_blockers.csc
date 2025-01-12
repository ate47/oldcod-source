#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_blockers;

// Namespace zm_blockers/zm_blockers
// Params 0, eflags: 0x6
// Checksum 0xdd85c2b4, Offset: 0x208
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"zm_blockers", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace zm_blockers/zm_blockers
// Params 0, eflags: 0x5 linked
// Checksum 0xc680abc8, Offset: 0x250
// Size: 0x3c4
function private function_70a657d8() {
    level._effect[#"doorbuy_ambient_fx"] = "zombie/fx8_doorbuy_amb";
    level._effect[#"doorbuy_bought_fx"] = "zombie/fx8_doorbuy_death";
    level._effect[#"debrisbuy_ambient_fx"] = "zombie/fx8_debrisbuy_amb";
    level._effect[#"debrisbuy_bought_fx"] = "zombie/fx8_debrisbuy_death";
    level._effect[#"powerdoor_ambient_fx"] = "zombie/fx8_power_door_amb";
    level._effect[#"powerdoor_bought_fx"] = "zombie/fx8_power_door_death";
    level._effect[#"power_debris_ambient_fx"] = "zombie/fx8_power_debris_amb";
    level._effect[#"power_debris_bought_fx"] = "zombie/fx8_power_debris_death";
    clientfield::register("scriptmover", "" + #"doorbuy_ambient_fx", 1, 1, "int", &doorbuy_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"doorbuy_bought_fx", 1, 1, "int", &doorbuy_bought_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"debrisbuy_ambient_fx", 1, 1, "int", &debrisbuy_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"debrisbuy_bought_fx", 1, 1, "int", &debrisbuy_bought_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"power_door_ambient_fx", 1, 1, "int", &power_door_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"power_door_bought_fx", 1, 1, "int", &power_door_bought_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"power_debris_ambient_fx", 1, 1, "int", &power_debris_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "" + #"power_debris_bought_fx", 1, 1, "int", &power_debris_bought_fx, 0, 0);
}

// Namespace zm_blockers/zm_blockers
// Params 0, eflags: 0x4
// Checksum 0x80f724d1, Offset: 0x620
// Size: 0x4
function private postinit() {
    
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0x22ff1b10, Offset: 0x630
// Size: 0x74
function doorbuy_ambient_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_aa07bb71(level._effect[#"doorbuy_ambient_fx"], "zmb_blocker_door_lp", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0xc77cfd44, Offset: 0x6b0
// Size: 0x74
function debrisbuy_ambient_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_aa07bb71(level._effect[#"debrisbuy_ambient_fx"], "zmb_blocker_debris_lp", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0xb45afa16, Offset: 0x730
// Size: 0x74
function power_door_ambient_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_aa07bb71(level._effect[#"powerdoor_ambient_fx"], "zmb_blocker_powerdoor_lp", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0x754c6920, Offset: 0x7b0
// Size: 0x74
function power_debris_ambient_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_aa07bb71(level._effect[#"power_debris_ambient_fx"], "zmb_blocker_debris_lp", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0x5c2a10e0, Offset: 0x830
// Size: 0x7c
function doorbuy_bought_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_e6eed4fe(level._effect[#"doorbuy_bought_fx"], #"hash_21b4bf152e90fd76", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0xc6d6f4b2, Offset: 0x8b8
// Size: 0x7c
function debrisbuy_bought_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_e6eed4fe(level._effect[#"debrisbuy_bought_fx"], #"hash_4bddd546f43487cf", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0xe587dba, Offset: 0x940
// Size: 0x7c
function power_door_bought_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_e6eed4fe(level._effect[#"powerdoor_bought_fx"], #"hash_5dcb54d98c9787b1", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x1 linked
// Checksum 0xf3ec7969, Offset: 0x9c8
// Size: 0x7c
function power_debris_bought_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self function_e6eed4fe(level._effect[#"power_debris_bought_fx"], #"hash_4bddd546f43487cf", fieldname, bwastimejump);
}

// Namespace zm_blockers/zm_blockers
// Params 4, eflags: 0x1 linked
// Checksum 0xc9b44fa5, Offset: 0xa50
// Size: 0xdc
function function_aa07bb71(str_fx_name, var_bd367366, var_6142f944, n_new_val) {
    if (n_new_val) {
        if (isdefined(self) && !isdefined(self.var_907b36d0)) {
            self.var_907b36d0 = util::playfxontag(var_6142f944, str_fx_name, self, "tag_origin");
        }
        audio::playloopat(var_bd367366, self.origin);
        return;
    }
    if (isdefined(self.var_907b36d0)) {
        killfx(var_6142f944, self.var_907b36d0);
        self.var_907b36d0 = undefined;
    }
    audio::stoploopat(var_bd367366, self.origin);
}

// Namespace zm_blockers/zm_blockers
// Params 4, eflags: 0x1 linked
// Checksum 0x4ebf4093, Offset: 0xb38
// Size: 0xe4
function function_e6eed4fe(str_fx_name, var_d34b6d2b, var_6142f944, n_new_val) {
    if (n_new_val) {
        if (!isdefined(self.var_4da473fc)) {
            var_4da473fc = util::spawn_model(var_6142f944, #"tag_origin", self.origin, self.angles);
        } else {
            var_4da473fc = self.var_4da473fc;
        }
        util::playfxontag(var_6142f944, str_fx_name, var_4da473fc, "tag_origin");
        playsound(var_6142f944, var_d34b6d2b, var_4da473fc.origin);
        wait 2;
        if (isdefined(var_4da473fc)) {
            var_4da473fc delete();
        }
    }
}

