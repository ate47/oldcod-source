#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;

#namespace zm_weap_katana;

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x2
// Checksum 0x35b35f5b, Offset: 0x130
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_weap_katana", &__init__, undefined, undefined);
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 0, eflags: 0x0
// Checksum 0x1347bcef, Offset: 0x178
// Size: 0xdc
function __init__() {
    clientfield::register("toplayer", "hero_katana_vigor_postfx", 1, 1, "counter", &function_1a751bb4, 0, 0);
    clientfield::register("allplayers", "katana_rush_postfx", 1, 1, "int", &katana_rush_postfx, 0, 1);
    clientfield::register("allplayers", "katana_rush_sfx", 1, 1, "int", &katana_rush_sfx, 0, 1);
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 7, eflags: 0x4
// Checksum 0xd0825249, Offset: 0x260
// Size: 0x64
function private function_1a751bb4(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        self thread postfx::playpostfxbundle(#"hash_4e5b35f770492ddb");
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 7, eflags: 0x0
// Checksum 0x573c3865, Offset: 0x2d0
// Size: 0x398
function katana_rush_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_ea3e012f)) {
        self.var_ea3e012f = [];
    }
    if (!isdefined(self.var_ea3e012f[localclientnum])) {
        self.var_ea3e012f[localclientnum] = [];
    }
    if (newval == 1) {
        if (self.weapon !== getweapon(#"hero_katana_t8_lv3")) {
            return;
        }
        if (self getlocalclientnumber() === localclientnum) {
            self thread postfx::playpostfxbundle(#"hash_34ce6f9f022458f8");
            self thread function_cd45e460(localclientnum);
            a_e_players = getlocalplayers();
            foreach (e_player in a_e_players) {
                if (!e_player util::function_162f7df2(localclientnum)) {
                    e_player thread zm_utility::function_7bcc2e7e(localclientnum, #"hash_34ce6f9f022458f8", #"hash_49e404aa0d33e9ac");
                }
            }
        } else {
            self.var_ea3e012f[localclientnum] = playtagfxset(localclientnum, "weapon_katana_smoke_3p", self);
        }
        return;
    }
    if (self getlocalclientnumber() === localclientnum) {
        self postfx::stoppostfxbundle(#"hash_34ce6f9f022458f8");
        self thread function_ff2d9706(localclientnum);
        a_e_players = getlocalplayers();
        foreach (e_player in a_e_players) {
            if (!e_player util::function_162f7df2(localclientnum)) {
                e_player notify(#"hash_49e404aa0d33e9ac");
            }
        }
        return;
    }
    if (isdefined(self.var_ea3e012f[localclientnum])) {
        foreach (fx in self.var_ea3e012f[localclientnum]) {
            stopfx(localclientnum, fx);
        }
        self.var_ea3e012f[localclientnum] = undefined;
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x4
// Checksum 0x86f51f2b, Offset: 0x670
// Size: 0xc8
function private function_cd45e460(localclientnum) {
    ai::add_ai_spawn_function(&function_41380c78);
    a_ai = getentarraybytype(localclientnum, 15);
    foreach (ai in a_ai) {
        ai thread function_41380c78(localclientnum);
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x4
// Checksum 0x3d8d604d, Offset: 0x740
// Size: 0xc2
function private function_41380c78(localclientnum) {
    if (!isdefined(self.var_c0b8f45f)) {
        self.var_c0b8f45f = [];
    }
    if (!isdefined(self.var_c0b8f45f[localclientnum])) {
        self.var_c0b8f45f[localclientnum] = [];
    }
    if (!(isdefined(self.var_f8d90056) && self.var_f8d90056)) {
        self.var_f8d90056 = 1;
        self playrenderoverridebundle(#"hash_acd19c41950b1a9");
        self.var_c0b8f45f[localclientnum] = playtagfxset(localclientnum, "weapon_katana_zmb_smoke_3p", self);
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 1, eflags: 0x4
// Checksum 0xeae6d73, Offset: 0x810
// Size: 0x1b0
function private function_ff2d9706(localclientnum) {
    ai::function_692f6be5(&function_41380c78);
    a_ai = getentarraybytype(localclientnum, 15);
    foreach (ai in a_ai) {
        if (isdefined(ai.var_c0b8f45f) && isdefined(ai.var_c0b8f45f[localclientnum])) {
            foreach (fx in ai.var_c0b8f45f[localclientnum]) {
                stopfx(localclientnum, fx);
            }
            ai.var_c0b8f45f[localclientnum] = undefined;
        }
        if (isdefined(ai.var_f8d90056) && ai.var_f8d90056) {
            ai.var_f8d90056 = undefined;
            ai stoprenderoverridebundle(#"hash_acd19c41950b1a9");
        }
    }
}

// Namespace zm_weap_katana/zm_weap_katana
// Params 7, eflags: 0x0
// Checksum 0x194f2b22, Offset: 0x9c8
// Size: 0x10e
function katana_rush_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(self.var_58814afd)) {
            self playsound(localclientnum, #"hash_74fd1bb2db3d91ee");
            self.var_58814afd = self playloopsound(#"hash_4f7953dcf02e2ba7");
        }
        return;
    }
    if (isdefined(self.var_58814afd)) {
        self playsound(localclientnum, #"hash_76e75d7b16257c11");
        self stoploopsound(self.var_58814afd);
        self.var_58814afd = undefined;
    }
}

