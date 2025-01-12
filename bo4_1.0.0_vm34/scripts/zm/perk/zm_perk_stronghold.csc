#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;

#namespace zm_perk_stronghold;

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x2
// Checksum 0x98b1b3d5, Offset: 0x108
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_perk_stronghold", &__init__, undefined, undefined);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0xe2337dbe, Offset: 0x150
// Size: 0x42
function __init__() {
    enable_stronghold_perk_for_level();
    level._effect[#"hash_24e322568c9492c5"] = #"hash_497cb15bcf6c05b1";
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0xaa477c37, Offset: 0x1a0
// Size: 0xd4
function enable_stronghold_perk_for_level() {
    zm_perks::register_perk_clientfields(#"specialty_camper", &function_662cecf, &function_9690eee2);
    zm_perks::register_perk_effects(#"specialty_camper", "divetonuke_light");
    zm_perks::register_perk_init_thread(#"specialty_camper", &init_stronghold);
    zm_perks::function_32b099ec(#"specialty_camper", #"p8_zm_vapor_altar_icon_01_stonecoldstronghold", "zombie/fx8_perk_altar_symbol_ambient_stronghold");
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x280
// Size: 0x4
function init_stronghold() {
    
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x3563a529, Offset: 0x290
// Size: 0x94
function function_662cecf() {
    clientfield::register("clientuimodel", "hudItems.perks.stronghold", 1, 1, "int", undefined, 0, 1);
    clientfield::register("toplayer", "" + #"hash_24e322568c9492c5", 1, 1, "int", &function_ceebc9d2, 0, 0);
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 0, eflags: 0x0
// Checksum 0x80f724d1, Offset: 0x330
// Size: 0x4
function function_9690eee2() {
    
}

// Namespace zm_perk_stronghold/zm_perk_stronghold
// Params 7, eflags: 0x0
// Checksum 0x8368ad3e, Offset: 0x340
// Size: 0x1ae
function function_ceebc9d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (isdefined(self.var_267a2996)) {
            deletefx(localclientnum, self.var_267a2996, 1);
        }
        self.var_267a2996 = util::playfxontag(localclientnum, level._effect[#"hash_24e322568c9492c5"], self, "j_spine");
        if (!isdefined(self.var_79b418d1)) {
            self playsound(localclientnum, #"hash_5e1e162af8490f1d");
            self.var_79b418d1 = self playloopsound(#"hash_641286598a33d4e3");
        }
        return;
    }
    if (isdefined(self.var_267a2996)) {
        deletefx(localclientnum, self.var_267a2996, 0);
        self.var_267a2996 = undefined;
    }
    if (isdefined(self.var_79b418d1)) {
        self playsound(localclientnum, #"hash_73b66a25abec1fe4");
        self stoploopsound(self.var_79b418d1);
        self.var_79b418d1 = undefined;
    }
}

