#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace flashlight;

// Namespace flashlight/flashlight
// Params 0, eflags: 0x6
// Checksum 0xcbe196b7, Offset: 0x110
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"flashlight", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace flashlight/flashlight
// Params 3, eflags: 0x1 linked
// Checksum 0xdef175b4, Offset: 0x158
// Size: 0x1dc
function function_69258685(localclientnum, flashlightfx = "light/fx9_light_cp_flashlight", flashlightfxtag = "tag_light") {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    var_5a528883 = self.flashlight.fx !== flashlightfx;
    var_f49dadc4 = self.flashlight.fxtag !== flashlightfxtag;
    var_5a9e0eeb = var_5a528883 && flashlightfx !== "light/fx9_light_cp_flashlight" ? flashlightfx : undefined;
    var_9acb6f5e = var_f49dadc4 && flashlightfxtag !== "tag_light" ? flashlightfxtag : undefined;
    if (!isdefined(self.flashlight) && (isdefined(var_5a9e0eeb) || isdefined(var_9acb6f5e))) {
        self.flashlight = {};
    }
    self.flashlight.fx = var_5a9e0eeb;
    self.flashlight.fxtag = var_9acb6f5e;
    if (self == level) {
        level notify(#"hash_3832e59879eaf7fd");
        return;
    }
    flashlight_on = isdefined(self.flashlight.fxid);
    if (flashlight_on && (var_5a528883 || var_f49dadc4)) {
        self function_24a560cf(localclientnum);
        self function_69fc092e(localclientnum);
    }
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0x7d349013, Offset: 0x340
// Size: 0x14
function private function_70a657d8() {
    register_clientfields();
}

// Namespace flashlight/flashlight
// Params 0, eflags: 0x5 linked
// Checksum 0x6b9618de, Offset: 0x360
// Size: 0xdc
function private register_clientfields() {
    clientfield::register("actor", "flashlightfx", 1, 1, "int", &function_7e507d3c, 0, 0);
    clientfield::register("scriptmover", "flashlightfx", 1, 2, "int", &function_8cd382e7, 0, 0);
    clientfield::register("actor", "gunflashlightfx", 1, 1, "int", &function_db7bbe6c, 0, 0);
}

// Namespace flashlight/flashlight
// Params 7, eflags: 0x5 linked
// Checksum 0xe7482a91, Offset: 0x448
// Size: 0xdc
function private function_db7bbe6c(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    flashlight_on = self clientfield::get("gunflashlightfx");
    if (flashlight_on) {
        function_69258685(wasdemojump, "light/fx9_light_cp_flashlight", "tag_muzzle");
    }
    function_2573297e(wasdemojump, flashlight_on);
    if (!flashlight_on) {
        function_69258685(wasdemojump, "light/fx9_light_cp_flashlight", "tag_light");
    }
}

// Namespace flashlight/flashlight
// Params 7, eflags: 0x5 linked
// Checksum 0x40c3d9fc, Offset: 0x530
// Size: 0x7c
function private function_7e507d3c(localclientnum, *oldvalue, *newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    flashlight_on = self clientfield::get("flashlightfx");
    function_2573297e(wasdemojump, flashlight_on);
}

// Namespace flashlight/flashlight
// Params 2, eflags: 0x5 linked
// Checksum 0xfda35df6, Offset: 0x5b8
// Size: 0x94
function private function_2573297e(localclientnum, flashlight_on) {
    if (flashlight_on == 1 && !isdefined(self.flashlight.fxid)) {
        self function_69fc092e(localclientnum);
        return;
    }
    if (flashlight_on == 0 && isdefined(self.flashlight.fxid)) {
        self function_24a560cf(localclientnum);
    }
}

// Namespace flashlight/flashlight
// Params 7, eflags: 0x5 linked
// Checksum 0xbc1a5558, Offset: 0x658
// Size: 0xe4
function private function_8cd382e7(localclientnum, *oldvalue, newvalue, *bnewent, *binitialsnap, *fieldname, *wasdemojump) {
    if (wasdemojump == 1) {
        self notify(#"hash_6f398d21a29fce31");
        self function_a530c545(fieldname, 1);
        return;
    }
    if (wasdemojump == 0) {
        self notify(#"hash_6f398d21a29fce31");
        self function_a530c545(fieldname, 0);
        return;
    }
    if (wasdemojump == 2) {
        self thread function_2b580006(fieldname);
    }
}

// Namespace flashlight/flashlight
// Params 2, eflags: 0x5 linked
// Checksum 0xff3b5e9b, Offset: 0x748
// Size: 0xde
function private function_a530c545(localclientnum, on) {
    if (is_true(on)) {
        if (!isdefined(self.var_103f6c4c)) {
            fx = isdefined(level.flashlight.fx) ? level.flashlight.fx : "light/fx9_light_cp_flashlight";
            self.var_103f6c4c = util::playfxontag(localclientnum, fx, self, "tag_light");
        }
        return;
    }
    if (isdefined(self.var_103f6c4c)) {
        killfx(localclientnum, self.var_103f6c4c);
        self.var_103f6c4c = undefined;
    }
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x5 linked
// Checksum 0x79491f07, Offset: 0x830
// Size: 0x14c
function private function_2b580006(localclientnum) {
    self notify(#"hash_6f398d21a29fce31");
    self endon(#"hash_6f398d21a29fce31", #"death");
    self function_a530c545(localclientnum, 0);
    wait randomfloatrange(0.2, 0.3);
    self function_a530c545(localclientnum, 1);
    wait randomfloatrange(0.2, 0.4);
    self function_a530c545(localclientnum, 0);
    wait randomfloatrange(0.2, 0.3);
    self function_a530c545(localclientnum, 1);
    wait randomfloatrange(0.2, 0.3);
    self function_a530c545(localclientnum, 0);
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x5 linked
// Checksum 0x25b6ff47, Offset: 0x988
// Size: 0x144
function private function_69fc092e(localclientnum) {
    if (!isdefined(self.flashlight)) {
        self.flashlight = {};
    }
    if (isdefined(self.flashlight.fx)) {
        flashlightfx = self.flashlight.fx;
    } else if (isdefined(level.flashlight.fx)) {
        flashlightfx = level.flashlight.fx;
    } else {
        flashlightfx = "light/fx9_light_cp_flashlight";
    }
    if (isdefined(self.flashlight.fxtag)) {
        flashlightfxtag = self.flashlight.fxtag;
    } else if (isdefined(level.flashlight.fxtag)) {
        flashlightfxtag = level.flashlight.fxtag;
    } else {
        flashlightfxtag = "tag_light";
    }
    self.flashlight.fxid = util::playfxontag(localclientnum, flashlightfx, self, flashlightfxtag);
    self thread function_54557944(localclientnum);
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x5 linked
// Checksum 0xde3171e, Offset: 0xad8
// Size: 0x8e
function private function_24a560cf(localclientnum) {
    if (isdefined(self.flashlight.fxid)) {
        killfx(localclientnum, self.flashlight.fxid);
        self.flashlight.fxid = undefined;
        if (!isdefined(self.flashlight.fx) && !isdefined(self.flashlight.fxtag)) {
            self.flashlight = undefined;
        }
    }
}

// Namespace flashlight/flashlight
// Params 1, eflags: 0x5 linked
// Checksum 0xfbabcb1b, Offset: 0xb70
// Size: 0x7c
function private function_54557944(localclientnum) {
    self notify("2e2e684b17c33f9f");
    self endon("2e2e684b17c33f9f");
    self endon(#"death");
    level waittill(#"hash_3832e59879eaf7fd");
    self function_24a560cf(localclientnum);
    self function_69fc092e(localclientnum);
}

