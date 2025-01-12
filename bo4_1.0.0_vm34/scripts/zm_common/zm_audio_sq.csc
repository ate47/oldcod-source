#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace zm_audio_sq;

// Namespace zm_audio_sq/zm_audio_sq
// Params 0, eflags: 0x0
// Checksum 0x2d94e038, Offset: 0x98
// Size: 0x7a
function init() {
    clientfield::register("scriptmover", "medallion_fx", 1, 1, "int", &function_6a463c37, 0, 0);
    level._effect[#"medallion_exp"] = #"hash_4960d9278d639297";
}

// Namespace zm_audio_sq/zm_audio_sq
// Params 7, eflags: 0x0
// Checksum 0xf929d1aa, Offset: 0x120
// Size: 0x10c
function function_6a463c37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        up = anglestoup(self.angles + (0, -90, -90));
        forward = anglestoforward(self.angles + (0, -90, -90));
        playfx(localclientnum, level._effect[#"medallion_exp"], self.origin, forward, up);
        playsound(localclientnum, #"hash_23ed06ab941bc579", self.origin);
    }
}

