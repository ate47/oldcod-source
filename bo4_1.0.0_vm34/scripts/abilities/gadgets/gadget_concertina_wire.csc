#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\deployable;

#namespace concertina_wire;

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0xde60620d, Offset: 0x138
// Size: 0x1a4
function init_shared(var_a9bc8d6e) {
    clientfield::register("scriptmover", "concertinaWire_placed", 1, 5, "float", &function_e1729b09, 0, 0);
    clientfield::register("scriptmover", "concertinaWireDestroyed", 1, 1, "int", &function_5193b0bf, 0, 0);
    clientfield::register("scriptmover", "concertinaWireDroopyBits", 1, 3, "int", &function_83352bde, 0, 0);
    level.var_a33e1621 = spawnstruct();
    level.var_a33e1621.bundle = getscriptbundle(var_a9bc8d6e);
    level.var_a33e1621.concertinawireweapon = getweapon(#"eq_concertina_wire");
    level.var_a33e1621.var_bdc049de = "concertina_wire_objective_default";
    level.var_a33e1621.var_b2cf3d75 = [];
    deployable::register_deployable(level.var_a33e1621.concertinawireweapon, 1);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0x1c886682, Offset: 0x2e8
// Size: 0x76
function function_3de78c2b(localclientnum) {
    self notify("c298d246402eaf6");
    self endon("c298d246402eaf6");
    self endon(#"death");
    player = function_f97e7787(localclientnum);
    player waittill(#"death");
    self.var_de781c0c = undefined;
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 7, eflags: 0x0
// Checksum 0x1c8bc2d2, Offset: 0x368
// Size: 0x3c
function function_5193b0bf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 7, eflags: 0x0
// Checksum 0x31d308, Offset: 0x3b0
// Size: 0x1ac
function function_83352bde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (1 == newval || 3 == newval) {
        self function_9019beea("wire_10", 1);
        self function_9019beea("wire_09", 1);
    } else {
        self function_9019beea("wire_10", 0);
        self function_9019beea("wire_09", 0);
    }
    if (2 == newval || 3 == newval) {
        self function_9019beea("wire_02", 1);
        self function_9019beea("wire_03", 1);
        return;
    }
    self function_9019beea("wire_02", 0);
    self function_9019beea("wire_03", 0);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 7, eflags: 0x0
// Checksum 0xd1428188, Offset: 0x568
// Size: 0x20c
function function_e1729b09(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    if (!isdefined(level.var_a33e1621) || !isdefined(level.var_a33e1621.bundle) || !isdefined(level.var_a33e1621.bundle.deployanim)) {
        return;
    }
    self useanimtree("generic");
    var_b9df8180 = 1 - newval;
    if (bnewent || newval == 1) {
        self setanim(level.var_a33e1621.bundle.deployanim, 1, var_b9df8180, 0);
    }
    if (bwastimejump) {
        currentanimtime = self getanimtime(level.var_a33e1621.bundle.deployanim);
        if (var_b9df8180 < currentanimtime || bnewent) {
            self setanimtime(level.var_a33e1621.bundle.deployanim, var_b9df8180);
        }
        return;
    }
    self setanimtime(level.var_a33e1621.bundle.deployanim, var_b9df8180);
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 1, eflags: 0x0
// Checksum 0xed84b0ed, Offset: 0x780
// Size: 0x2a2
function function_e924e54e(localclientnum) {
    player = function_f97e7787(localclientnum);
    player notify(#"hash_5c7dbac0591cb11f");
    player endon(#"hash_5c7dbac0591cb11f", #"game_ended");
    level endon(#"game_ended");
    level.var_a33e1621.var_856ee88b[localclientnum] = 1;
    var_b3cf5783 = 0;
    while (true) {
        waitframe(1);
        player = function_f97e7787(localclientnum);
        if (!isdefined(player)) {
            break;
        }
        var_83c20ba7 = player function_92f39379(level.var_a33e1621.bundle.var_bbde0b27, level.var_a33e1621.bundle.maxwidth, 0, 0);
        if (!isdefined(var_83c20ba7) && !var_b3cf5783) {
            var_b3cf5783 = 1;
            player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
            continue;
        } else if (isdefined(var_83c20ba7) && var_b3cf5783) {
            var_b3cf5783 = 0;
        } else if (!isdefined(var_83c20ba7)) {
            player function_d83e9f0e(0, (0, 0, 0), (0, 0, 0));
            continue;
        }
        if (isdefined(level.var_a33e1621.bundle.var_ab65f781) ? level.var_a33e1621.bundle.var_ab65f781 : 0) {
            if (var_83c20ba7.var_397d52cc) {
                previewmodel = player function_9909341f(localclientnum, var_83c20ba7.origin, var_83c20ba7.angles, var_83c20ba7.isvalid, 0, 1);
                continue;
            }
            previewmodel = player function_9909341f(localclientnum, var_83c20ba7.origin, var_83c20ba7.angles, var_83c20ba7.isvalid, 2, 3);
        }
    }
}

// Namespace concertina_wire/gadget_concertina_wire
// Params 6, eflags: 0x0
// Checksum 0x7f70e227, Offset: 0xa30
// Size: 0x54
function function_9909341f(localclientnum, origin, angles, isvalid, var_63a58e2, var_879d5125) {
    self function_d83e9f0e(0, origin, angles);
}

