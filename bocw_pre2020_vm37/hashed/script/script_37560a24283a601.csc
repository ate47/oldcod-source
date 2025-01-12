#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_797fe2e7;

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 0, eflags: 0x6
// Checksum 0xbb0832e1, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_607f0336b64df630", &function_70a657d8, undefined, undefined, #"hash_13a43d760497b54d");
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 0, eflags: 0x5 linked
// Checksum 0x8407b609, Offset: 0xf8
// Size: 0xb4
function private function_70a657d8() {
    clientfield::register("missile", "" + #"hash_36112e7cad541b66", 1, 2, "int", &function_9cb928dc, 1, 0);
    clientfield::register("missile", "" + #"hash_2d55ead1309349bc", 1, 2, "int", &function_6bd975fa, 1, 0);
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 7, eflags: 0x1 linked
// Checksum 0x65b2dfd0, Offset: 0x1b8
// Size: 0x1de
function function_9cb928dc(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
    case 2:
        var_8cce6a5c = #"hash_302e7c518042ef82";
        break;
    case 3:
        var_8cce6a5c = #"hash_57ddfc09a8a5cfee";
        break;
    }
    if (isdefined(var_8cce6a5c)) {
        self.var_214a11f9 = playfx(fieldname, var_8cce6a5c, self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        if (!isdefined(self.var_d912eb65)) {
            self playsound(fieldname, #"hash_3f0bee7329c6d063");
            self.var_d912eb65 = self playloopsound(#"hash_d9ada961eacdf0");
        }
        return;
    }
    if (isdefined(self.var_214a11f9)) {
        stopfx(fieldname, self.var_214a11f9);
        self.var_214a11f9 = undefined;
    }
    if (isdefined(self.var_d912eb65)) {
        self stoploopsound(self.var_d912eb65);
        self.var_d912eb65 = undefined;
    }
}

// Namespace namespace_797fe2e7/namespace_797fe2e7
// Params 7, eflags: 0x1 linked
// Checksum 0x57fd5277, Offset: 0x3a0
// Size: 0x186
function function_6bd975fa(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    switch (bwastimejump) {
    case 1:
        var_90048701 = #"hash_1afd3356d5225a80";
        break;
    case 2:
        var_90048701 = #"hash_7a5d71decf1bdefb";
        break;
    case 3:
        var_90048701 = #"hash_d33a825314c9dac";
        break;
    }
    if (isdefined(var_90048701)) {
        self.var_90048701 = playfx(fieldname, var_90048701, self.origin, anglestoforward(self.angles), anglestoup(self.angles));
        self playsound(fieldname, #"hash_6803d4ae1d74d42d");
        return;
    }
    if (isdefined(self.var_90048701)) {
        stopfx(fieldname, self.var_90048701);
        self.var_90048701 = undefined;
    }
}

