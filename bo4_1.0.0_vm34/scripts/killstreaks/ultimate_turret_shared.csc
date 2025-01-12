#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace ultimate_turret;

// Namespace ultimate_turret/ultimate_turret_shared
// Params 0, eflags: 0x0
// Checksum 0xf3cb8055, Offset: 0xf8
// Size: 0x12c
function init_shared() {
    if (!isdefined(level.var_f81ff1b9)) {
        level.var_f81ff1b9 = {};
        clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int", &turret_open, 0, 0);
        clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
        clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
        clientfield::register("clientuimodel", "hudItems.ultimateTurretCount", 1, 3, "int", undefined, 0, 0);
    }
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 7, eflags: 0x0
// Checksum 0xd2e80773, Offset: 0x230
// Size: 0xec
function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
    self setanimtime(#"o_turret_mini_deploy", 0);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 7, eflags: 0x0
// Checksum 0x67fe58cc, Offset: 0x328
// Size: 0xc4
function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanimrestart(#"o_turret_mini_deploy", 1, 0, 1);
}

// Namespace ultimate_turret/ultimate_turret_shared
// Params 7, eflags: 0x0
// Checksum 0xa01d9cd6, Offset: 0x3f8
// Size: 0x9c
function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree("generic");
    self setanimrestart(#"o_turret_sentry_close", 1, 0, 1);
}

