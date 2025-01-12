#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace namespace_50e40b79;

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 0, eflags: 0x2
// Checksum 0x5f98200a, Offset: 0x100
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"hash_77ae506b4db4f2ce", &__init__, undefined, undefined);
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 0, eflags: 0x0
// Checksum 0xbaa1e22, Offset: 0x148
// Size: 0x352
function __init__() {
    clientfield::register("toplayer", "" + #"hash_11ff39a3100ac894", 1, 1, "int", &function_814a75ce, 0, 0);
    clientfield::register("toplayer", "" + #"hash_37c33178198d54e4", 1, 1, "int", &function_a9efd21e, 0, 0);
    clientfield::register("toplayer", "" + #"hash_5d9808a62579e894", 1, 1, "int", &function_b8dbb172, 0, 0);
    clientfield::register("toplayer", "" + #"hash_4ec2b359458774e4", 1, 1, "int", &function_15eba132, 0, 0);
    clientfield::register("toplayer", "" + #"hash_4724376be4e925a3", 1, 1, "int", &function_4b9a36d3, 0, 0);
    clientfield::register("toplayer", "" + #"hash_1aa1c7790dc67d1e", 1, 1, "int", &function_af2aa089, 0, 0);
    clientfield::register("toplayer", "" + #"hash_7cdfc8f4819bab2e", 1, 1, "int", &function_4c8dede9, 0, 0);
    clientfield::register("toplayer", "" + #"hash_61ed2f45564d54f9", 1, 1, "int", &function_db3e6c6, 0, 0);
    level._effect[#"hash_1aa1c7790dc67d1e"] = #"hash_2a9ea20e6cb5f0fb";
    level._effect[#"hash_7cdfc8f4819bab2e"] = #"hash_e1bfaf62712f587";
    level._effect[#"hash_61ed2f45564d54f9"] = #"hash_5531980ba0ce0b70";
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0xc498e00e, Offset: 0x4a8
// Size: 0xec
function function_814a75ce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_2fa1b571)) {
        var_5651ad97 = struct::get("s_g_r_sp2");
        self.var_2fa1b571 = util::spawn_model(localclientnum, var_5651ad97.model, var_5651ad97.origin, var_5651ad97.angles);
    }
    if (newval) {
        self.var_2fa1b571 show();
        return;
    }
    self.var_2fa1b571 hide();
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0x16c003fe, Offset: 0x5a0
// Size: 0xec
function function_a9efd21e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_7e87131)) {
        var_5651ad97 = struct::get("s_r_s_sp2");
        self.var_7e87131 = util::spawn_model(localclientnum, var_5651ad97.model, var_5651ad97.origin, var_5651ad97.angles);
    }
    if (newval) {
        self.var_7e87131 show();
        return;
    }
    self.var_7e87131 hide();
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0xd85a5a51, Offset: 0x698
// Size: 0xec
function function_b8dbb172(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_dd99a156)) {
        var_5651ad97 = struct::get("s_acid_trap_place_loc");
        self.var_dd99a156 = util::spawn_model(localclientnum, var_5651ad97.model, var_5651ad97.origin, var_5651ad97.angles);
    }
    if (newval) {
        self.var_dd99a156 show();
        return;
    }
    self.var_dd99a156 hide();
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0xd1fd9b69, Offset: 0x790
// Size: 0xfc
function function_15eba132(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_5a1f6416)) {
        var_5651ad97 = struct::get("s_spin_trap_place_loc");
        self.var_5a1f6416 = util::spawn_model(localclientnum, var_5651ad97.model, var_5651ad97.origin - (0, 0, 3), var_5651ad97.angles);
    }
    if (newval) {
        self.var_5a1f6416 show();
        return;
    }
    self.var_5a1f6416 hide();
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0xa6013821, Offset: 0x898
// Size: 0xfc
function function_4b9a36d3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_665d47ff)) {
        var_5651ad97 = struct::get("s_fan_trap_place_loc");
        self.var_665d47ff = util::spawn_model(localclientnum, var_5651ad97.model, var_5651ad97.origin - (0, 0, 3), var_5651ad97.angles);
    }
    if (newval) {
        self.var_665d47ff show();
        return;
    }
    self.var_665d47ff hide();
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0x3a00e8e4, Offset: 0x9a0
// Size: 0xb2
function function_af2aa089(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_5651ad97 = struct::get("s_spin_trap_place_loc");
    self.var_d21e8c72 = playfx(localclientnum, level._effect[#"hash_1aa1c7790dc67d1e"], var_5651ad97.origin - (0, 0, 3));
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0x5cd0ddfe, Offset: 0xa60
// Size: 0xa2
function function_4c8dede9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_5651ad97 = struct::get("s_acid_trap_place_loc");
    self.var_28b3abf2 = playfx(localclientnum, level._effect[#"hash_7cdfc8f4819bab2e"], var_5651ad97.origin);
}

// Namespace namespace_50e40b79/namespace_50e40b79
// Params 7, eflags: 0x0
// Checksum 0x50105967, Offset: 0xb10
// Size: 0xb2
function function_db3e6c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_5651ad97 = struct::get("s_fan_trap_place_loc");
    self.var_4cbb2e85 = playfx(localclientnum, level._effect[#"hash_61ed2f45564d54f9"], var_5651ad97.origin - (0, 0, 3));
}

