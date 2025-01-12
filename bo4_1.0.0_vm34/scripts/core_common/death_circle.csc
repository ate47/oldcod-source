#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace death_circle;

// Namespace death_circle/death_circle
// Params 0, eflags: 0x2
// Checksum 0xe2f3000e, Offset: 0x140
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"death_circle", &__init__, undefined, undefined);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x73b4a9a3, Offset: 0x188
// Size: 0x2c4
function __init__() {
    level.var_3b2d97c0 = isdefined(getgametypesetting(#"deathcircle")) && getgametypesetting(#"deathcircle");
    if (!level.var_3b2d97c0) {
        return;
    }
    level.var_dbbcdfb5 = [1:#"hash_1483048e184df991", 2:#"hash_5b96bc3a1c23c571", 3:"evt_death_circle_strong"];
    level.var_5572e631 = [1:#"hash_7c7ea03189fe65d8", 2:#"hash_5c64e89ab323857a", 3:#"hash_3fc5123369b4c59f"];
    level.var_e034c419 = [1:#"wz/fx8_player_outside_circle", 2:#"hash_474c4d87482063e0", 3:#"hash_474c4e8748206593"];
    level.var_80cdc3f6 = [1:#"wz/fx8_plyr_pstfx_barrier_lvl_01_wz", 2:#"hash_2ccb19ff6223b693", 3:#"hash_559017f41745034e"];
    level.var_c7df8997 = [1:#"hash_775e24c0ca5d7b58", 2:#"hash_775e24c0ca5d7b58", 3:#"hash_316ec537e4167d47"];
    level.var_1def33a1 = [1:0.5, 2:0];
    level.var_c71c2a7c = [1:#"hash_57b39f99758cac07", 2:#"hash_301fd347a3614b8b", 3:#"hash_631d14143bf8b26"];
    clientfield::register("scriptmover", "deathcircleflag", 1, 1, "int", &function_bff4114a, 0, 0);
    clientfield::register("toplayer", "deathcircleeffects", 1, 2, "int", &function_4faa9458, 0, 0);
    clientfield::register("allplayers", "outsidedeathcircle", 1, 1, "int", undefined, 0, 0);
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x0
// Checksum 0xa2a7461d, Offset: 0x458
// Size: 0x264
function function_bff4114a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_49f273cd81c6c0f");
    if (newval) {
        var_f60dcf04 = self.team == #"neutral";
        var_c30382fc = self.team != #"neutral";
        self setcompassicon("minimap_sensor_dart_ring");
        self function_636e7d72(0);
        self function_c421d0f3(1);
        self function_ac5d3a50(0, 1);
        self function_a5b96b69(var_f60dcf04);
        self function_a30ee8fd(var_c30382fc);
        self thread function_b6974edc();
        if (var_c30382fc) {
            self.var_cc1f59bc = spawn(localclientnum, self.origin, "script_model");
            self.var_cc1f59bc setmodel("p8_big_cylinder");
            self.var_cc1f59bc playrenderoverridebundle(#"hash_75168376918f5ab7");
            self.var_cc1f59bc linkto(self);
        }
        return;
    }
    self function_636e7d72(1);
    self function_a5b96b69(0);
    if (isdefined(self.var_cc1f59bc)) {
        self.var_cc1f59bc stoprenderoverridebundle(#"hash_75168376918f5ab7");
        self.var_cc1f59bc delete();
    }
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x4
// Checksum 0x43fc99b, Offset: 0x6c8
// Size: 0x18a
function private function_4faa9458(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    self notify(#"hash_7d485f03f30cabda");
    self function_5db95a46();
    self function_7519941d(localclientnum);
    if (newval) {
        self util::waittill_dobj(localclientnum);
        if (!isdefined(self)) {
            return;
        }
        self play_audio(newval);
        self thread function_d39f5f53(localclientnum, newval);
        self codeplaypostfxbundle(level.var_5572e631[newval]);
        self.var_a9db7e98 = newval;
        self.var_80cdc3f6 = playfxoncamera(localclientnum, level.var_80cdc3f6[newval], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        self.var_e034c419 = function_fb03c761(localclientnum, level.var_e034c419[newval], self, "tag_origin");
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0xd655ce3a, Offset: 0x860
// Size: 0x150
function private function_7519941d(localclientnum) {
    if ((isdefined(self.var_a9db7e98) ? self.var_a9db7e98 : 0) > 0) {
        self codestoppostfxbundle(level.var_5572e631[self.var_a9db7e98]);
    }
    self.var_a9db7e98 = 0;
    if (isdefined(self.var_80cdc3f6)) {
        deletefx(localclientnum, self.var_80cdc3f6, 1);
        self.var_80cdc3f6 = undefined;
    }
    if (isdefined(self.var_e034c419)) {
        killfx(localclientnum, self.var_e034c419);
        self.var_e034c419 = undefined;
    }
    foreach (player in getplayers(localclientnum)) {
        player function_599afea7(localclientnum);
    }
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0x7cf10ee6, Offset: 0x9b8
// Size: 0x15a
function private function_c405048a(localclientnum, intensity) {
    self endon(#"death");
    if (self.var_305106be === intensity) {
        return;
    }
    self.var_305106be = intensity;
    self util::waittill_dobj(localclientnum);
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.var_2a136336)) {
        self stoprenderoverridebundle(self.var_2a136336);
    }
    self.var_2a136336 = level.var_c7df8997[intensity];
    self playrenderoverridebundle(self.var_2a136336);
    robfade = level.var_1def33a1[intensity];
    if (isdefined(robfade)) {
        self function_98a01e4c(self.var_2a136336, "Fade", robfade);
    }
    self function_3d70cae4(localclientnum);
    self.var_7d4e3c4d = playtagfxset(localclientnum, level.var_c71c2a7c[intensity], self);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x75fa74e6, Offset: 0xb20
// Size: 0x64
function private function_599afea7(localclientnum) {
    self.var_305106be = undefined;
    if (isdefined(self.var_2a136336)) {
        self stoprenderoverridebundle(self.var_2a136336);
        self.var_2a136336 = undefined;
    }
    self function_3d70cae4(localclientnum);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0xc5d48f34, Offset: 0xb90
// Size: 0x9a
function private function_3d70cae4(localclientnum) {
    if (isdefined(self.var_7d4e3c4d)) {
        foreach (fxhandle in self.var_7d4e3c4d) {
            killfx(localclientnum, fxhandle);
        }
        self.var_7d4e3c4d = undefined;
    }
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0x81bc0e40, Offset: 0xc38
// Size: 0x278
function private function_d39f5f53(localclientnum, intensity) {
    self endon(#"death", #"hash_7d485f03f30cabda");
    maxdistsq = 100000000;
    while (true) {
        players = getplayers(localclientnum);
        currentplayer = function_f97e7787(localclientnum);
        players = arraysortclosest(players, currentplayer.origin);
        var_45a52237 = 0;
        angles = currentplayer getplayerangles();
        fwd = anglestoforward(angles);
        foreach (player in players) {
            if (var_45a52237 >= 10 || player == currentplayer || player clientfield::get("outsidedeathcircle") || !isalive(player) || distance2dsquared(currentplayer.origin, player.origin) > maxdistsq || vectordot(fwd, player.origin - currentplayer.origin) <= 0) {
                player function_599afea7(localclientnum);
                continue;
            }
            var_45a52237++;
            player thread function_c405048a(localclientnum, intensity);
        }
        players = undefined;
        waitframe(1);
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0x30c34697, Offset: 0xeb8
// Size: 0x24
function private function_e44ad3c6() {
    self setcompassicon("");
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0x8db0bb5c, Offset: 0xee8
// Size: 0xf6
function private function_b6974edc() {
    self endon(#"death", #"hash_49f273cd81c6c0f");
    self thread function_d0ecdf0();
    while (isdefined(self.scale)) {
        radius = 15000 * self.scale;
        if (isdefined(self.var_cc1f59bc)) {
            modelscale = radius / 150000;
            self.var_cc1f59bc function_98a01e4c(#"hash_75168376918f5ab7", "Scale", modelscale);
        }
        compassscale = radius * 2;
        self function_ac5d3a50(compassscale, 1);
        waitframe(1);
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x761927e1, Offset: 0xfe8
// Size: 0x7c
function function_d0ecdf0() {
    self endon(#"hash_49f273cd81c6c0f");
    self waittill(#"death");
    if (isdefined(self.var_cc1f59bc)) {
        self.var_cc1f59bc stoprenderoverridebundle(#"hash_75168376918f5ab7");
        self.var_cc1f59bc delete();
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x9ccfd875, Offset: 0x1070
// Size: 0x56
function play_audio(intensity) {
    self.var_dbbcdfb5 = self playloopsound(level.var_dbbcdfb5[intensity]);
    if (ispc()) {
        level.var_5c55836a = 1;
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x6ac4f923, Offset: 0x10d0
// Size: 0x5a
function function_5db95a46() {
    if (isdefined(self.var_dbbcdfb5)) {
        self stoploopsound(self.var_dbbcdfb5);
        self.var_dbbcdfb5 = undefined;
        if (ispc()) {
            level.var_5c55836a = 0;
        }
    }
}

