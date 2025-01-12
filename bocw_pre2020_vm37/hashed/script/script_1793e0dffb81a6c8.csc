#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;

#namespace namespace_841de7df;

// Namespace namespace_841de7df/namespace_841de7df
// Params 0, eflags: 0x6
// Checksum 0xe1a82723, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_4ef9c479ac8da304", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_841de7df/namespace_841de7df
// Params 0, eflags: 0x4
// Checksum 0x3be69372, Offset: 0x148
// Size: 0xec
function private function_70a657d8() {
    if (!zm_trial::is_trial_mode()) {
        return;
    }
    clientfield::register("zbarrier", "" + #"hash_100f180bf5d2a517", 14000, 1, "int", &function_b245db69, 0, 0);
    level._effect[#"hash_1d15a2dad558ac8c"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
    level._effect[#"hash_1d15a5dad558b1a5"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
    zm_trial::register_challenge(#"hash_28d1b9857e2ca681", &on_begin, &on_end);
}

// Namespace namespace_841de7df/namespace_841de7df
// Params 2, eflags: 0x4
// Checksum 0x6916fcaa, Offset: 0x240
// Size: 0x14
function private on_begin(*localclientnum, *a_params) {
    
}

// Namespace namespace_841de7df/namespace_841de7df
// Params 1, eflags: 0x4
// Checksum 0xcc921d62, Offset: 0x260
// Size: 0xc
function private on_end(*localclientnum) {
    
}

// Namespace namespace_841de7df/namespace_841de7df
// Params 0, eflags: 0x0
// Checksum 0x4ff6b34, Offset: 0x278
// Size: 0x32
function is_active() {
    challenge = zm_trial::function_a36e8c38(#"hash_28d1b9857e2ca681");
    return isdefined(challenge);
}

// Namespace namespace_841de7df/namespace_841de7df
// Params 7, eflags: 0x4
// Checksum 0xd2b246b1, Offset: 0x2b8
// Size: 0x224
function private function_b245db69(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (isdefined(self.var_18f8b30b)) {
            self.var_18f8b30b delete();
        }
        if (isdefined(self.var_3b071bba)) {
            deletefx(fieldname, self.var_3b071bba);
            self.var_3b071bba = undefined;
        }
        if (zm_utility::get_story() == 1) {
            self.var_18f8b30b = util::spawn_model(fieldname, "tag_origin", self.origin, self.angles);
            self.var_3b071bba = util::playfxontag(fieldname, level._effect[#"hash_1d15a2dad558ac8c"], self.var_18f8b30b, "tag_origin");
        } else {
            self.var_18f8b30b = util::spawn_model(fieldname, "tag_origin", self.origin, self.angles);
            self.var_3b071bba = util::playfxontag(fieldname, level._effect[#"hash_1d15a5dad558b1a5"], self.var_18f8b30b, "tag_origin");
        }
        return;
    }
    if (isdefined(self.var_3b071bba)) {
        deletefx(fieldname, self.var_3b071bba);
        self.var_3b071bba = undefined;
    }
    if (isdefined(self.var_18f8b30b)) {
        self.var_18f8b30b delete();
    }
}

