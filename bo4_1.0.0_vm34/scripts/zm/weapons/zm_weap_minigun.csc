#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_minigun;

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x2
// Checksum 0xfde8764a, Offset: 0x128
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_minigun", &__init__, undefined, undefined);
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 0, eflags: 0x0
// Checksum 0xb4e689eb, Offset: 0x170
// Size: 0x10a
function __init__() {
    clientfield::register("toplayer", "hero_minigun_vigor_postfx", 1, 1, "counter", &function_1a751bb4, 0, 0);
    clientfield::register("allplayers", "minigun_launcher_muzzle_fx", 1, 1, "counter", &minigun_launcher_muzzle_fx, 0, 0);
    clientfield::register("missile", "minigun_nuke_rob", 1, 1, "int", &minigun_nuke_rob, 0, 0);
    level._effect[#"launcher_flash"] = #"hash_65b54823a8e8631e";
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 7, eflags: 0x4
// Checksum 0x46715b84, Offset: 0x288
// Size: 0x64
function private function_1a751bb4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self thread postfx::playpostfxbundle(#"hash_1663ca7cc81f9b17");
    }
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 7, eflags: 0x4
// Checksum 0xab963ca9, Offset: 0x2f8
// Size: 0x84
function private minigun_nuke_rob(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue == 1) {
        self playrenderoverridebundle("rob_zm_going_nuclear");
        return;
    }
    self stoprenderoverridebundle("rob_zm_going_nuclear");
}

// Namespace zm_weap_minigun/zm_weap_minigun
// Params 7, eflags: 0x0
// Checksum 0x7a6b4b8e, Offset: 0x388
// Size: 0x102
function minigun_launcher_muzzle_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(self.var_4f5ae109)) {
        deletefx(localclientnum, self.var_4f5ae109, 1);
    }
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        self.var_4f5ae109 = playviewmodelfx(localclientnum, level._effect[#"launcher_flash"], "tag_flash2");
        return;
    }
    self.var_4f5ae109 = util::playfxontag(localclientnum, level._effect[#"launcher_flash"], self, "tag_flash2");
}

