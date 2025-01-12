#using scripts\core_common\clientfield_shared;

#namespace namespace_473c9869;

// Namespace namespace_473c9869/level_init
// Params 1, eflags: 0x40
// Checksum 0x80f37853, Offset: 0x158
// Size: 0x9c
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("actor", "final_battle_orb_fx", 1, 1, "int", &orb_fx, 0, 0);
    clientfield::register("scriptmover", "final_battle_cloud_fx", 1, 1, "int", &function_4e3a2ec1, 0, 0);
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 7, eflags: 0x0
// Checksum 0x4fbfbf42, Offset: 0x200
// Size: 0x124
function orb_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self.var_af61b850 = function_239993de(fieldname, "sr/fx9_boss_orb_aether_shield_spawn", self, "j_spinelower");
        self.var_343d0de4 = self playloopsound(#"hash_49d20aaa9bbcf4f9");
        return;
    }
    killfx(fieldname, self.var_af61b850);
    self.var_af61b850 = undefined;
    if (isdefined(self.var_343d0de4)) {
        self stoploopsound(self.var_343d0de4);
        self.var_343d0de4 = undefined;
    }
    function_239993de(fieldname, "sr/fx9_boss_orb_aether_shield_despawn", self, "j_spinelower");
}

// Namespace namespace_473c9869/namespace_473c9869
// Params 7, eflags: 0x0
// Checksum 0x885bbff8, Offset: 0x330
// Size: 0x112
function function_4e3a2ec1(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (isdefined(self.var_f825b773)) {
            killfx(fieldname, self.var_f825b773);
            self.var_f825b773 = undefined;
        } else {
            self.var_73782e5d = function_239993de(fieldname, "sr/fx9_boss_orb_aether_idle", self, "j_spinelower");
        }
        return;
    }
    if (isdefined(self.var_73782e5d)) {
        killfx(fieldname, self.var_73782e5d);
        self.var_73782e5d = undefined;
        self.var_f825b773 = function_239993de(fieldname, "sr/fx9_boss_orb_aether_travel", self, "j_spinelower");
    }
}

