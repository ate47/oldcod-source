#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace death_circle;

// Namespace death_circle/death_circle
// Params 0, eflags: 0x6
// Checksum 0x63f3a249, Offset: 0x248
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"death_circle", &preinit, undefined, &function_4df027f2, undefined);
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0x87abf8c8, Offset: 0x298
// Size: 0x368
function private preinit() {
    level.deathcircle = {#enabled:is_true(getgametypesetting(#"deathcircle"))};
    if (!level.deathcircle.enabled) {
        return;
    }
    level.var_ef215639 = [1:#"hash_1483048e184df991", 2:#"hash_5b96bc3a1c23c571", 3:"evt_death_circle_strong"];
    level.var_cb450873 = #"hash_313f1d0b4ff27caa";
    if (isdefined(level.var_7bd7bdc8)) {
        level.var_f6795a59 = level.var_7bd7bdc8;
    } else {
        level.var_f6795a59 = [1:#"hash_7c7ea03189fe65d8", 2:#"hash_5c64e89ab323857a", 3:#"hash_3fc5123369b4c59f"];
    }
    clientfield::register("scriptmover", "deathcircleflag", 1, 1, "int", &function_a380fe5, 0, 0);
    clientfield::register("allplayers", "deathcircleopacityflag", 1, 1, "counter", &function_1a4228a5, 0, 0);
    clientfield::register("toplayer", "deathcircleeffects", 1, 2, "int", undefined, 0, 1);
    clientfield::register("allplayers", "outsidedeathcircle", 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseTimerState", #"warzone_global", #"collapsetimerstate", 1, 2, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("hudItems.warzone.collapseProgress", #"warzone_global", #"collapseprogress", 1, 7, "float", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.distanceFromDeathCircle", #"hud_items", #"distancefromdeathcircle", 1, 7, "float", undefined, 0, 0);
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    level.var_32e10fc2 = [];
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xd0456f95, Offset: 0x608
// Size: 0x94
function private function_4df027f2() {
    if (!level.deathcircle.enabled) {
        return;
    }
    if (level.is_survival === 1) {
        level.var_74017fd2 = #"hash_2ebe199a82d38283";
    }
    if (level.var_374c2805 === 1) {
        level.var_34ac1fa = #"hash_454cceb988244ba3";
    }
    if (!isdefined(level.var_74017fd2)) {
        level.var_74017fd2 = #"hash_75168376918f5ab7";
    }
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x0
// Checksum 0xdf7f94ee, Offset: 0x6a8
// Size: 0x424
function function_a380fe5(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify(#"hash_49f273cd81c6c0f");
    if (bwastimejump) {
        var_899562cf = self.team == #"neutral";
        var_929604bb = self.team != #"neutral";
        self setcompassicon("ui_icon_minimap_collapse_ring");
        self function_811196d1(0);
        self function_95bc465d(1);
        self function_5e00861(0, 1);
        self function_bc95cd57(var_899562cf);
        self function_60212003(var_929604bb);
        self thread function_a453467f(fieldname);
        if (var_929604bb) {
            player = function_27673a7(fieldname);
            if (isdefined(player) && isdefined(player.var_2cbc8a68)) {
                player.var_2cbc8a68 stoprenderoverridebundle(level.var_74017fd2);
                player.var_2cbc8a68 delete();
            }
            if (isdefined(self.var_2c8e49d2)) {
                self.var_2c8e49d2 stoprenderoverridebundle(level.var_74017fd2);
                self.var_2c8e49d2 delete();
            }
            self function_a5edb367(#"death_ring");
            self.var_2c8e49d2 = spawn(fieldname, self.origin, "script_model");
            self.var_2c8e49d2 setmodel("p8_big_cylinder");
            self.var_2c8e49d2 playrenderoverridebundle(level.var_74017fd2);
            self.var_2c8e49d2 linkto(self);
            self.var_29b256b0 = spawn(0, self.origin, "script_origin");
            self.var_29b256b0.handle = self.var_29b256b0 playloopsound(level.var_cb450873);
            if (!isdefined(level.var_2bc2d986)) {
                level.var_18a959b = self.var_2c8e49d2;
            }
        } else {
            self function_a5edb367(#"none");
        }
        return;
    }
    self function_811196d1(1);
    self function_bc95cd57(0);
    if (isdefined(self.var_2c8e49d2)) {
        self.var_2c8e49d2 stoprenderoverridebundle(level.var_74017fd2);
        self.var_2c8e49d2 delete();
    }
    if (isdefined(self.var_29b256b0)) {
        self.var_29b256b0 stoploopsound(self.var_29b256b0.handle);
        self.var_29b256b0 delete();
    }
}

// Namespace death_circle/death_circle
// Params 7, eflags: 0x0
// Checksum 0xba61e9af, Offset: 0xad8
// Size: 0x14c
function function_1a4228a5(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        player = function_27673a7(fieldname);
        if (isdefined(level.var_18a959b)) {
            level.var_18a959b stoprenderoverridebundle(level.var_74017fd2);
        }
        level.var_18a959b playrenderoverridebundle(level.var_34ac1fa);
        while (player.var_1bee6f4b === 1 || player.weapon.name === #"chopper_gunner") {
            waitframe(1);
        }
        if (isdefined(level.var_18a959b)) {
            level.var_18a959b stoprenderoverridebundle(level.var_34ac1fa);
        }
        level.var_18a959b playrenderoverridebundle(level.var_74017fd2);
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x5e998a49, Offset: 0xc30
// Size: 0xa4
function on_localclient_connect(localclientnum) {
    player = function_27673a7(localclientnum);
    if (isdefined(player)) {
        player.var_2cbc8a68 = spawn(localclientnum, (0, 0, -10000), "script_model");
        player.var_2cbc8a68 playrenderoverridebundle(level.var_74017fd2);
    }
    level thread function_382da026(localclientnum);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x0
// Checksum 0x734ad2d8, Offset: 0xce0
// Size: 0x3c
function on_localplayer_spawned(localclientnum) {
    if (self function_da43934d()) {
        self thread function_7eb327bd(localclientnum);
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0xbfe5e2d8, Offset: 0xd28
// Size: 0x13e
function private function_382da026(localclientnum) {
    self notify("7c5d474ab38b8a8");
    self endon("7c5d474ab38b8a8");
    var_ef2f4cec = spawnstruct();
    level.var_32e10fc2[localclientnum] = var_ef2f4cec;
    while (true) {
        currentplayer = function_5c10bd79(localclientnum);
        if (!isdefined(currentplayer)) {
            waitframe(1);
            continue;
        }
        intensity = currentplayer clientfield::get_to_player("deathcircleeffects");
        if (var_ef2f4cec.var_e51324b5 !== intensity) {
            var_ef2f4cec notify(#"hash_b6468b7475f6790");
            var_ef2f4cec function_43d7470c(localclientnum, intensity);
            var_ef2f4cec function_d69170b(localclientnum, intensity);
            var_ef2f4cec.var_e51324b5 = intensity;
        }
        level.var_d081e853 = intensity > 0;
        waitframe(1);
    }
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x53c1f15f, Offset: 0xe70
// Size: 0x8c
function private function_7eb327bd(localclientnum) {
    self waittill(#"death");
    var_ef2f4cec = level.var_32e10fc2[localclientnum];
    if (isdefined(var_ef2f4cec)) {
        var_ef2f4cec notify(#"hash_b6468b7475f6790");
        var_ef2f4cec function_43d7470c(localclientnum);
        var_ef2f4cec function_d69170b(localclientnum);
    }
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0x4887dd80, Offset: 0xf08
// Size: 0x9a
function private function_43d7470c(localclientnum, intensity = 0) {
    if (isdefined(self.var_ef215639)) {
        function_d48752e(localclientnum, self.var_ef215639);
        self.var_ef215639 = undefined;
    }
    alias = level.var_ef215639[intensity];
    if (isdefined(alias)) {
        self.var_ef215639 = function_604c9983(localclientnum, alias);
    }
}

// Namespace death_circle/death_circle
// Params 2, eflags: 0x4
// Checksum 0x4e2da85b, Offset: 0xfb0
// Size: 0x20e
function private function_d69170b(localclientnum, intensity = 0) {
    currentplayer = function_5c10bd79(localclientnum);
    if (isdefined(self.var_f6795a59)) {
        function_24cd4cfb(localclientnum, self.var_f6795a59);
        if (isdefined(self.var_6e62d281)) {
            stopfx(localclientnum, self.var_6e62d281);
        }
        self.var_f6795a59 = undefined;
    }
    if (isdefined(currentplayer.var_103fdf58)) {
        playsound(localclientnum, #"hash_1757939248ce3124", (0, 0, 0));
        currentplayer stoploopsound(currentplayer.var_103fdf58);
        currentplayer.var_103fdf58 = undefined;
    }
    postfx = level.var_f6795a59[intensity];
    if (isdefined(postfx)) {
        if (function_148ccc79(localclientnum, postfx)) {
            codestoppostfxbundlelocal(localclientnum, postfx);
        }
        function_a837926b(localclientnum, postfx);
        if (isdefined(level.var_6e62d281)) {
            self.var_6e62d281 = playviewmodelfx(localclientnum, level.var_6e62d281, "tag_torso");
            if (!isdefined(currentplayer.var_103fdf58)) {
                playsound(localclientnum, #"hash_639f49c1fc950a5d", (0, 0, 0));
                currentplayer.var_103fdf58 = currentplayer playloopsound("evt_sr_fogofwar_1p_lp");
            }
        }
        self.var_f6795a59 = postfx;
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x4
// Checksum 0xff6bb9fd, Offset: 0x11c8
// Size: 0x24
function private function_63d6411e() {
    self setcompassicon("");
}

// Namespace death_circle/death_circle
// Params 3, eflags: 0x4
// Checksum 0xb8a6f427, Offset: 0x11f8
// Size: 0x140
function private function_32f7227c(deathcircle, currentradius, localclientnum) {
    localplayer = function_5c10bd79(localclientnum);
    startpos = (deathcircle.origin[0], deathcircle.origin[1], 0);
    toplayervec = (0, 0, 0);
    eyepos = startpos + (0, 0, 60);
    if (isdefined(localplayer)) {
        endpos = (localplayer.origin[0], localplayer.origin[1], 0);
        toplayervec = vectornormalize(endpos - startpos) * currentradius;
        eyepos = localplayer geteyeapprox();
    }
    returnvec = deathcircle.origin + toplayervec;
    return (returnvec[0], returnvec[1], eyepos[2]);
}

// Namespace death_circle/death_circle
// Params 1, eflags: 0x4
// Checksum 0x9f2e22a8, Offset: 0x1340
// Size: 0x22e
function private function_a453467f(localclientnum) {
    self endon(#"death", #"hash_49f273cd81c6c0f");
    self thread function_71f8d788();
    while (isdefined(self.scale)) {
        radius = 15000 * self.scale;
        if (isdefined(self.var_2c8e49d2)) {
            if (!self.var_2c8e49d2 function_d2503806(level.var_74017fd2) && !self.var_2c8e49d2 function_d2503806(level.var_34ac1fa)) {
                self.var_2c8e49d2 playrenderoverridebundle(level.var_74017fd2);
            }
            modelscale = radius / 150000;
            if (self.var_2c8e49d2 function_d2503806(level.var_74017fd2)) {
                self.var_2c8e49d2 function_78233d29(level.var_74017fd2, "", "Scale", modelscale);
            } else if (self.var_2c8e49d2 function_d2503806(level.var_34ac1fa)) {
                self.var_2c8e49d2 function_78233d29(level.var_34ac1fa, "", "Scale", modelscale);
            }
            if (isdefined(self.var_29b256b0)) {
                self.var_29b256b0.origin = function_32f7227c(self, radius, localclientnum);
            }
        }
        compassscale = radius * 2;
        self function_5e00861(compassscale, 1);
        waitframe(1);
    }
}

// Namespace death_circle/death_circle
// Params 0, eflags: 0x0
// Checksum 0x7ad45ac9, Offset: 0x1578
// Size: 0x74
function function_71f8d788() {
    self endon(#"hash_49f273cd81c6c0f");
    self waittill(#"death");
    if (isdefined(self.var_2c8e49d2)) {
        self.var_2c8e49d2 stoprenderoverridebundle(level.var_74017fd2);
        self.var_2c8e49d2 delete();
    }
}

