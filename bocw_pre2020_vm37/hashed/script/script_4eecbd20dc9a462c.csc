#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\util_shared;

#namespace namespace_e8c18978;

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 1, eflags: 0x1 linked
// Checksum 0x306dce7d, Offset: 0x108
// Size: 0x18c
function function_70a657d8(*bundlename) {
    clientfield::register("toplayer", "" + #"hash_7c907650b14abbbe", 1, 1, "int", &function_d3a9eef4, 0, 0);
    clientfield::register("vehicle", "" + #"hash_4ddf67f7aa0f6884", 1, 1, "int", &function_241229f1, 0, 0);
    clientfield::register("vehicle", "" + #"hash_46646871455cab15", 1, 2, "int", &function_1da732e, 0, 0);
    clientfield::register("vehicle", "" + #"hash_6cf1a3b26118d892", 1, 1, "int", &function_d6f6757c, 0, 0);
    level.var_f7dac9d2 = getscriptbundle("killstreak_chopper_gunner");
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 7, eflags: 0x1 linked
// Checksum 0x537f1e45, Offset: 0x2a0
// Size: 0x106
function function_d3a9eef4(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        level.var_bb4264e3 = self;
        return;
    }
    if (isdefined(level.var_f7dac9d2.var_fa6a1c8c)) {
        postfxbundle = level.var_f7dac9d2.var_fa6a1c8c;
        if (self function_d2cb869e(postfxbundle)) {
            self codestoppostfxbundle(postfxbundle);
        }
    }
    if (isdefined(level.var_f7dac9d2.var_917dc7d4)) {
        self stoprumble(fieldname, level.var_f7dac9d2.var_917dc7d4);
    }
    level.var_bb4264e3 = undefined;
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 7, eflags: 0x1 linked
// Checksum 0xe41e302b, Offset: 0x3b0
// Size: 0x1d4
function function_241229f1(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump) {
        if (isdefined(level.var_bb4264e3)) {
            self setsoundentcontext("plr_vehicle", "driver");
            level.var_bb4264e3 playrumblelooponentity(fieldname, #"hash_3c2b94894227f3cf");
            self thread scene::play(#"chopper_gunner_door_open_client");
            if (isdefined(level.var_f7dac9d2.var_fa6a1c8c)) {
                postfxbundle = level.var_f7dac9d2.var_fa6a1c8c;
                level.var_bb4264e3 codeplaypostfxbundle(postfxbundle);
            }
        }
        self function_1f0c7136(2);
        self setanim(#"hash_7483c325182bab52");
        wait getanimlength(#"hash_7483c325182bab52");
        if (isdefined(level.var_bb4264e3)) {
            level.var_bb4264e3 stoprumble(fieldname, #"hash_3c2b94894227f3cf");
        }
        if (isdefined(self)) {
            self clearanim(#"hash_7483c325182bab52", 0.2);
        }
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 7, eflags: 0x1 linked
// Checksum 0xd9c232a7, Offset: 0x590
// Size: 0x2dc
function function_1da732e(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        alarm_sound = self gettagorigin("TAG_PROBE_COCKPIT");
        util::playfxontag(fieldname, level.var_f7dac9d2.var_24b7aa85, self, "tag_body");
        if (isdefined(level.var_bb4264e3)) {
            if (isdefined(level.var_f7dac9d2.var_c6eb2a1d)) {
                level.var_bb4264e3 playrumbleonentity(fieldname, level.var_f7dac9d2.var_c6eb2a1d);
            }
            level.var_bb4264e3 playsound(fieldname, #"hash_7b6b109a826f44cf");
            waitframe(1);
            if (isdefined(level.var_bb4264e3)) {
                level.var_bb4264e3 playsound(fieldname, #"hash_733033c981df7144", alarm_sound);
            }
        } else {
            self playsound(fieldname, #"hash_2879bee00b0dbf87");
        }
        return;
    }
    if (bwastimejump == 2) {
        alarm_sound = self gettagorigin("TAG_PROBE_COCKPIT");
        util::playfxontag(fieldname, level.var_f7dac9d2.var_8334e8e, self, "tag_body");
        if (isdefined(level.var_bb4264e3)) {
            if (isdefined(level.var_f7dac9d2.var_c6eb2a1d)) {
                level.var_bb4264e3 playrumbleonentity(fieldname, level.var_f7dac9d2.var_bf7c296c);
            }
            level.var_bb4264e3 playsound(fieldname, #"hash_7b6b119a826f4682");
            waitframe(1);
            if (isdefined(level.var_bb4264e3)) {
                level.var_bb4264e3 playsound(fieldname, #"hash_733036c981df765d", alarm_sound);
            }
            return;
        }
        self playsound(fieldname, #"hash_331a5d0f62ba4e66");
    }
}

// Namespace namespace_e8c18978/namespace_e8c18978
// Params 7, eflags: 0x1 linked
// Checksum 0xa090214c, Offset: 0x878
// Size: 0x1b4
function function_d6f6757c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        if (isdefined(level.var_bb4264e3)) {
            util::playfxontag(fieldname, level.var_f7dac9d2.var_1d9da603, self, "tag_deathfx");
            level.var_bb4264e3 playsound(fieldname, #"hash_7b6b129a826f4835");
            if (isdefined(level.var_f7dac9d2.var_a97fd8e0)) {
                level.var_bb4264e3 playrumbleonentity(fieldname, level.var_f7dac9d2.var_a97fd8e0);
            }
            if (isdefined(level.var_f7dac9d2.var_917dc7d4)) {
                level.var_bb4264e3 playrumblelooponentity(fieldname, level.var_f7dac9d2.var_917dc7d4);
            }
            return;
        }
        if (isdefined(level.var_f7dac9d2.var_2a77dc37)) {
            util::playfxontag(fieldname, level.var_f7dac9d2.var_2a77dc37, self, "tag_deathfx");
            playsound(fieldname, #"hash_331a5d0f62ba4e66");
        }
    }
}

