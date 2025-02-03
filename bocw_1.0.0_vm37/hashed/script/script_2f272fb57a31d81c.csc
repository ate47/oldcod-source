#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace missile_turret;

// Namespace missile_turret/namespace_1b611bca
// Params 0, eflags: 0x0
// Checksum 0xa2c5d15c, Offset: 0xf8
// Size: 0x13c
function init_shared() {
    if (!isdefined(level.var_7f854017)) {
        level.var_7f854017 = {};
        clientfield::register("vehicle", "missile_turret_open", 1, 1, "int", &turret_open, 0, 0);
        clientfield::register("vehicle", "missile_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
        clientfield::register("vehicle", "missile_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
        clientfield::register("vehicle", "missile_turret_is_jammed_by_cuav", 1, 1, "int", &function_c1c49ac7, 0, 0);
    }
}

// Namespace missile_turret/namespace_1b611bca
// Params 7, eflags: 0x0
// Checksum 0xca4a436a, Offset: 0x240
// Size: 0xec
function turret_init_anim(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    self useanimtree("generic");
    self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
    self setanimtime(#"o_turret_mini_deploy", 0);
}

// Namespace missile_turret/namespace_1b611bca
// Params 7, eflags: 0x0
// Checksum 0x7d717a45, Offset: 0x338
// Size: 0xdc
function turret_open(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    self function_1f0c7136(1);
    self useanimtree("generic");
    self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
}

// Namespace missile_turret/namespace_1b611bca
// Params 7, eflags: 0x0
// Checksum 0x861ba942, Offset: 0x420
// Size: 0x9c
function turret_close_anim(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!bwastimejump) {
        return;
    }
    self useanimtree("generic");
    self setanimrestart(#"o_turret_sentry_close", 1, 0, 1);
}

// Namespace missile_turret/namespace_1b611bca
// Params 7, eflags: 0x0
// Checksum 0x70b0c5d7, Offset: 0x4c8
// Size: 0x138
function function_c1c49ac7(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self util::waittill_dobj(fieldname);
    if (!isdefined(self.weapon.var_96850284)) {
        return;
    }
    if (bwastimejump == 1) {
        self.var_37e84ddb = playtagfxset(fieldname, self.weapon.var_96850284, self);
        return;
    }
    if (isdefined(self.var_37e84ddb)) {
        foreach (fx in self.var_37e84ddb) {
            stopfx(fieldname, fx);
        }
    }
}

