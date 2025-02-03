#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace counteruav;

// Namespace counteruav/counteruav
// Params 0, eflags: 0x6
// Checksum 0xe5c51716, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"counteruav", &preinit, undefined, undefined, #"killstreaks");
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x4
// Checksum 0x84e385cc, Offset: 0x130
// Size: 0xcc
function private preinit() {
    clientfield::register("scriptmover", "counteruav", 1, 1, "int", &enabled, 0, 0);
    clientfield::register("scriptmover", "counteruav_fx", 1, 1, "int", &function_5a528883, 0, 0);
    level.var_8c4291cb = [];
    level.var_a03cd507 = getscriptbundle(function_df836293());
}

// Namespace counteruav/counteruav
// Params 0, eflags: 0x4
// Checksum 0xaa8d818a, Offset: 0x208
// Size: 0x2c
function private function_df836293() {
    if (sessionmodeiswarzonegame()) {
        return "killstreak_counteruav_wz";
    }
    return "killstreak_counteruav";
}

// Namespace counteruav/counteruav
// Params 7, eflags: 0x0
// Checksum 0xa877afa3, Offset: 0x240
// Size: 0xbe
function enabled(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        function_e5a9ae33(fieldname, self getentitynumber(), level.var_a03cd507.var_c23de6e6);
        self thread function_c2aa1607(fieldname);
        self.killstreakbundle = level.var_a03cd507;
        return;
    }
    self notify(#"counteruav_off");
}

// Namespace counteruav/counteruav
// Params 1, eflags: 0x0
// Checksum 0xc3c59efc, Offset: 0x308
// Size: 0x5c
function function_c2aa1607(localclientnum) {
    self waittill(#"death", #"counteruav_off");
    function_4236032b(localclientnum, self getentitynumber());
}

// Namespace counteruav/counteruav
// Params 7, eflags: 0x0
// Checksum 0x8202848d, Offset: 0x370
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
// Params 1, eflags: 0x0
// Checksum 0xb03096ef, Offset: 0x450
// Size: 0x4c
function fx_think(*localclientnum) {
    self waittill(#"death", #"hash_286d0c022220571a");
    self stoploopsound(self.var_2695439d);
}

