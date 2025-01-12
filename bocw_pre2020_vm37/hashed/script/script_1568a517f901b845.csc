#using script_7922dc472341c85c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreak_detect;

#namespace napalm_strike;

// Namespace napalm_strike/namespace_b00a727a
// Params 1, eflags: 0x1 linked
// Checksum 0x61cb5f8e, Offset: 0x100
// Size: 0x144
function init_shared(bundlename) {
    killstreak_detect::init_shared();
    level.var_30e551f4 = getscriptbundle(bundlename);
    clientfield::register("scriptmover", "" + #"hash_72f92383f772d276", 1, 1, "int", &function_e0221c63, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_3d8e05debfa62f2d", 1, 1, "int", &function_818e69da, 0, 0);
    clientfield::register("missile", "" + #"hash_77346335cbe9ecde", 1, 1, "int", &function_344bba9b, 0, 0);
}

// Namespace napalm_strike/namespace_b00a727a
// Params 7, eflags: 0x1 linked
// Checksum 0x67ba8bb8, Offset: 0x250
// Size: 0x22c
function function_e0221c63(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    util::waittill_dobj(fieldname);
    if (bwastimejump) {
        util::playfxontag(fieldname, level.var_30e551f4.var_2375a152, self, level.var_30e551f4.var_e5082065);
        util::playfxontag(fieldname, level.var_30e551f4.var_a6f96498, self, "tag_body");
        util::playfxontag(fieldname, level.var_30e551f4.var_ee8aabc3, self, "tag_fx_engine_l");
        util::playfxontag(fieldname, level.var_30e551f4.var_ee8aabc3, self, "tag_fx_engine_r");
        localplayer = function_5c10bd79(fieldname);
        self function_1f0c7136(2);
        if (localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
            self setcompassicon(level.var_30e551f4.var_cb98fbf7);
            self function_5e00861(level.var_30e551f4.var_c3e4af00);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self function_dce2238(var_b13727dd);
        }
    }
}

// Namespace napalm_strike/namespace_b00a727a
// Params 7, eflags: 0x1 linked
// Checksum 0x8b5ba990, Offset: 0x488
// Size: 0xc4
function function_818e69da(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    util::waittill_dobj(fieldname);
    if (bwastimejump) {
        self playrumbleonentity(fieldname, level.var_30e551f4.var_12c482a2);
        return;
    }
    self stoprumble(fieldname, level.var_30e551f4.var_12c482a2);
}

// Namespace napalm_strike/namespace_b00a727a
// Params 7, eflags: 0x1 linked
// Checksum 0x353bb367, Offset: 0x558
// Size: 0xa4
function function_344bba9b(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    forward = anglestoforward(self.angles);
    playfx(bwastimejump, level.var_30e551f4.var_f6580c0b, self.origin, (0, 0, 1), (forward[0], forward[1], 0));
}

