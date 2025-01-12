#using scripts\core_common\audio_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace namespace_8adb45e8;

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x2
// Checksum 0x1063ed00, Offset: 0x408
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_3478ed13fc9440e6", &__init__, undefined, undefined);
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 0, eflags: 0x0
// Checksum 0xbf7fe415, Offset: 0x450
// Size: 0xa32
function __init__() {
    n_bits = getminbitcountfornum(3);
    clientfield::register("scriptmover", "" + #"hash_632f7bc0b1a15f71", 1, n_bits, "int", &function_cbd6bd05, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_4614e4fa180c79af", 1, 1, "int", &function_cd5b975b, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_53586aa63ca15286", 1, 1, "int", &function_11c6b3f4, 0, 0);
    clientfield::register("actor", "" + #"hash_65da20412fcaf97e", 1, 1, "int", &function_fd735bd8, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_65da20412fcaf97e", 1, 1, "int", &function_fd735bd8, 0, 0);
    clientfield::register("toplayer", "" + #"hash_7d4d423d8dabbee3", 1, getminbitcountfornum(10), "int", &function_54bfed3b, 0, 0);
    clientfield::register("toplayer", "" + #"hash_49fecafe0b5d6da4", 1, 2, "counter", &function_5a99d9fa, 0, 0);
    clientfield::register("vehicle", "" + #"hash_584f13d0c8662647", 1, 1, "int", &function_d20f908b, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_584f13d0c8662647", 1, 1, "int", &function_d20f908b, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_a51ae59006ab41b", 1, getminbitcountfornum(4), "int", &function_58f750b7, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_64f2dd36b17bf17", 1, 1, "int", &function_2fd9c4c7, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_119729072e708651", 1, 1, "int", &function_6b7f5889, 0, 0);
    clientfield::register("actor", "" + #"hash_3e506d7aedac6ae0", 1, getminbitcountfornum(10), "int", &function_fea70046, 0, 0);
    clientfield::register("actor", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int", &function_ba13e806, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int", &function_aef69f3e, 0, 0);
    clientfield::register("vehicle", "" + #"hash_34562274d7e875a4", 1, getminbitcountfornum(10), "int", &function_aef69f3e, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7dc9331ef45ed81f", 1, getminbitcountfornum(10), "int", &function_9ef08327, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7dc9341ef45ed9d2", 1, getminbitcountfornum(10), "int", &function_2ce913ec, 0, 0);
    clientfield::register("scriptmover", "" + #"hash_7dc9351ef45edb85", 1, getminbitcountfornum(10), "int", &function_52eb8e55, 0, 0);
    clientfield::register("actor", "" + #"hash_7a8eab5597b25400", 1, 1, "int", &function_9c94208e, 0, 0);
    level._effect[#"hash_678ccbc01a6cece3"] = #"hash_46b64b63ec916fb0";
    level._effect[#"hash_5c9017c497c2e1ad"] = #"hash_2737905e546b7cf6";
    level._effect[#"hash_5856a36e375deb6e"] = #"hash_3408a29da555383b";
    level._effect[#"hash_5ddc1914159f22e0"] = #"hash_17ae3c34b5b4f5d9";
    level._effect[#"hash_369669eba0e9cba3"] = #"hash_6536e7e0d7d0819c";
    level._effect[#"hash_1e033a5d335f9c80"] = #"hash_23bccae9728cc69";
    level._effect[#"tugboat_surround"] = #"hash_263ef2a7714f7e0";
    level._effect[#"shower_circle_80"] = #"hash_1a2cfde50dc2ab2f";
    level._effect[#"shower_circle_98"] = #"hash_1a297fe50dbf9f3e";
    level._effect[#"shower_circle_112"] = #"hash_7a9e103684dcd9e9";
    level._effect[#"shower_circle_128"] = #"hash_7a93943684d3b2b0";
    level._effect[#"generator_sparks"] = #"hash_274f915858a5ba54";
    level._effect[#"hash_45f8b28452411669"] = #"hash_5a70a6908023185e";
    level._effect[#"hash_7a8eab5597b25400"] = #"hash_680b356c3283464f";
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x78c44d66, Offset: 0xe90
// Size: 0x232
function function_cbd6bd05(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"death");
    if (isdefined(self.var_2cd840d8)) {
        stopfx(localclientnum, self.var_2cd840d8);
        self.var_2cd840d8 = undefined;
    }
    if (newval == 1) {
        while (true) {
            s_result = self waittill(#"hash_593064545176ab53", #"hash_23e33f0aec28e476", #"hash_6ab654a4c018818c");
            if (s_result._notify == #"hash_6ab654a4c018818c") {
                self.var_2cd840d8 = util::playfxontag(localclientnum, level._effect[#"hash_5c9017c497c2e1ad"], self, "tag_origin");
                return;
            }
            if (s_result._notify == #"hash_593064545176ab53") {
                self.var_2cd840d8 = util::playfxontag(localclientnum, level._effect[#"hash_5c9017c497c2e1ad"], self, "tag_origin");
                continue;
            }
            if (isdefined(self.var_2cd840d8)) {
                stopfx(localclientnum, self.var_2cd840d8);
                self.var_2cd840d8 = undefined;
            }
        }
        return;
    }
    if (newval == 2) {
        self.var_2cd840d8 = util::playfxontag(localclientnum, level._effect[#"hash_5856a36e375deb6e"], self, "tag_origin");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xb7ca2822, Offset: 0x10d0
// Size: 0xb2
function function_cd5b975b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_d43a4b94)) {
        stopfx(localclientnum, self.var_d43a4b94);
        self.var_d43a4b94 = undefined;
    }
    if (newval) {
        self.var_d43a4b94 = util::playfxontag(localclientnum, level._effect[#"hash_1e033a5d335f9c80"], self, "tag_origin");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xe970ecd1, Offset: 0x1190
// Size: 0xba
function function_d20f908b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_5a790c88)) {
        stopfx(localclientnum, self.var_5a790c88);
        self.var_5a790c88 = undefined;
    }
    if (newval == 1) {
        self.var_5a790c88 = util::playfxontag(localclientnum, level._effect[#"tugboat_surround"], self, "tag_origin");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x18e038da, Offset: 0x1258
// Size: 0x14e
function function_11c6b3f4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        if (!isdefined(level.var_6da26c79)) {
            level.var_6da26c79 = [];
        } else if (!isarray(level.var_6da26c79)) {
            level.var_6da26c79 = array(level.var_6da26c79);
        }
        if (!isinarray(level.var_6da26c79, self)) {
            level.var_6da26c79[level.var_6da26c79.size] = self;
        }
        self.show_function = &function_9b01e7d6;
        self.hide_function = &function_9a6574d5;
        return;
    }
    arrayremovevalue(level.var_6da26c79, self);
    self notify(#"hash_6ab654a4c018818c");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xc73f8192, Offset: 0x13b0
// Size: 0x1e
function private function_9b01e7d6(localclientnum) {
    self notify(#"hash_593064545176ab53");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x15c2b6c8, Offset: 0x13d8
// Size: 0x1e
function private function_9a6574d5(localclientnum) {
    self notify(#"hash_23e33f0aec28e476");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x922c9809, Offset: 0x1400
// Size: 0x266
function function_fd735bd8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (self isai()) {
        var_2e034e54 = #"hash_68ee9247aaae4517";
    } else {
        var_2e034e54 = #"hash_24cdaac09819f0e";
    }
    if (newval == 1) {
        if (!isdefined(level.var_6da26c79)) {
            level.var_6da26c79 = [];
        } else if (!isarray(level.var_6da26c79)) {
            level.var_6da26c79 = array(level.var_6da26c79);
        }
        if (!isinarray(level.var_6da26c79, self)) {
            level.var_6da26c79[level.var_6da26c79.size] = self;
        }
        self.show_function = &function_17e81c4a;
        self.hide_function = &function_8521ba9;
        self hide();
        self function_98a01e4c(var_2e034e54, "Brightness", 0);
        self function_98a01e4c(var_2e034e54, "Alpha", 0);
        return;
    }
    arrayremovevalue(level.var_6da26c79, self);
    self.show_function = undefined;
    self.hide_function = undefined;
    self show();
    self function_98a01e4c(var_2e034e54, "Brightness", 1);
    self function_98a01e4c(var_2e034e54, "Alpha", 1);
    self notify(#"hash_6ab654a4c018818c");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0xe32f5358, Offset: 0x1670
// Size: 0xce
function private function_17e81c4a(localclientnum) {
    self show();
    if (self isai()) {
        var_2e034e54 = #"hash_68ee9247aaae4517";
    } else {
        var_2e034e54 = #"hash_24cdaac09819f0e";
    }
    self function_98a01e4c(var_2e034e54, "Brightness", 1);
    self function_98a01e4c(var_2e034e54, "Alpha", 1);
    self notify(#"set_visible");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x4
// Checksum 0x5ea38b9, Offset: 0x1748
// Size: 0xc6
function private function_8521ba9(localclientnum) {
    self hide();
    if (self isai()) {
        var_2e034e54 = #"hash_68ee9247aaae4517";
    } else {
        var_2e034e54 = #"hash_24cdaac09819f0e";
    }
    self function_98a01e4c(var_2e034e54, "Brightness", 0);
    self function_98a01e4c(var_2e034e54, "Alpha", 0);
    self notify(#"set_invisible");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x552a8455, Offset: 0x1818
// Size: 0x5ce
function function_54bfed3b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_65bbc5b33653977d");
    self endon(#"death", #"hash_65bbc5b33653977d");
    var_8d970e74 = [];
    if (newval) {
        switch (newval) {
        case 1:
            var_8d970e74 = array(#"hash_34358d231bfdb367", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c");
            break;
        case 2:
            var_8d970e74 = array(#"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c");
            break;
        case 3:
            var_8d970e74 = array(#"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c");
            break;
        case 4:
            var_8d970e74 = array(#"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_b3995a8c1142a1c");
            break;
        case 5:
            var_8d970e74 = array(#"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367");
            break;
        case 6:
            var_8d970e74 = array(#"hash_b3995a8c1142a1c", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367");
            break;
        case 7:
            var_8d970e74 = array(#"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367");
            break;
        case 8:
            var_8d970e74 = array(#"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_34358d231bfdb367", #"hash_34358d231bfdb367");
            break;
        case 9:
            var_8d970e74 = array(#"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_34358d231bfdb367");
            break;
        case 10:
            var_8d970e74 = array(#"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c", #"hash_b3995a8c1142a1c");
            break;
        default:
            break;
        }
    }
    if (var_8d970e74.size) {
        for (i = 0; i < var_8d970e74.size; i++) {
            playsound(localclientnum, var_8d970e74[i], self geteye());
            wait 1;
        }
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x5ccfd80a, Offset: 0x1df0
// Size: 0xfc
function function_5a99d9fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_65bbc5b33653977d");
    self endon(#"death", #"hash_65bbc5b33653977d");
    if (newval == 1) {
        playsound(localclientnum, #"hash_34358d231bfdb367", self geteye());
        return;
    }
    if (newval == 2) {
        playsound(localclientnum, #"hash_b3995a8c1142a1c", self geteye());
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x7a889836, Offset: 0x1ef8
// Size: 0xe2
function function_6b7f5889(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_a968ec10)) {
        deletefx(localclientnum, self.var_a968ec10);
        self.var_a968ec10 = undefined;
    }
    if (newval == 1) {
        playsound(localclientnum, #"hash_b3995a8c1142a1c", self.origin);
        self.var_a968ec10 = util::playfxontag(localclientnum, level._effect[#"hash_45f8b28452411669"], self, "tag_origin");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xa7916118, Offset: 0x1fe8
// Size: 0x14a
function function_58f750b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_63082da9)) {
        stopfx(localclientnum, self.var_63082da9);
        self.var_63082da9 = undefined;
    }
    if (newval > 0) {
        switch (newval) {
        case 1:
            str_effect = "shower_circle_80";
            break;
        case 2:
            str_effect = "shower_circle_98";
            break;
        case 3:
            str_effect = "shower_circle_112";
            break;
        case 4:
            str_effect = "shower_circle_128";
            break;
        }
        self.var_63082da9 = util::playfxontag(localclientnum, level._effect[str_effect], self, "tag_origin");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xb6f9c556, Offset: 0x2140
// Size: 0xba
function function_2fd9c4c7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_41fe1daa)) {
        stopfx(localclientnum, self.var_41fe1daa);
        self.var_41fe1daa = undefined;
    }
    if (newval == 1) {
        self.var_41fe1daa = util::playfxontag(localclientnum, level._effect[#"generator_sparks"], self, "tag_origin");
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x7865cb02, Offset: 0x2208
// Size: 0x43a
function function_ba13e806(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    switch (newval) {
    case 0:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1);
        break;
    case 1:
        self playrenderoverridebundle(#"hash_68ee9247aaae4517");
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Brightness", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1);
        break;
    case 2:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.2);
        break;
    case 3:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.3);
        break;
    case 4:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.4);
        break;
    case 5:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.5);
        break;
    case 6:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.6);
        break;
    case 7:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.7);
        break;
    case 8:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.8);
        break;
    case 9:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.9);
        break;
    case 10:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Brightness", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 2);
        break;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xef22a5fa, Offset: 0x2650
// Size: 0x43a
function function_aef69f3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    switch (newval) {
    case 0:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1);
        break;
    case 1:
        self playrenderoverridebundle(#"hash_24cdaac09819f0e");
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Brightness", 1);
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Alpha", 1);
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1);
        break;
    case 2:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.2);
        break;
    case 3:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.3);
        break;
    case 4:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.4);
        break;
    case 5:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.5);
        break;
    case 6:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.6);
        break;
    case 7:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.7);
        break;
    case 8:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.8);
        break;
    case 9:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 1.9);
        break;
    case 10:
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Brightness", 1);
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Alpha", 1);
        self function_98a01e4c(#"hash_24cdaac09819f0e", "Tint", 2);
        break;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xb5df4c2b, Offset: 0x2a98
// Size: 0x43a
function function_fea70046(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    switch (newval) {
    case 0:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Brightness", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 2);
        break;
    case 1:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.9);
        break;
    case 2:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.8);
        break;
    case 3:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.7);
        break;
    case 4:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.6);
        break;
    case 5:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.5);
        break;
    case 6:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.4);
        break;
    case 7:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.3);
        break;
    case 8:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.2);
        break;
    case 9:
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1.1);
        break;
    case 10:
        self playrenderoverridebundle(#"hash_68ee9247aaae4517");
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Brightness", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Alpha", 1);
        self function_98a01e4c(#"hash_68ee9247aaae4517", "Tint", 1);
        break;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x4245f538, Offset: 0x2ee0
// Size: 0x1b6
function function_9ef08327(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        if (isdefined(self.mdl_paper)) {
            self.mdl_paper delete();
        }
        return;
    }
    if (isdefined(self.mdl_paper)) {
        self.var_9846d2ad = newval;
        return;
    }
    self.mdl_paper = util::spawn_model(localclientnum, #"hash_11298e91093a52ac", self.origin, self.angles);
    self.mdl_paper.var_9846d2ad = newval;
    self.mdl_paper.show_function = &function_5ccd9d17;
    self.mdl_paper.hide_function = &function_968baabe;
    self.mdl_paper function_968baabe(localclientnum);
    if (!isdefined(level.var_6da26c79)) {
        level.var_6da26c79 = [];
    } else if (!isarray(level.var_6da26c79)) {
        level.var_6da26c79 = array(level.var_6da26c79);
    }
    level.var_6da26c79[level.var_6da26c79.size] = self.mdl_paper;
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0xfa5d3f0a, Offset: 0x30a0
// Size: 0x86
function function_2ce913ec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval > 0) {
        while (!isdefined(self.mdl_paper)) {
            waitframe(1);
        }
        self.mdl_paper.var_be494d16 = newval;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x520f9a55, Offset: 0x3130
// Size: 0x86
function function_52eb8e55(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (newval > 0) {
        while (!isdefined(self.mdl_paper)) {
            waitframe(1);
        }
        self.mdl_paper.var_e44bc77f = newval;
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0xc1eb95f2, Offset: 0x31c0
// Size: 0x3cc
function function_968baabe(localclientnum) {
    self hidepart(localclientnum, "tag_nixie_number_1_1");
    self hidepart(localclientnum, "tag_nixie_number_1_2");
    self hidepart(localclientnum, "tag_nixie_number_1_3");
    self hidepart(localclientnum, "tag_nixie_number_1_4");
    self hidepart(localclientnum, "tag_nixie_number_1_5");
    self hidepart(localclientnum, "tag_nixie_number_1_6");
    self hidepart(localclientnum, "tag_nixie_number_1_7");
    self hidepart(localclientnum, "tag_nixie_number_1_8");
    self hidepart(localclientnum, "tag_nixie_number_1_9");
    self hidepart(localclientnum, "tag_nixie_number_1_0");
    self hidepart(localclientnum, "tag_nixie_number_2_1");
    self hidepart(localclientnum, "tag_nixie_number_2_2");
    self hidepart(localclientnum, "tag_nixie_number_2_3");
    self hidepart(localclientnum, "tag_nixie_number_2_4");
    self hidepart(localclientnum, "tag_nixie_number_2_5");
    self hidepart(localclientnum, "tag_nixie_number_2_6");
    self hidepart(localclientnum, "tag_nixie_number_2_7");
    self hidepart(localclientnum, "tag_nixie_number_2_8");
    self hidepart(localclientnum, "tag_nixie_number_2_9");
    self hidepart(localclientnum, "tag_nixie_number_2_0");
    self hidepart(localclientnum, "tag_nixie_number_3_1");
    self hidepart(localclientnum, "tag_nixie_number_3_2");
    self hidepart(localclientnum, "tag_nixie_number_3_3");
    self hidepart(localclientnum, "tag_nixie_number_3_4");
    self hidepart(localclientnum, "tag_nixie_number_3_5");
    self hidepart(localclientnum, "tag_nixie_number_3_6");
    self hidepart(localclientnum, "tag_nixie_number_3_7");
    self hidepart(localclientnum, "tag_nixie_number_3_8");
    self hidepart(localclientnum, "tag_nixie_number_3_9");
    self hidepart(localclientnum, "tag_nixie_number_3_0");
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 1, eflags: 0x0
// Checksum 0x52c4e25c, Offset: 0x3598
// Size: 0x51c
function function_5ccd9d17(localclientnum) {
    self hidepart(localclientnum, "tag_nixie_number_1_1");
    self hidepart(localclientnum, "tag_nixie_number_1_2");
    self hidepart(localclientnum, "tag_nixie_number_1_3");
    self hidepart(localclientnum, "tag_nixie_number_1_4");
    self hidepart(localclientnum, "tag_nixie_number_1_5");
    self hidepart(localclientnum, "tag_nixie_number_1_6");
    self hidepart(localclientnum, "tag_nixie_number_1_7");
    self hidepart(localclientnum, "tag_nixie_number_1_8");
    self hidepart(localclientnum, "tag_nixie_number_1_9");
    self hidepart(localclientnum, "tag_nixie_number_1_0");
    self hidepart(localclientnum, "tag_nixie_number_2_1");
    self hidepart(localclientnum, "tag_nixie_number_2_2");
    self hidepart(localclientnum, "tag_nixie_number_2_3");
    self hidepart(localclientnum, "tag_nixie_number_2_4");
    self hidepart(localclientnum, "tag_nixie_number_2_5");
    self hidepart(localclientnum, "tag_nixie_number_2_6");
    self hidepart(localclientnum, "tag_nixie_number_2_7");
    self hidepart(localclientnum, "tag_nixie_number_2_8");
    self hidepart(localclientnum, "tag_nixie_number_2_9");
    self hidepart(localclientnum, "tag_nixie_number_2_0");
    self hidepart(localclientnum, "tag_nixie_number_3_1");
    self hidepart(localclientnum, "tag_nixie_number_3_2");
    self hidepart(localclientnum, "tag_nixie_number_3_3");
    self hidepart(localclientnum, "tag_nixie_number_3_4");
    self hidepart(localclientnum, "tag_nixie_number_3_5");
    self hidepart(localclientnum, "tag_nixie_number_3_6");
    self hidepart(localclientnum, "tag_nixie_number_3_7");
    self hidepart(localclientnum, "tag_nixie_number_3_8");
    self hidepart(localclientnum, "tag_nixie_number_3_9");
    self hidepart(localclientnum, "tag_nixie_number_3_0");
    if (isdefined(self.var_9846d2ad)) {
        if (self.var_9846d2ad == 10) {
            self showpart(localclientnum, "tag_nixie_number_1_0");
        } else {
            self showpart(localclientnum, "tag_nixie_number_1_" + self.var_9846d2ad);
        }
    }
    if (isdefined(self.var_be494d16)) {
        if (self.var_be494d16 == 10) {
            self showpart(localclientnum, "tag_nixie_number_2_0");
        } else {
            self showpart(localclientnum, "tag_nixie_number_2_" + self.var_be494d16);
        }
    }
    if (isdefined(self.var_e44bc77f)) {
        if (self.var_e44bc77f == 10) {
            self showpart(localclientnum, "tag_nixie_number_3_0");
            return;
        }
        self showpart(localclientnum, "tag_nixie_number_3_" + self.var_e44bc77f);
    }
}

// Namespace namespace_8adb45e8/namespace_8adb45e8
// Params 7, eflags: 0x0
// Checksum 0x8b8d30ba, Offset: 0x3ac0
// Size: 0xf2
function function_9c94208e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.n_death_fx)) {
        deletefx(localclientnum, self.n_death_fx, 1);
        self.n_death_fx = undefined;
    }
    if (newval == 1) {
        str_tag = "j_spineupper";
        if (self.archetype == "zombie_dog") {
            str_tag = "j_spine1";
        }
        self.n_death_fx = util::playfxontag(localclientnum, level._effect[#"hash_7a8eab5597b25400"], self, str_tag);
    }
}

