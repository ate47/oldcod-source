#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_98decc78;

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x6
// Checksum 0xdba038db, Offset: 0xf0
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_5cb28995c23c44a", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 0, eflags: 0x5 linked
// Checksum 0x558e9951, Offset: 0x138
// Size: 0x5c
function private function_70a657d8() {
    clientfield::register("toplayer", "" + #"hash_3a86c740229275b7", 1, 3, "counter", &function_d5270d1a, 0, 0);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 7, eflags: 0x1 linked
// Checksum 0x5aa5927f, Offset: 0x1a0
// Size: 0x284
function function_d5270d1a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    util::waittill_dobj(localclientnum);
    self endon(#"death");
    self thread postfx::playpostfxbundle(#"hash_1d2ed88d1700cf24");
    if (newval === 1) {
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", 1);
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", 0);
    } else if (newval === 2) {
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", -1);
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", 0);
    } else if (newval === 3) {
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", 0);
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", 1);
    } else if (newval === 4) {
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin Y", 0);
        self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Origin X", -1);
    }
    if (!isdefined(self.var_f0007ebc)) {
        self.var_f0007ebc = 0;
    }
    self thread function_28efdb7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 7, eflags: 0x1 linked
// Checksum 0x35b62956, Offset: 0x430
// Size: 0x1a4
function function_28efdb7f(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self.var_d5e7df0f = 1;
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Opacity", 0);
    self util::lerp_generic(bwastimejump, 175, &function_606248f8, self.var_f0007ebc, 1, "Opacity", #"hash_1d2ed88d1700cf24");
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Screen Radius Inner", 0.5);
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Screen Radius Outer", 0.7);
    wait 0.175;
    self util::lerp_generic(bwastimejump, 1650, &function_606248f8, self.var_f0007ebc, 0, "Opacity", #"hash_1d2ed88d1700cf24");
}

// Namespace namespace_98decc78/namespace_98decc78
// Params 8, eflags: 0x1 linked
// Checksum 0x9697a3d7, Offset: 0x5e0
// Size: 0xec
function function_606248f8(*currenttime, elapsedtime, *localclientnum, duration, stagefrom, stageto, *constant, *postfx) {
    self endon(#"death");
    if (!self postfx::function_556665f2(#"hash_1d2ed88d1700cf24")) {
        return;
    }
    percent = stagefrom / stageto;
    amount = postfx * percent + constant * (1 - percent);
    self.var_f0007ebc = amount;
    self postfx::function_c8b5f318(#"hash_1d2ed88d1700cf24", "Opacity", amount);
}

