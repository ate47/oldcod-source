#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_electric_cherry;

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x2
// Checksum 0x27d4c3da, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_electric_cherry", &__init__, undefined, undefined);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x7c04a59b, Offset: 0x1f8
// Size: 0xd4
function __init__() {
    zm_perks::register_perk_clientfields(#"specialty_electriccherry", &electric_cherry_client_field_func, &electric_cherry_code_callback_func);
    zm_perks::register_perk_effects(#"specialty_electriccherry", "electric_light");
    zm_perks::register_perk_init_thread(#"specialty_electriccherry", &init_electric_cherry);
    zm_perks::function_32b099ec(#"specialty_electriccherry", #"p8_zm_vapor_altar_icon_01_electricburst", "zombie/fx8_perk_altar_symbol_ambient_electric_cherry");
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x4133dd74, Offset: 0x2d8
// Size: 0x2a2
function init_electric_cherry() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect[#"electric_light"] = #"hash_1442db17b83460ad";
    }
    clientfield::register("allplayers", "electric_cherry_reload_fx", 1, 2, "int", &electric_cherry_reload_attack_fx, 0, 0);
    clientfield::register("actor", "tesla_death_fx", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
    clientfield::register("vehicle", "tesla_death_fx_veh", 1, 1, "int", &tesla_death_fx_callback, 0, 0);
    clientfield::register("actor", "tesla_shock_eyes_fx", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
    clientfield::register("vehicle", "tesla_shock_eyes_fx_veh", 1, 1, "int", &tesla_shock_eyes_fx_callback, 0, 0);
    level._effect[#"electric_cherry_explode"] = #"hash_413a313438a3a4e1";
    level._effect[#"electric_cherry_trail"] = #"hash_58c2d7d24c0d61a7";
    level._effect[#"tesla_death_cherry"] = #"zombie/fx_tesla_shock_zmb";
    level._effect[#"tesla_shock_eyes_cherry"] = #"zombie/fx_tesla_shock_eyes_zmb";
    level._effect[#"tesla_shock_cherry"] = #"zombie/fx_bmode_shock_os_zod_zmb";
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x3b118981, Offset: 0x588
// Size: 0x3c
function electric_cherry_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.electric_cherry", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x5d0
// Size: 0x4
function electric_cherry_code_callback_func() {
    
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 7, eflags: 0x0
// Checksum 0x5786bfc, Offset: 0x5e0
// Size: 0x11a
function electric_cherry_reload_attack_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!self hasdobj(localclientnum)) {
        return;
    }
    if (isdefined(self.electric_cherry_reload_fx)) {
        stopfx(localclientnum, self.electric_cherry_reload_fx);
        self.electric_cherry_reload_fx = undefined;
    }
    switch (newval) {
    case 1:
    case 2:
    case 3:
        self.electric_cherry_reload_fx = util::playfxontag(localclientnum, level._effect[#"electric_cherry_explode"], self, "tag_origin");
        break;
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 7, eflags: 0x0
// Checksum 0xc8106169, Offset: 0x708
// Size: 0x1c6
function tesla_death_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        str_tag = "J_SpineUpper";
        if (isdefined(self.str_tag_tesla_death_fx)) {
            str_tag = self.str_tag_tesla_death_fx;
        } else if (isdefined(self.isdog) && self.isdog) {
            str_tag = "J_Spine1";
        }
        if (!isdefined(self.var_9aa636fa)) {
            self playsound(localclientnum, #"hash_3b277f4572603015");
            self.var_9aa636fa = self playloopsound(#"hash_2f0f235f7f6fc84d");
        }
        self.n_death_fx = util::playfxontag(localclientnum, level._effect[#"tesla_death_cherry"], self, str_tag);
        setfxignorepause(localclientnum, self.n_death_fx, 1);
        return;
    }
    if (isdefined(self.n_death_fx)) {
        deletefx(localclientnum, self.n_death_fx, 1);
    }
    self.n_death_fx = undefined;
    if (isdefined(self.var_9aa636fa)) {
        self stoploopsound(self.var_9aa636fa);
        self.var_9aa636fa = undefined;
    }
}

// Namespace zm_perk_electric_cherry/zm_perk_electric_cherry
// Params 7, eflags: 0x0
// Checksum 0x8228c24b, Offset: 0x8d8
// Size: 0x296
function tesla_shock_eyes_fx_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        str_tag = "J_SpineUpper";
        if (isdefined(self.str_tag_tesla_shock_eyes_fx)) {
            str_tag = self.str_tag_tesla_shock_eyes_fx;
        } else if (isdefined(self.isdog) && self.isdog) {
            str_tag = "J_Spine1";
        }
        if (!isdefined(self.var_9aa636fa)) {
            self playsound(localclientnum, #"hash_3b277f4572603015");
            self.var_9aa636fa = self playloopsound(#"hash_2f0f235f7f6fc84d");
        }
        self.n_shock_eyes_fx = util::playfxontag(localclientnum, level._effect[#"tesla_shock_eyes_cherry"], self, "J_Eyeball_LE");
        if (isdefined(self) && isdefined(self.n_shock_eyes_fx)) {
            setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
        }
        self.n_shock_fx = util::playfxontag(localclientnum, level._effect[#"tesla_death_cherry"], self, str_tag);
        if (isdefined(self) && isdefined(self.n_shock_eyes_fx)) {
            setfxignorepause(localclientnum, self.n_shock_fx, 1);
        }
        return;
    }
    if (isdefined(self.n_shock_eyes_fx)) {
        deletefx(localclientnum, self.n_shock_eyes_fx, 1);
        self.n_shock_eyes_fx = undefined;
    }
    if (isdefined(self.n_shock_fx)) {
        deletefx(localclientnum, self.n_shock_fx, 1);
        self.n_shock_fx = undefined;
    }
    if (isdefined(self.var_9aa636fa)) {
        self stoploopsound(self.var_9aa636fa);
        self.var_9aa636fa = undefined;
    }
}

