#using script_38dc72b5220a1a67;
#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;

#namespace namespace_767001c4;

// Namespace namespace_767001c4/level_init
// Params 1, eflags: 0x40
// Checksum 0x6a98da7a, Offset: 0x140
// Size: 0xd4
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "" + #"hash_487b1e88cb277c0e", 1, 2, "int", &function_10ea3e76, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_4d8a65c820ef791", 1, 1, "int", &portal_fx, 0, 0);
    util::waitforclient(0);
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 7, eflags: 0x0
// Checksum 0xc87982af, Offset: 0x220
// Size: 0x254
function function_10ea3e76(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    s_generator = array::get_all_closest(self.origin, struct::get_array("s_portal_pos"))[0];
    if (bwastimejump == 1) {
        if (!isdefined(self.var_f1b20bef)) {
            self.var_f1b20bef = util::spawn_model(fieldname, "tag_origin", s_generator.origin + (0, 0, -8), s_generator.angles);
        }
        level beam::launch(self.var_f1b20bef, "tag_origin", self, "tag_fx_beam", "beam9_sr_objective_portal_corrupted", 1);
        return;
    }
    if (bwastimejump == 2) {
        if (!isdefined(self.var_f1b20bef)) {
            self.var_f1b20bef = util::spawn_model(fieldname, "tag_origin", s_generator.origin + (0, 0, -8), s_generator.angles);
        }
        level beam::kill(self.var_f1b20bef, "tag_origin", self, "tag_fx_beam", "beam9_sr_objective_portal_corrupted");
        level beam::launch(self.var_f1b20bef, "tag_origin", self, "tag_fx_beam", "beam9_sr_objective_portal_cleansed", 1);
        return;
    }
    if (bwastimejump == 0) {
        if (isdefined(self.var_f1b20bef)) {
            level beam::kill(self.var_f1b20bef, "tag_origin", self, "tag_fx_beam", "beam9_sr_objective_portal_corrupted");
            self.var_f1b20bef delete();
        }
    }
}

// Namespace namespace_767001c4/namespace_1b47c84a
// Params 7, eflags: 0x0
// Checksum 0xbdd36641, Offset: 0x480
// Size: 0x64
function portal_fx(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, "sr/fx9_obj_portal_loop", self.origin);
}

