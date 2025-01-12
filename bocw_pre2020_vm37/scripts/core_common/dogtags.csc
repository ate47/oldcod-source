#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace dogtags;

// Namespace dogtags/dogtags
// Params 0, eflags: 0x0
// Checksum 0x78098e8, Offset: 0xb8
// Size: 0x4c
function init() {
    clientfield::register("scriptmover", "dogtag_flag", 1, 2, "int", &function_319c73b1, 0, 0);
}

// Namespace dogtags/dogtags
// Params 7, eflags: 0x0
// Checksum 0x46aa8557, Offset: 0x110
// Size: 0x2c4
function function_319c73b1(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"stopbounce");
    if (isdefined(self.var_47b256ef)) {
        self.var_47b256ef unlink();
        self.var_47b256ef.origin = self.origin;
    }
    if (bwastimejump == 0) {
        self function_81431153(fieldname);
        return;
    }
    if (!isdefined(self.var_47b256ef)) {
        self.var_47b256ef = spawn(fieldname, self.origin, "script_model");
        self.var_47b256ef.angles = (0, 0, 0);
        self.var_47b256ef setmodel(#"tag_origin");
        self thread function_bcb88fb7(fieldname);
    }
    if (!isdefined(self.var_c7d6b0c1)) {
        characterindex = isdefined(self function_ef9de5ae()) ? self function_ef9de5ae() : 0;
        fxtoplay = isdefined(getcharacterfields(characterindex, currentsessionmode()).var_c7d6b0c1) ? getcharacterfields(characterindex, currentsessionmode()).var_c7d6b0c1 : #"hash_33e0590f09902cb5";
        self.var_c7d6b0c1 = util::playfxontag(fieldname, fxtoplay, self.var_47b256ef, "tag_origin");
        setfxteam(fieldname, self.var_c7d6b0c1, self.team);
    }
    if (bwastimejump == 1) {
        self.var_47b256ef.origin = self.origin;
        self.var_47b256ef linkto(self);
        return;
    }
    if (bwastimejump == 2 || bwastimejump == 3) {
        self thread function_2eee13af();
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x0
// Checksum 0xcaa11201, Offset: 0x3e0
// Size: 0x3e
function function_81431153(localclientnum) {
    if (isdefined(self.var_c7d6b0c1)) {
        killfx(localclientnum, self.var_c7d6b0c1);
        self.var_c7d6b0c1 = undefined;
    }
}

// Namespace dogtags/dogtags
// Params 1, eflags: 0x0
// Checksum 0x65e60d4c, Offset: 0x428
// Size: 0x6e
function function_bcb88fb7(localclientnum) {
    self waittill(#"death");
    self function_81431153(localclientnum);
    if (isdefined(self.var_47b256ef)) {
        self.var_47b256ef delete();
        self.var_47b256ef = undefined;
    }
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x0
// Checksum 0xaf5f2f57, Offset: 0x4a0
// Size: 0xf4
function function_2eee13af() {
    self endon(#"stopbounce");
    self endon(#"death");
    while (true) {
        toppos = self.origin + (0, 0, 12);
        self.var_47b256ef moveto(toppos, 0.5, 0, 0);
        self.var_47b256ef waittill(#"movedone");
        bottompos = self.origin;
        self.var_47b256ef moveto(bottompos, 0.5, 0, 0);
        self.var_47b256ef waittill(#"movedone");
    }
}

// Namespace dogtags/dogtags
// Params 0, eflags: 0x4
// Checksum 0x113dda08, Offset: 0x5a0
// Size: 0x1a
function private function_ef9de5ae() {
    return self function_9682ea07();
}
