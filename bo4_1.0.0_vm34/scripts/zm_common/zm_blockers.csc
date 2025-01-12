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
// Params 0, eflags: 0x2
// Checksum 0x89098211, Offset: 0x290
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_blockers", &__init__, undefined, undefined);
}

// Namespace zm_blockers/zm_blockers
// Params 0, eflags: 0x0
// Checksum 0xb2d7b8ad, Offset: 0x2d8
// Size: 0x37c
function __init__() {
    level._effect[#"doorbuy_ambient_fx"] = "zombie/fx8_doorbuy_amb";
    level._effect[#"doorbuy_bought_fx"] = "zombie/fx8_doorbuy_death";
    level._effect[#"debrisbuy_ambient_fx"] = "zombie/fx8_debrisbuy_amb";
    level._effect[#"debrisbuy_bought_fx"] = "zombie/fx8_debrisbuy_death";
    level._effect[#"powerdoor_ambient_fx"] = "zombie/fx8_power_door_amb";
    level._effect[#"powerdoor_bought_fx"] = "zombie/fx8_power_door_death";
    level._effect[#"power_debris_ambient_fx"] = "zombie/fx8_power_debris_amb";
    level._effect[#"power_debris_bought_fx"] = "zombie/fx8_power_debris_death";
    clientfield::register("scriptmover", "doorbuy_ambient_fx", 1, 1, "int", &doorbuy_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "doorbuy_bought_fx", 1, 1, "int", &doorbuy_bought_fx, 0, 0);
    clientfield::register("scriptmover", "debrisbuy_ambient_fx", 1, 1, "int", &debrisbuy_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "debrisbuy_bought_fx", 1, 1, "int", &debrisbuy_bought_fx, 0, 0);
    clientfield::register("scriptmover", "power_door_ambient_fx", 1, 1, "int", &power_door_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "power_door_bought_fx", 1, 1, "int", &power_door_bought_fx, 0, 0);
    clientfield::register("scriptmover", "power_debris_ambient_fx", 1, 1, "int", &power_debris_ambient_fx, 0, 0);
    clientfield::register("scriptmover", "power_debris_bought_fx", 1, 1, "int", &power_debris_bought_fx, 0, 0);
}

// Namespace zm_blockers/zm_blockers
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x660
// Size: 0x4
function __main__() {
    
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0xfd03e1db, Offset: 0x670
// Size: 0x74
function doorbuy_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_f1bef47(level._effect[#"doorbuy_ambient_fx"], "zmb_blocker_door_lp", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0x237ab9a9, Offset: 0x6f0
// Size: 0x74
function debrisbuy_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_f1bef47(level._effect[#"debrisbuy_ambient_fx"], "zmb_blocker_debris_lp", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0x50fa80a7, Offset: 0x770
// Size: 0x74
function power_door_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_f1bef47(level._effect[#"powerdoor_ambient_fx"], "zmb_blocker_powerdoor_lp", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0x18fef7e4, Offset: 0x7f0
// Size: 0x74
function power_debris_ambient_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_f1bef47(level._effect[#"power_debris_ambient_fx"], "zmb_blocker_debris_lp", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0xf104f5a4, Offset: 0x870
// Size: 0x7c
function doorbuy_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_c971f9f4(level._effect[#"doorbuy_bought_fx"], #"hash_21b4bf152e90fd76", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0x95ac1108, Offset: 0x8f8
// Size: 0x7c
function debrisbuy_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_c971f9f4(level._effect[#"debrisbuy_bought_fx"], #"hash_4bddd546f43487cf", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0xcf32c560, Offset: 0x980
// Size: 0x7c
function power_door_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_c971f9f4(level._effect[#"powerdoor_bought_fx"], #"hash_5dcb54d98c9787b1", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 7, eflags: 0x0
// Checksum 0x7165bd98, Offset: 0xa08
// Size: 0x7c
function power_debris_bought_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self function_c971f9f4(level._effect[#"power_debris_bought_fx"], #"hash_4bddd546f43487cf", localclientnum, newval);
}

// Namespace zm_blockers/zm_blockers
// Params 4, eflags: 0x0
// Checksum 0x42c082db, Offset: 0xa90
// Size: 0x134
function function_f1bef47(str_fx_name, var_bdc3076a, var_3d850ea0, n_new_val) {
    if (n_new_val) {
        if (isdefined(self) && !isdefined(self.var_e0919bf1)) {
            self.var_e0919bf1 = util::spawn_model(var_3d850ea0, #"tag_origin", self.origin, self.angles);
        }
        if (isdefined(self) && !isdefined(self.ambient_fx_id)) {
            self.ambient_fx_id = util::playfxontag(var_3d850ea0, str_fx_name, self, "tag_origin");
        }
        audio::playloopat(var_bdc3076a, self.origin);
        return;
    }
    if (isdefined(self.ambient_fx_id)) {
        killfx(var_3d850ea0, self.ambient_fx_id);
        self.ambient_fx_id = undefined;
    }
    audio::stoploopat(var_bdc3076a, self.origin);
}

// Namespace zm_blockers/zm_blockers
// Params 4, eflags: 0x0
// Checksum 0x950b539c, Offset: 0xbd0
// Size: 0xec
function function_c971f9f4(str_fx_name, var_e292a96f, var_3d850ea0, n_new_val) {
    if (n_new_val) {
        if (!isdefined(self.var_e0919bf1)) {
            var_e0919bf1 = util::spawn_model(var_3d850ea0, #"tag_origin", self.origin, self.angles);
        } else {
            var_e0919bf1 = self.var_e0919bf1;
        }
        util::playfxontag(var_3d850ea0, str_fx_name, var_e0919bf1, "tag_origin");
        playsound(var_3d850ea0, var_e292a96f, var_e0919bf1.origin);
        wait 2;
        if (isdefined(var_e0919bf1)) {
            var_e0919bf1 delete();
        }
    }
}

