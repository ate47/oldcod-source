#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x6f70303d, Offset: 0xa0
// Size: 0xb4
function init_shared() {
    clientfield::register("missile", "" + #"hash_644cb829d0133e99", 1, 1, "int", &function_a485f3cf, 0, 0);
    clientfield::register("missile", "" + #"hash_78a094001c919359", 1, 7, "float", &function_799a68b6, 0, 0);
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0xdee3127c, Offset: 0x160
// Size: 0xa2
function function_a485f3cf(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        self thread function_82dd67c1(fieldname);
        break;
    case 0:
        self thread function_ce24311a(fieldname);
        break;
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x74132c30, Offset: 0x210
// Size: 0x7c
function function_82dd67c1(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanim(#"hash_70b2041b1f6ad89", 1, 0, 0);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x8430ae2b, Offset: 0x298
// Size: 0xf4
function function_ce24311a(localclientnum) {
    self endon(#"death");
    self util::waittill_dobj(localclientnum);
    self useanimtree("generic");
    self setanim(#"hash_70b2041b1f6ad89");
    wait getanimlength(#"hash_70b2041b1f6ad89");
    self.currentanimtime = 0.5;
    self setanimknob(#"hash_3c4ee18df7d43dc7", 1, 0, 0);
    self setanimtime(#"hash_3c4ee18df7d43dc7", 0.5);
}

// Namespace trophy_system/trophy_system
// Params 7, eflags: 0x0
// Checksum 0xf0811ea0, Offset: 0x398
// Size: 0x232
function function_799a68b6(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    var_cfdbef0c = bwastimejump;
    if (!isdefined(self.currentanimtime)) {
        self.currentanimtime = 0.5;
    }
    self useanimtree("generic");
    self setanimknob(#"hash_3c4ee18df7d43dc7", 1, 0, 0.1);
    elapsedtime = 0;
    var_cfdbef0c = int(var_cfdbef0c * 100) / 100;
    while (true) {
        waitframe(1);
        elapsedtime += 0.016;
        if (elapsedtime >= 0.1) {
            break;
        }
        var_57931d7 = lerpfloat(self.currentanimtime, var_cfdbef0c, elapsedtime / 0.1);
        self setanimtime(#"hash_3c4ee18df7d43dc7", var_57931d7);
    }
    if (var_cfdbef0c < 0.25) {
        var_cfdbef0c += 0.5;
    } else if (var_cfdbef0c > 0.75) {
        var_cfdbef0c -= 0.5;
    }
    self setanimtime(#"hash_3c4ee18df7d43dc7", var_cfdbef0c);
    self clearanim(#"hash_3c4ee18df7d43dc7", 0);
    self.currentanimtime = var_cfdbef0c;
}

