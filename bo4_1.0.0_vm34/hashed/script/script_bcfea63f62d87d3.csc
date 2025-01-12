#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace namespace_e58235eb;

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 0, eflags: 0x2
// Checksum 0xd402605d, Offset: 0x160
// Size: 0x5c
function autoexec main() {
    clientfield::register("scriptmover", "towers_boss_dust_ball_fx", 1, getminbitcountfornum(4), "int", &function_c86c885b, 0, 0);
}

// Namespace namespace_e58235eb/namespace_e58235eb
// Params 7, eflags: 0x0
// Checksum 0xbe8cf64e, Offset: 0x1c8
// Size: 0x19c
function function_c86c885b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_slam_trail_lg", self, "tag_origin");
        return;
    }
    if (newval == 2) {
        if (isdefined(self.fx)) {
            stopfx(localclientnum, self.fx);
        }
        self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_slam_trail", self, "tag_origin");
        return;
    }
    if (newval == 3) {
        if (isdefined(self.fx)) {
            stopfx(localclientnum, self.fx);
        }
        self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_death_soul_trail", self, "tag_origin");
        return;
    }
    if (isdefined(self.fx)) {
        self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_slam_trail_end", self, "tag_origin");
        stopfx(localclientnum, self.fx);
    }
}

