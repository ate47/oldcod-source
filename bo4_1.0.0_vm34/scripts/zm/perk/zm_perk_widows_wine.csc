#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_widows_wine;

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x2
// Checksum 0xa194d39e, Offset: 0x200
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_widows_wine", &__init__, undefined, undefined);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x146cbf83, Offset: 0x248
// Size: 0xd4
function __init__() {
    zm_perks::register_perk_clientfields(#"specialty_widowswine", &widows_wine_client_field_func, &widows_wine_code_callback_func);
    zm_perks::register_perk_effects(#"specialty_widowswine", "widow_light");
    zm_perks::register_perk_init_thread(#"specialty_widowswine", &init_widows_wine);
    zm_perks::function_32b099ec(#"specialty_widowswine", #"p8_zm_vapor_altar_icon_01_winterswail", "zombie/fx8_perk_altar_symbol_ambient_widows_wine");
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x5c96ffa5, Offset: 0x328
// Size: 0xc2
function init_widows_wine() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"widow_light"] = "zombie/fx_perk_widows_wine_zmb";
        level._effect[#"winters_wail_freeze"] = "zombie/fx8_perk_winters_wail_freeze";
        level._effect[#"winters_wail_explosion"] = "zombie/fx8_perk_winters_wail_exp";
        level._effect[#"winters_wail_slow_field"] = "zombie/fx8_perk_winters_wail_aoe";
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x1a933522, Offset: 0x3f8
// Size: 0x15c
function widows_wine_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.widows_wine", 1, 2, "int", undefined, 0, 1);
    clientfield::register("actor", "winters_wail_freeze", 1, 1, "int", &function_91ab6eac, 0, 1);
    clientfield::register("vehicle", "winters_wail_freeze", 1, 1, "int", &function_91ab6eac, 0, 0);
    clientfield::register("allplayers", "winters_wail_explosion", 1, 1, "counter", &widows_wine_explosion, 0, 0);
    clientfield::register("allplayers", "winters_wail_slow_field", 1, 1, "int", &function_59179da9, 0, 0);
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x560
// Size: 0x4
function widows_wine_code_callback_func() {
    
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 7, eflags: 0x0
// Checksum 0x29256087, Offset: 0x570
// Size: 0x1bc
function function_91ab6eac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isalive(self)) {
            if (!isdefined(self.var_b36427a5)) {
                if (isdefined(self gettagorigin("j_spineupper"))) {
                    str_tag = "j_spineupper";
                } else {
                    str_tag = "j_spine4";
                }
                self.var_b36427a5 = util::playfxontag(localclientnum, level._effect[#"winters_wail_freeze"], self, str_tag);
            }
            if (!isdefined(self.sndwidowswine)) {
                self playsound(localclientnum, #"hash_21bfd3813003fd44");
                self.sndwidowswine = self playloopsound(#"hash_199de7173fb36de6", 0.1);
            }
        }
        return;
    }
    if (isdefined(self.var_b36427a5)) {
        stopfx(localclientnum, self.var_b36427a5);
        self.var_b36427a5 = undefined;
    }
    if (isdefined(self.sndwidowswine)) {
        self stoploopsound(self.sndwidowswine, 1);
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 7, eflags: 0x0
// Checksum 0x74da8591, Offset: 0x738
// Size: 0xc4
function widows_wine_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playfx(localclientnum, level._effect[#"winters_wail_explosion"], self gettagorigin("j_spine4"), self.angles);
        self playsound(localclientnum, #"hash_3b59d3c99bac4071");
    }
}

// Namespace zm_perk_widows_wine/zm_perk_widows_wine
// Params 7, eflags: 0x0
// Checksum 0x3d571e6e, Offset: 0x808
// Size: 0xe6
function function_59179da9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.var_946eb304 = util::playfxontag(localclientnum, level._effect[#"winters_wail_slow_field"], self, "j_spine");
        self playsound(localclientnum, #"hash_2d956dd01a5a8800");
        return;
    }
    if (isdefined(self.var_946eb304)) {
        stopfx(localclientnum, self.var_946eb304);
        self.var_946eb304 = undefined;
    }
}

