#using scripts\core_common\audio_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\explode;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace player_free_fall;

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x2
// Checksum 0x21de9e9d, Offset: 0x170
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"player_free_fall", &__init__, undefined, undefined);
}

// Namespace player_free_fall/player_free_fall
// Params 0, eflags: 0x0
// Checksum 0xe17ac3ff, Offset: 0x1b8
// Size: 0xf4
function __init__() {
    level._effect[#"hash_2d7e36f50e763c4a"] = #"hash_3cb3a6fc9eb00337";
    level._effect[#"hash_71f4fac26bef1997"] = #"hash_3919b64dc762cab2";
    level._effect[#"hash_453e08d08c052ca7"] = #"hash_2f9443dd314fa016";
    callback::add_callback(#"freefall", &function_6b439695);
    callback::add_callback(#"parachute", &function_a1324b02);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x96f787dc, Offset: 0x2b8
// Size: 0x54
function private function_a1324b02(eventstruct) {
    if (self function_60dbc438()) {
        self function_7669269a(eventstruct.localclientnum, eventstruct.parachute);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x25cd210e, Offset: 0x318
// Size: 0x5c
function private function_6b439695(eventstruct) {
    if (eventstruct.freefall) {
        self function_dcab0387(eventstruct.localclientnum);
        return;
    }
    self freefallend(eventstruct.localclientnum);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0xa36499e6, Offset: 0x380
// Size: 0x538
function function_7c33f02b(localclientnum) {
    self notify("3c01812c3b75da35");
    self endon("3c01812c3b75da35");
    self endon(#"death", #"disconnect", #"freefallend");
    var_945c2210 = getdvarfloat(#"hash_51ca5e31e2f799cf", 0.03);
    var_f5de2243 = getdvarfloat(#"hash_199e8f1582907faa", 0);
    var_272b2258 = getdvarfloat(#"hash_63e8ba0a2fcb9307", 0);
    var_83fb2f0e = getdvarfloat(#"hash_2bb793f2496ec17f", 0.05);
    while (true) {
        waitframe(1);
        vel = self getvelocity();
        speed = length(vel);
        angles = self getcamangles();
        viewpitch = 0;
        if (isdefined(angles)) {
            viewpitch = angles[0];
            if (viewpitch > 180) {
                viewpitch -= 360;
            }
        }
        var_42903e82 = math::linear_map(viewpitch, 0, 90, var_945c2210, var_83fb2f0e);
        var_ff18fb17 = speed;
        if (var_ff18fb17 > getdvarfloat(#"hash_2170aec1f5630e25", 2112)) {
            var_ff18fb17 = getdvarfloat(#"hash_2170aec1f5630e25", 2112);
        }
        var_80f6d221 = math::linear_map(var_ff18fb17, getdvarfloat(#"hash_7327958f199ff418", 300), getdvarfloat(#"hash_2170aec1f5630e25", 2112), var_945c2210, var_83fb2f0e);
        var_cbf68d6b = function_e8c50f74(viewpitch, 0, 90, getdvarfloat(#"hash_4505f7b3e3e2816c", 0.8), getdvarfloat(#"hash_18252e5dd4c3c9c4", 0.45));
        var_6f3de28a = function_e8c50f74(viewpitch, 0, 90, getdvarfloat(#"hash_ce49a97261c2d13", 0.95), getdvarfloat(#"hash_7ca65a9047914ab", 0.7));
        var_6244a5a4 = (var_80f6d221 + var_42903e82) / 2;
        if (speed < getdvarfloat(#"hash_7327958f199ff418", 300)) {
            if (self postfx::function_7348f3a5("pstfx_speedblur_wz")) {
                postfx::exitpostfxbundle("pstfx_speedblur_wz");
            }
            continue;
        }
        if (!self postfx::function_7348f3a5("pstfx_speedblur_wz")) {
            self postfx::playpostfxbundle("pstfx_speedblur_wz");
        }
        self function_202a8b08("pstfx_speedblur_wz", #"blur", var_6244a5a4);
        self function_202a8b08("pstfx_speedblur_wz", #"inner mask", var_cbf68d6b);
        self function_202a8b08("pstfx_speedblur_wz", #"outer mask", var_6f3de28a);
        self function_202a8b08("pstfx_speedblur_wz", #"x offset", var_f5de2243);
        self function_202a8b08("pstfx_speedblur_wz", #"y offset", var_272b2258);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 5, eflags: 0x0
// Checksum 0x2eb9953e, Offset: 0x8c0
// Size: 0x4e
function function_e8c50f74(pitch, min_pitch, max_pitch, var_3aba38de, var_5727c440) {
    return (var_5727c440 - var_3aba38de) / (max_pitch - min_pitch) * pitch + var_3aba38de;
}

/#

    // Namespace player_free_fall/player_free_fall
    // Params 1, eflags: 0x0
    // Checksum 0x286a3e51, Offset: 0x918
    // Size: 0xbe
    function printspeed(viewpitch) {
        self endon(#"death", #"disconnect", #"freefallend");
        while (true) {
            vel = self getvelocity();
            speed = length(vel);
            iprintlnbold("<dev string:x30>" + speed + "<dev string:x3b>" + viewpitch);
            wait 1;
        }
    }

#/

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x34ec0230, Offset: 0x9e0
// Size: 0x84
function function_dcab0387(localclientnum) {
    if (self function_60dbc438()) {
        self thread function_7c33f02b(localclientnum);
        self thread function_2bd7cac6(localclientnum);
        self thread function_bcb77e78(localclientnum);
        self thread function_6e4809cb(localclientnum);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x66535df0, Offset: 0xa70
// Size: 0x3c
function function_3e623c3d(timesec) {
    self endon(#"death");
    wait timesec;
    self delete();
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x4e591d1f, Offset: 0xab8
// Size: 0x3b0
function function_6e4809cb(localclientnum) {
    if (self function_60dbc438()) {
        self endoncallback(&function_7c0af409, #"death", #"freefallend");
        while (true) {
            vel = self getvelocity();
            speed = length(vel);
            angles = self getcamangles();
            viewpitch = 0;
            if (isdefined(angles)) {
                viewpitch = angles[0];
                if (viewpitch > 180) {
                    viewpitch -= 360;
                }
            }
            if (speed < 1500) {
                if (isdefined(self.var_49bf6fe6)) {
                    stopfx(localclientnum, self.var_49bf6fe6);
                    self.var_49bf6fe6 = undefined;
                }
                if (isdefined(self.var_23bcf57d)) {
                    stopfx(localclientnum, self.var_23bcf57d);
                    self.var_23bcf57d = undefined;
                }
                if (isdefined(self.var_fdba7b14)) {
                    stopfx(localclientnum, self.var_fdba7b14);
                    self.var_fdba7b14 = undefined;
                }
                if (isdefined(self.var_d7b800ab)) {
                    stopfx(localclientnum, self.var_d7b800ab);
                    self.var_d7b800ab = undefined;
                }
                waitframe(1);
                continue;
            }
            if (!isdefined(self.var_49bf6fe6)) {
                self.var_49bf6fe6 = self util::playfxontag(localclientnum, level._effect[#"hash_453e08d08c052ca7"], self, "j_wrist_ri");
            }
            if (!isdefined(self.var_23bcf57d)) {
                self.var_23bcf57d = self util::playfxontag(localclientnum, level._effect[#"hash_453e08d08c052ca7"], self, "j_wrist_le");
            }
            if (viewpitch < 75) {
                if (!isdefined(self.var_fdba7b14)) {
                    self.var_fdba7b14 = self util::playfxontag(localclientnum, level._effect[#"hash_453e08d08c052ca7"], self, "j_ankle_ri");
                }
                if (!isdefined(self.var_d7b800ab)) {
                    self.var_d7b800ab = self util::playfxontag(localclientnum, level._effect[#"hash_453e08d08c052ca7"], self, "j_ankle_le");
                }
            } else {
                if (isdefined(self.var_fdba7b14)) {
                    stopfx(localclientnum, self.var_fdba7b14);
                    self.var_fdba7b14 = undefined;
                }
                if (isdefined(self.var_d7b800ab)) {
                    stopfx(localclientnum, self.var_d7b800ab);
                    self.var_d7b800ab = undefined;
                }
            }
            waitframe(1);
        }
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x11416ff0, Offset: 0xe70
// Size: 0x146
function function_7c0af409(notifyhash) {
    if (self function_60dbc438()) {
        if (isdefined(self.var_49bf6fe6)) {
            stopfx(self getlocalclientnumber(), self.var_49bf6fe6);
            self.var_49bf6fe6 = undefined;
        }
        if (isdefined(self.var_23bcf57d)) {
            stopfx(self getlocalclientnumber(), self.var_23bcf57d);
            self.var_23bcf57d = undefined;
        }
        if (isdefined(self.var_fdba7b14)) {
            stopfx(self getlocalclientnumber(), self.var_fdba7b14);
            self.var_fdba7b14 = undefined;
        }
        if (isdefined(self.var_d7b800ab)) {
            stopfx(self getlocalclientnumber(), self.var_d7b800ab);
            self.var_d7b800ab = undefined;
        }
    }
}

// Namespace player_free_fall/player_free_fall
// Params 3, eflags: 0x0
// Checksum 0xce215493, Offset: 0xfc0
// Size: 0x80
function function_4e3e7807(localclientnum, height, fxid) {
    self endon(#"death", #"freefallend");
    while (true) {
        if (self.origin[2] < height) {
            self thread function_60b35c6b(localclientnum, fxid);
            return;
        }
        wait 1;
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x2b86b97a, Offset: 0x1048
// Size: 0xec
function function_2bd7cac6(localclientnum) {
    if (!isdefined(self.var_5f96072)) {
        self.var_5f96072 = util::playfxontag(localclientnum, level._effect[#"hash_2d7e36f50e763c4a"], self, "tag_origin");
        self thread function_4e3e7807(localclientnum, 12000, self.var_5f96072);
    }
    if (!isdefined(self.var_cd5ad3df)) {
        self.var_cd5ad3df = util::playfxontag(localclientnum, level._effect[#"hash_71f4fac26bef1997"], self, "tag_origin");
        self thread function_4e3e7807(localclientnum, 30000, self.var_cd5ad3df);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 2, eflags: 0x0
// Checksum 0x263038a5, Offset: 0x1140
// Size: 0x34
function function_60b35c6b(localclientnum, fxid) {
    if (isdefined(fxid)) {
        stopfx(localclientnum, fxid);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0xa6927b7a, Offset: 0x1180
// Size: 0x5e
function function_b49dbe0f(localclientnum) {
    function_60b35c6b(localclientnum, self.var_5f96072);
    function_60b35c6b(localclientnum, self.var_cd5ad3df);
    self.var_5f96072 = undefined;
    self.var_cd5ad3df = undefined;
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x41965d8c, Offset: 0x11e8
// Size: 0x62
function function_bcb77e78(localclientnum) {
    if (isdefined(self.var_deacf46c)) {
        self stoploopsound(self.var_deacf46c, 0);
        self.var_deacf46c = undefined;
    }
    self.var_deacf46c = self playloopsound("evt_skydive_wind_heavy", 1);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x2fdfc3fc, Offset: 0x1258
// Size: 0x3e
function function_78ca4855(localclientnum) {
    if (isdefined(self.var_deacf46c)) {
        self stoploopsound(self.var_deacf46c, 0);
        self.var_deacf46c = undefined;
    }
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0xaab575c2, Offset: 0x12a0
// Size: 0x104
function freefallend(localclientnum) {
    self notify(#"freefallend");
    if (self function_60dbc438()) {
        function_8acf1886(localclientnum);
        self thread function_b49dbe0f(localclientnum);
        if (self postfx::function_7348f3a5("pstfx_speedblur_wz")) {
            self postfx::exitpostfxbundle("pstfx_speedblur_wz");
        }
        self thread audio::dorattle(self.origin, 200, 700);
        self playrumbleonentity(localclientnum, "damage_heavy");
        self thread function_78ca4855(localclientnum);
    }
}

// Namespace player_free_fall/player_free_fall
// Params 2, eflags: 0x0
// Checksum 0x5ac08583, Offset: 0x13b0
// Size: 0xde
function function_7669269a(localclientnum, parachute) {
    if (isdefined(parachute) && parachute) {
        self playsound(localclientnum, "evt_skydive_parachute_open");
        self.var_22424461 = self playloopsound("evt_skydive_wind_light", 1);
        return;
    }
    if (isdefined(self.var_22424461)) {
        self stoploopsound(self.var_22424461, 0);
        self.var_22424461 = undefined;
    }
    if (isdefined(self.var_deacf46c)) {
        self stoploopsound(self.var_deacf46c, 0);
        self.var_deacf46c = undefined;
    }
}

// Namespace player_free_fall/player_free_fall
// Params 2, eflags: 0x0
// Checksum 0xbdf96959, Offset: 0x1498
// Size: 0x6a
function ground_trace(startpos, owner) {
    trace_height = 50;
    trace_depth = 100;
    return bullettrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x4
// Checksum 0x47842289, Offset: 0x1510
// Size: 0x24
function private function_debe9406(localclientnum) {
    self thread function_e75425f0(localclientnum);
}

// Namespace player_free_fall/player_free_fall
// Params 1, eflags: 0x0
// Checksum 0x920ab4cb, Offset: 0x1540
// Size: 0xe8
function function_e75425f0(localclientnum) {
    self notify("58e031e083ad8a4d");
    self endon("58e031e083ad8a4d");
    self endon(#"death", #"disconnect");
    infreefall = 0;
    while (true) {
        falling = isinfreefall(localclientnum);
        if (falling && !infreefall) {
            self function_dcab0387(localclientnum);
        }
        if (!falling && infreefall) {
            self freefallend(localclientnum);
        }
        infreefall = falling;
        wait 0.2;
    }
}

