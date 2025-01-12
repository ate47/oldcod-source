#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x6
// Checksum 0xa747a66f, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"counteruav", &function_70a657d8, undefined, undefined, #"killstreaks");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x5 linked
// Checksum 0x724eb36c, Offset: 0x130
// Size: 0xcc
function private function_70a657d8() {
    clientfield::register("scriptmover", "counteruav", 1, 1, "int", &enabled, 0, 0);
    clientfield::register("scriptmover", "counteruav_fx", 1, 1, "int", &function_5a528883, 0, 0);
    level.var_8c4291cb = [];
    level.var_a03cd507 = getscriptbundle(function_df836293());
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x5 linked
// Checksum 0x26907bf8, Offset: 0x208
// Size: 0x2c
function private function_df836293() {
    if (sessionmodeiswarzonegame()) {
        return "killstreak_counteruav_wz";
    }
    return "killstreak_counteruav";
}

// Namespace counteruav/counteruav
// Params 7, eflags: 0x1 linked
// Checksum 0x8850cb51, Offset: 0x240
// Size: 0xd6
function enabled(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        self function_1f0c7136(2);
        function_e5a9ae33(fieldname, self getentitynumber(), level.var_a03cd507.var_c23de6e6);
        self thread function_c2aa1607(fieldname);
        self.killstreakbundle = level.var_a03cd507;
        return;
    }
    self notify(#"hash_367b9a7b1a2d9523");
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0xc1e39402, Offset: 0x320
// Size: 0x5c
function function_c2aa1607(localclientnum) {
    self waittill(#"death", #"hash_367b9a7b1a2d9523");
    function_4236032b(localclientnum, self getentitynumber());
}

// Namespace counteruav/counteruav
// Params 7, eflags: 0x1 linked
// Checksum 0xdc668dc2, Offset: 0x388
// Size: 0xd6
function function_5a528883(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.killstreakbundle)) {
        self.killstreakbundle = level.var_a03cd507;
    }
    if (!self function_ca024039()) {
        if (bwastimejump) {
            self.var_2695439d = self playloopsound(#"veh_uav_engine_loop", 1);
            self thread fx_think(fieldname);
            return;
        }
        self notify(#"hash_286d0c022220571a");
    }
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x1 linked
// Checksum 0x8ec8af54, Offset: 0x468
// Size: 0x4c
function fx_think(*localclientnum) {
    self waittill(#"death", #"hash_286d0c022220571a");
    self stoploopsound(self.var_2695439d);
}

