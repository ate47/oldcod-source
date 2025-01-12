#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;

#namespace namespace_fa1c4f0a;

// Namespace namespace_fa1c4f0a/level_init
// Params 1, eflags: 0x40
// Checksum 0xe1a4086a, Offset: 0x180
// Size: 0x174
function event_handler[level_init] main(*eventstruct) {
    clientfield::register("scriptmover", "payload_teleport", 1, 2, "int", &function_5884461e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_85dd1e407a282d9", 1, 1, "int", &function_691412b4, 0, 0);
    clientfield::register("toplayer", "" + #"hash_19f93b2cb70ea2c5", 1, 1, "int", &function_fa7a206b, 0, 0);
    clientfield::register("vehicle", "" + #"hash_75190371f51baf5f", 1, 1, "counter", &function_96636479, 0, 0);
    util::waitforclient(0);
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 7, eflags: 0x0
// Checksum 0xf8c9aaef, Offset: 0x300
// Size: 0xcc
function function_5884461e(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self util::waittill_dobj(fieldname);
    if (bwastimejump == 1) {
        function_239993de(fieldname, "sr/fx9_obj_payload_teleport_depart", self, "tag_origin");
        return;
    }
    if (bwastimejump == 2) {
        function_239993de(fieldname, "sr/fx9_obj_payload_teleport_arrive", self, "tag_origin");
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 7, eflags: 0x0
// Checksum 0xc16c7913, Offset: 0x3d8
// Size: 0x9c
function function_96636479(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    playfx(bwastimejump, "maps/zm_escape/fx8_brutus_transformation_shockwave", self.origin + (0, 0, 32), anglestoforward(self.angles), anglestoup(self.angles));
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 7, eflags: 0x0
// Checksum 0x2986512e, Offset: 0x480
// Size: 0x13c
function function_fa7a206b(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self postfx::playpostfxbundle(#"pstfx_speedblur");
        self function_116b95e5(#"pstfx_speedblur", #"inner mask", 0.3);
        self function_116b95e5(#"pstfx_speedblur", #"outer mask", 0.8);
        self thread function_d233fb1f();
        return;
    }
    self notify(#"hash_639f680ae2bb2ff");
    wait 0.05;
    self postfx::exitpostfxbundle(#"pstfx_speedblur");
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 0, eflags: 0x0
// Checksum 0x13e868f8, Offset: 0x5c8
// Size: 0xc0
function function_d233fb1f() {
    self endon(#"death", #"disconnect", #"hash_639f680ae2bb2ff");
    for (var_9b8a1091 = 0.01; true; var_9b8a1091 += 0.01) {
        self function_116b95e5(#"pstfx_speedblur", #"blur", var_9b8a1091);
        wait 0.08;
        if (var_9b8a1091 < 0.3) {
        }
    }
}

// Namespace namespace_fa1c4f0a/namespace_fa1c4f0a
// Params 7, eflags: 0x0
// Checksum 0x886ed7f2, Offset: 0x690
// Size: 0xa4
function function_691412b4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self.var_942f8233 = util::playfxontag(fieldname, "sr/fx9_boss_orb_aether_travel", self, "tag_origin");
        return;
    }
    if (isdefined(self.var_942f8233)) {
        stopfx(fieldname, self.var_942f8233);
    }
}

