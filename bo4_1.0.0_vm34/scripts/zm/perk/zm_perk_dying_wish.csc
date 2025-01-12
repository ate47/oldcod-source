#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;

#namespace zm_perk_dying_wish;

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x2
// Checksum 0x8cfa1f75, Offset: 0x120
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_dying_wish", &__init__, undefined, undefined);
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xc699dc25, Offset: 0x168
// Size: 0x14
function __init__() {
    enable_dying_wish_perk_for_level();
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x7b9c47d8, Offset: 0x188
// Size: 0x102
function enable_dying_wish_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_berserker", &function_2bd2b35e, &function_f9b12db5);
    zm_perks::register_perk_effects(#"specialty_berserker", "divetonuke_light");
    zm_perks::register_perk_init_thread(#"specialty_berserker", &function_f8e75f45);
    zm_perks::function_32b099ec(#"specialty_berserker", #"p8_zm_vapor_altar_icon_01_dyingwish", "zombie/fx8_perk_altar_symbol_ambient_dying_wish");
    level._effect[#"hash_481f130cd5e53b7f"] = #"hash_620000088d4c3f79";
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x298
// Size: 0x4
function function_f8e75f45() {
    
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0xca71a40f, Offset: 0x2a8
// Size: 0x94
function function_2bd2b35e() {
    clientfield::register("clientuimodel", "hudItems.perks.dying_wish", 1, 1, "int", undefined, 0, 1);
    clientfield::register("allplayers", "" + #"hash_10f459edea6b3eb", 1, 1, "int", &function_b1eaefce, 0, 0);
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x348
// Size: 0x4
function function_f9b12db5() {
    
}

// Namespace zm_perk_dying_wish/zm_perk_dying_wish
// Params 7, eflags: 0x4
// Checksum 0x49002bc3, Offset: 0x358
// Size: 0x206
function private function_b1eaefce(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
    if (newvalue) {
        if (self zm_utility::function_a96d4c46(localclientnum)) {
            self thread postfx::playpostfxbundle(#"pstfx_zm_dying_wish");
        } else {
            self.var_936ebd2c = util::playfxontag(localclientnum, level._effect[#"hash_481f130cd5e53b7f"], self, "j_spine");
        }
        if (!isdefined(self.var_f4baf998)) {
            self.var_ee10be2d = 1;
            self playsound(localclientnum, #"hash_268d2ee0a0daf799");
            self.var_f4baf998 = self playloopsound(#"hash_22a448c0d7682cdf");
        }
        return;
    }
    if (self zm_utility::function_a96d4c46(localclientnum)) {
        self thread postfx::exitpostfxbundle(#"pstfx_zm_dying_wish");
    } else if (isdefined(self.var_936ebd2c)) {
        stopfx(localclientnum, self.var_936ebd2c);
        self.var_936ebd2c = undefined;
    }
    if (isdefined(self.var_f4baf998)) {
        self.var_ee10be2d = 0;
        self playsound(localclientnum, #"hash_2f273ae29320f08");
        self stoploopsound(self.var_f4baf998);
        self.var_f4baf998 = undefined;
    }
}

