#using script_d5fbb947291463c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_f0b43eb5;

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x6
// Checksum 0x2c91e176, Offset: 0x100
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_1c32fc6c324d3e66", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 0, eflags: 0x1 linked
// Checksum 0x13eaca8f, Offset: 0x148
// Size: 0x21e
function function_70a657d8() {
    if (!zm_utility::function_7ab3b826() || zm_utility::is_survival()) {
        return;
    }
    level.var_996e8a57 = zm_dac_challenges_hud::register();
    clientfield::register("scriptmover", "" + #"hash_653b5827e6fbe5f9", 1, 1, "int", &function_2d368ee, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_21f5fab6a3d22093", 1, 3, "int", &function_9ed71eeb, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_19bbbc55e95ee629", 1, 1, "int", &function_71ca1968, 0, 0);
    clientfield::register("toplayer", "" + #"hash_31bea9cf1e6f76a0", 1, getminbitcountfornum(90), "int", &function_bb753058, 0, 1);
    clientfield::register("toplayer", "" + #"hash_216c75103f478671", 1, 4, "int", &function_b5557b14, 0, 0);
    level.var_32e6afcd = undefined;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 7, eflags: 0x0
// Checksum 0x5dc4f4a6, Offset: 0x370
// Size: 0x80
function function_dbc7fe67(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (!isdefined(level.var_806707ab)) {
        level.var_806707ab = [];
    }
    self.var_e41b2a3f = bwasdemojump;
    level.var_806707ab[level.var_806707ab.size] = self;
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 7, eflags: 0x1 linked
// Checksum 0x5cbe648d, Offset: 0x3f8
// Size: 0x232
function function_9ed71eeb(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (isdefined(self.var_9c32107c)) {
        stopfx(fieldname, self.var_9c32107c);
        self.var_9c32107c = undefined;
    }
    if (!isdefined(self.v_pos)) {
        self.v_pos = self.origin + (0, 0, -20);
        self.v_up = (0, 0, 1);
        self.v_forward = anglestoforward(self.angles);
    }
    switch (bwastimejump) {
    case 0:
        break;
    case 1:
        self.var_9c32107c = playfx(fieldname, #"hash_276c55785b205f4e", self.v_pos, self.v_up, self.v_forward);
        break;
    case 2:
        self.var_9c32107c = playfx(fieldname, #"hash_487863cb3f012833", self.v_pos, self.v_up, self.v_forward);
        break;
    case 3:
        self.var_9c32107c = playfx(fieldname, #"hash_2a46ebc323110b3d", self.v_pos, self.v_up, self.v_forward);
        break;
    case 4:
        self.var_9c32107c = playfx(fieldname, #"hash_4eff7803b81cd67d", self.v_pos, self.v_up, self.v_forward);
        break;
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 7, eflags: 0x1 linked
// Checksum 0xc5111602, Offset: 0x638
// Size: 0xae
function function_2d368ee(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        self.var_2d368ee = playfx(fieldname, #"zombie/fx_powerup_on_caution_zmb", self.origin);
    }
    if (bwasdemojump == 0) {
        stopfx(fieldname, self.var_2d368ee);
        self.var_2d368ee = undefined;
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 7, eflags: 0x1 linked
// Checksum 0x7cb50b2b, Offset: 0x6f0
// Size: 0x7a
function function_71ca1968(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwasdemojump) {
    if (bwasdemojump == 1) {
        self.var_71ca1968 = util::playfxontag(fieldname, #"zombie/fx_powerup_on_caution_zmb", self, "tag_origin");
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 7, eflags: 0x5 linked
// Checksum 0x5621e766, Offset: 0x778
// Size: 0x12c
function private function_bb753058(localclientnum, *oldval, newval, *bnewent, binitialsnap, *fieldname, *bwastimejump) {
    if (!function_65b9eb0f(binitialsnap)) {
        timer_model = function_c8b7588d(binitialsnap);
        end_time = undefined;
        if (!bwastimejump && fieldname == 0 && isdefined(level.var_fba33a1b)) {
            end_time = level.var_fba33a1b;
        } else {
            duration_msec = fieldname * 1000;
            level.var_fba33a1b = getservertime(binitialsnap, 1) + duration_msec;
            end_time = level.var_fba33a1b;
        }
        if (isdefined(end_time)) {
            setuimodelvalue(timer_model, end_time);
        }
    }
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 1, eflags: 0x5 linked
// Checksum 0x8586f350, Offset: 0x8b0
// Size: 0x42
function private function_c8b7588d(localclientnum) {
    return createuimodel(function_1df4c3b0(localclientnum, #"zm_hud"), "zmRedChallengeTimer");
}

// Namespace namespace_f0b43eb5/namespace_f0b43eb5
// Params 7, eflags: 0x1 linked
// Checksum 0xeb4ca7c5, Offset: 0x900
// Size: 0x2a4
function function_b5557b14(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (function_65b9eb0f(fieldname)) {
        return;
    }
    var_e915a27 = getent(fieldname, "trial_terminal_screen", "targetname");
    switch (bwastimejump) {
    case 0:
        str_model = #"hash_c9bba46978e6d6e";
        break;
    case 1:
        str_model = #"hash_3408d07d4023960a";
        break;
    case 2:
        str_model = #"hash_22c3f2b14a8af39";
        break;
    case 3:
        str_model = #"hash_78d1631457df7faa";
        break;
    case 4:
        str_model = #"hash_51840445e2753066";
        break;
    case 5:
        str_model = #"hash_51840445e2753066";
        /#
            iprintlnbold("<dev string:x38>");
        #/
        break;
    case 6:
        str_model = #"hash_75170f904e96e8ef";
        break;
    case 7:
        str_model = #"hash_4042063c893f7f3a";
        /#
            iprintlnbold("<dev string:x4f>");
        #/
        break;
    case 8:
        str_model = #"hash_26ea0b5ffb8178c6";
        break;
    case 9:
        str_model = #"hash_30acea553928ba42";
        /#
            iprintlnbold("<dev string:x64>");
        #/
        break;
    }
    if (isdefined(str_model)) {
        var_e915a27 setmodel(str_model);
    }
}

