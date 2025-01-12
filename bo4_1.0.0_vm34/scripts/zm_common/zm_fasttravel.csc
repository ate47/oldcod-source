#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace zm_fasttravel;

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x2
// Checksum 0x8678a94, Offset: 0x218
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_fasttravel", &__init__, undefined, undefined);
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0xf7d1c898, Offset: 0x260
// Size: 0x24
function __init__() {
    init_clientfields();
    init_fx();
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0x195a0439, Offset: 0x290
// Size: 0x1fc
function init_clientfields() {
    clientfield::register("world", "fasttravel_exploder", 1, 1, "int", &fasttravel_exploder, 0, 0);
    clientfield::register("toplayer", "player_stargate_fx", 1, 1, "int", &player_stargate_fx, 0, 0);
    clientfield::register("toplayer", "player_chaos_light_rail_fx", 1, 1, "int", &player_chaos_light_rail_fx, 0, 0);
    clientfield::register("toplayer", "fasttravel_teleport_sfx", 1, 1, "int", &fasttravel_teleport_sfx, 0, 0);
    clientfield::register("allplayers", "fasttravel_start_fx", 1, 1, "counter", &fasttravel_start_fx, 0, 0);
    clientfield::register("allplayers", "fasttravel_end_fx", 1, 1, "counter", &fasttravel_end_fx, 0, 0);
    clientfield::register("allplayers", "fasttravel_rail_fx", 1, 2, "int", &fasttravel_rail_fx, 0, 0);
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 0, eflags: 0x0
// Checksum 0x7f4a45ba, Offset: 0x498
// Size: 0x152
function init_fx() {
    level._effect[#"fasttravel_start"] = #"hash_2f54a4439f3a1dbf";
    level._effect[#"fasttravel_end"] = #"hash_4ab05aa1282b9bb7";
    level._effect[#"fasttravel_rail_1p"] = #"hash_259bb7806d596ed3";
    level._effect[#"fasttravel_break_1p"] = #"hash_37257517a8fd29e";
    level._effect[#"fasttravel_rail_3p"] = #"hash_809f6b4b699e4df";
    level._effect[#"fasttravel_break_3p"] = #"hash_13715b19c0c0e890";
    level._effect[#"fasttravel_rail_travel"] = #"hash_3659a06ed75f940a";
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x28beeaa5, Offset: 0x5f8
// Size: 0x84
function fasttravel_exploder(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level exploder::exploder("fxexp_fast_travel_orbs");
        return;
    }
    level exploder::stop_exploder("fxexp_fast_travel_orbs");
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x65e4513a, Offset: 0x688
// Size: 0x20e
function player_chaos_light_rail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"player_chaos_light_rail_fx");
    self endon(#"player_chaos_light_rail_fx");
    if (newval) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        if (self != function_f97e7787(localclientnum)) {
            return;
        }
        var_13f86a82 = self getlinkedent();
        if (isdefined(var_13f86a82)) {
            var_282bafc9 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin("tag_eye"), var_13f86a82.angles);
            var_282bafc9 linkto(var_13f86a82);
            var_282bafc9.n_fx_id = util::playfxontag(localclientnum, level._effect[#"fasttravel_rail_travel"], var_282bafc9, "tag_origin");
        }
        self thread function_7ae8a5a1(localclientnum, var_282bafc9);
        if (isdefined(level.var_affe400c)) {
            self thread postfx::playpostfxbundle(level.var_affe400c);
        } else {
            self thread postfx::playpostfxbundle("pstfx_zm_chaos_temp");
        }
        return;
    }
    self notify(#"hash_55c46612daf60935");
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 2, eflags: 0x0
// Checksum 0x2642621c, Offset: 0x8a0
// Size: 0xf4
function function_7ae8a5a1(localclientnum, var_282bafc9) {
    self waittill(#"player_chaos_light_rail_fx", #"hash_55c46612daf60935", #"death");
    if (isdefined(var_282bafc9) && isdefined(var_282bafc9.n_fx_id)) {
        stopfx(localclientnum, var_282bafc9.n_fx_id);
        var_282bafc9 delete();
    }
    if (isdefined(self)) {
        if (isdefined(level.var_affe400c)) {
            self postfx::exitpostfxbundle(level.var_affe400c);
            return;
        }
        self postfx::exitpostfxbundle("pstfx_zm_chaos_temp");
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x21026524, Offset: 0x9a0
// Size: 0x136
function player_stargate_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"player_stargate_fx");
    self endon(#"player_stargate_fx");
    if (newval == 1) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        self thread function_e7a8756e(localclientnum);
        self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
        if (isdefined(self.var_35d29b54)) {
        }
        return;
    }
    self notify(#"hash_4bb091d9149d038b");
    if (isdefined(self.var_35d29b54)) {
        self stoploopsound(self.var_35d29b54);
        self.var_35d29b54 = undefined;
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 1, eflags: 0x0
// Checksum 0xbb2ceb64, Offset: 0xae0
// Size: 0x64
function function_e7a8756e(localclientnum) {
    self waittill(#"player_stargate_fx", #"hash_4bb091d9149d038b", #"death");
    if (isdefined(self)) {
        self postfx::exitpostfxbundle("pstfx_zm_wormhole");
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x5efefbfc, Offset: 0xb50
// Size: 0x106
function fasttravel_teleport_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.fasttravel_teleport_sfx)) {
            self playsound(localclientnum, #"hash_695df080bafaf6b7");
            self.fasttravel_teleport_sfx = self playloopsound(#"hash_337255a64f96457b");
        }
        return;
    }
    if (isdefined(self.fasttravel_teleport_sfx)) {
        self playsound(localclientnum, #"hash_32def2a5219ba9ee");
        self stoploopsound(self.fasttravel_teleport_sfx);
        self.fasttravel_teleport_sfx = undefined;
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x1443675f, Offset: 0xc60
// Size: 0x184
function fasttravel_start_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self != function_f97e7787(localclientnum)) {
        if (newval == 1) {
            var_bcd205ed = struct::get_array("fasttravel_trigger", "targetname");
            var_274fc91f = arraygetclosest(self.origin, var_bcd205ed);
            if (!isdefined(var_274fc91f)) {
                return;
            }
            v_angles = vectortoangles(var_274fc91f.origin - self.origin);
            mdl_fx = util::spawn_model(localclientnum, "tag_origin", self.origin, v_angles);
            waitframe(1);
            util::playfxontag(localclientnum, level._effect[#"fasttravel_start"], mdl_fx, "tag_origin");
            wait 1.5;
            mdl_fx delete();
        }
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x390f63ce, Offset: 0xdf0
// Size: 0x12c
function fasttravel_end_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self != function_f97e7787(localclientnum)) {
        if (newval == 1) {
            v_angles = combineangles(self.angles, (-90, 0, 0));
            mdl_fx = util::spawn_model(localclientnum, "tag_origin", self.origin, v_angles);
            waitframe(1);
            util::playfxontag(localclientnum, level._effect[#"fasttravel_end"], mdl_fx, "tag_origin");
            wait 1.15;
            mdl_fx delete();
        }
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 7, eflags: 0x0
// Checksum 0x86e1a8d3, Offset: 0xf28
// Size: 0x3de
function fasttravel_rail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.sfx_fasttravel)) {
            self playsound(localclientnum, #"hash_7204b092c976136b");
            self.sfx_fasttravel = self playloopsound(#"hash_33b6a998603c309d");
        }
        if (!isdefined(self.var_828e2754)) {
            v_angles = self.angles;
            if (self == function_f97e7787(localclientnum)) {
                v_origin = self gettagorigin("tag_eye");
                self.var_828e2754 = self function_90a8873e(localclientnum, "fasttravel_rail_1p", "tag_origin", v_origin, v_angles);
            } else {
                v_origin = self gettagorigin("j_spine4");
                self.var_828e2754 = self function_90a8873e(localclientnum, "fasttravel_rail_3p", "tag_origin", v_origin, v_angles);
            }
        }
        return;
    }
    if (newval == 2) {
        if (!isdefined(self.sfx_fasttravel)) {
            self playsound(localclientnum, #"hash_7f171ce50ab41fb8");
            self.sfx_fasttravel = self playloopsound(#"hash_59921813746566c8");
        }
        if (isdefined(self.var_828e2754)) {
            v_angles = self.angles;
            if (self == function_f97e7787(localclientnum)) {
                self function_a5623500(localclientnum, self.var_828e2754);
                v_origin = self gettagorigin("tag_eye");
                self.var_828e2754 = self function_90a8873e(localclientnum, "fasttravel_break_1p", "tag_origin", v_origin, v_angles);
            } else {
                self function_a5623500(localclientnum, self.var_828e2754);
                v_origin = self gettagorigin("j_spine4");
                self.var_828e2754 = self function_90a8873e(localclientnum, "fasttravel_break_3p", "tag_origin", v_origin, v_angles);
            }
        }
        return;
    }
    if (newval == 0) {
        if (isdefined(self.var_828e2754)) {
            self function_a5623500(localclientnum, self.var_828e2754);
            self.var_828e2754 = undefined;
        }
        if (isdefined(self.sfx_fasttravel)) {
            self playsound(localclientnum, #"hash_588047eba8deb34e");
            self stoploopsound(self.sfx_fasttravel);
            self.sfx_fasttravel = undefined;
        }
    }
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 5, eflags: 0x4
// Checksum 0xd626891d, Offset: 0x1310
// Size: 0xb2
function private function_90a8873e(localclientnum, str_fx, str_tag, v_origin, v_angles) {
    self.mdl_fx = util::spawn_model(localclientnum, "tag_origin", v_origin, v_angles);
    self.mdl_fx linkto(self, str_tag);
    var_828e2754 = util::playfxontag(localclientnum, level._effect[str_fx], self.mdl_fx, "tag_origin");
    return var_828e2754;
}

// Namespace zm_fasttravel/zm_fasttravel
// Params 2, eflags: 0x4
// Checksum 0x568e2149, Offset: 0x13d0
// Size: 0x54
function private function_a5623500(localclientnum, var_828e2754) {
    stopfx(localclientnum, var_828e2754);
    if (isdefined(self.mdl_fx)) {
        self.mdl_fx delete();
    }
}

