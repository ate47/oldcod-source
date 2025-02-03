#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace jetfighter;

// Namespace jetfighter/jetfighter
// Params 0, eflags: 0x6
// Checksum 0x8fb102b1, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"jetfighter", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace jetfighter/jetfighter
// Params 0, eflags: 0x4
// Checksum 0xdd7f1666, Offset: 0x130
// Size: 0x6c
function private preinit() {
    clientfield::register("scriptmover", "jetfighter_contrail", 1, 1, "int", &jetfighter_contrail, 0, 0);
    level.var_852b61e4 = getscriptbundle("killstreak_jetfighter");
}

// Namespace jetfighter/jetfighter
// Params 7, eflags: 0x0
// Checksum 0x8f45fe40, Offset: 0x1a8
// Size: 0x1dc
function jetfighter_contrail(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    util::waittill_dobj(fieldname);
    if (bwastimejump) {
        self.fx = util::playfxontag(fieldname, level.var_852b61e4.var_dcbb40c5, self, level.var_852b61e4.var_d678978c);
        self.fx = util::playfxontag(fieldname, level.var_852b61e4.var_2375a152, self, level.var_852b61e4.var_e5082065);
        localplayer = function_5c10bd79(fieldname);
        self function_1f0c7136(2);
        if (localplayer hasperk(fieldname, #"specialty_showscorestreakicons") || self.team == localplayer.team) {
            self setcompassicon(level.var_852b61e4.var_cb98fbf7);
            self function_5e00861(level.var_852b61e4.var_c3e4af00);
            var_b13727dd = getgametypesetting("compassAnchorScorestreakIcons");
            self function_dce2238(var_b13727dd);
        }
    }
}

