#using script_44c87b4589ee1f93;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_ec0691f8;

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x6
// Checksum 0xe5205447, Offset: 0x108
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_4863f776a30a1247", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 0, eflags: 0x5 linked
// Checksum 0x1476f0d3, Offset: 0x150
// Size: 0xdc
function private function_70a657d8() {
    clientfield::register("actor", "sr_dog_fx", 15000, 1, "int", &dog_fx, 0, 0);
    clientfield::register("actor", "sr_dog_spawn_fx", 15000, 1, "counter", &dog_spawn_fx, 0, 0);
    clientfield::register("actor", "sr_dog_pre_spawn_fx", 15000, 1, "counter", &function_30933ca1, 0, 0);
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 7, eflags: 0x1 linked
// Checksum 0x2ec50fa, Offset: 0x238
// Size: 0x16c
function dog_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(fieldname);
    if (!isdefined(self)) {
        return;
    }
    if (bwastimejump) {
        if (!isdefined(self.var_93471229)) {
            self.var_93471229 = [];
        }
        self mapshaderconstant(fieldname, 0, "scriptVector2", 0, 1, 1);
        return;
    }
    if (isdefined(self.var_93471229)) {
        foreach (fxhandle in self.var_93471229) {
            deletefx(fieldname, fxhandle);
        }
    }
    util::playfxontag(fieldname, #"hash_529c1a5672216926", self, "j_spine2");
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 7, eflags: 0x1 linked
// Checksum 0x74aee97a, Offset: 0x3b0
// Size: 0x21c
function function_30933ca1(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    util::waittill_dobj(bwastimejump);
    if (!isdefined(self)) {
        return;
    }
    if (self.var_9fde8624 === #"hash_2a5479b83161cb35") {
        var_d1dc644a = playfx(bwastimejump, #"hash_baef237a01b261a", self.origin + (0, 0, 36), anglestoup(self.angles));
        playsound(bwastimejump, #"hash_6b6572c7d66929d", self.origin + (0, 0, 36));
    } else if (self.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        var_d1dc644a = playfx(bwastimejump, #"hash_2de6c1300bec68cd", self.origin + (0, 0, 36), anglestoup(self.angles));
        playsound(bwastimejump, #"hash_3731f907ac5beb1", self.origin + (0, 0, 36));
    } else {
        playsound(bwastimejump, #"hash_1b702e745dd73148", self.origin + (0, 0, 36));
    }
    wait 1;
    if (isdefined(var_d1dc644a)) {
        stopfx(bwastimejump, var_d1dc644a);
    }
}

// Namespace namespace_ec0691f8/namespace_ec0691f8
// Params 7, eflags: 0x1 linked
// Checksum 0xc2a70fd4, Offset: 0x5d8
// Size: 0x1d4
function dog_spawn_fx(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (self.var_9fde8624 === #"hash_2a5479b83161cb35") {
        util::playfxontag(bwasdemojump, #"hash_784a8bc7b9b17876", self, "j_spine2");
        playsound(bwasdemojump, #"hash_6ba18f5ab09d3e00", self.origin + (0, 0, 36));
    } else if (self.var_9fde8624 === #"hash_28e36e7b7d5421f") {
        util::playfxontag(bwasdemojump, #"hash_44214bf58f0e6d87", self, "j_spine2");
        playsound(bwasdemojump, #"hash_6a7f1f4ef6078e4", self.origin + (0, 0, 36));
    } else {
        util::playfxontag(bwasdemojump, level._effect[#"lightning_dog_spawn"], self, "j_spine2");
        playsound(bwasdemojump, #"hash_342202bccfe632e3", self.origin + (0, 0, 36));
    }
    fxclientutils::playfxbundle(bwasdemojump, self, self.fxdef);
}

