#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace gadget_combat_efficiency;

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x2
// Checksum 0x2c67dd32, Offset: 0xb0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"gadget_combat_efficiency", &__init__, undefined, undefined);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 0, eflags: 0x0
// Checksum 0x3dbf4569, Offset: 0xf8
// Size: 0x4c
function __init__() {
    clientfield::register("clientuimodel", "hudItems.combatEfficiencyActive", 1, 1, "int", &function_699344d2, 0, 0);
}

// Namespace gadget_combat_efficiency/gadget_combat_efficiency
// Params 7, eflags: 0x0
// Checksum 0xea140f37, Offset: 0x150
// Size: 0x126
function function_699344d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(newval) && newval > 0) {
        if (newval != oldval) {
            self playsound(localclientnum, #"hash_3eea09f794eb0577");
        }
        if (!isdefined(self.var_19abfa75)) {
            self.var_19abfa75 = self playloopsound(#"hash_1a6eca90431e5c64");
        }
        return;
    }
    if (isdefined(self.var_19abfa75)) {
        self stoploopsound(self.var_19abfa75);
        self playsound(localclientnum, #"hash_529910b20b42ef5b");
        self.var_19abfa75 = undefined;
    }
}

