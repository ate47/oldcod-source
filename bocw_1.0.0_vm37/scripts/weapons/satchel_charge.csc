#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x0
// Checksum 0x4fd3eb2e, Offset: 0xc8
// Size: 0x84
function init_shared(*localclientnum) {
    callback::add_weapon_type(#"satchel_charge", &function_34e248b6);
    clientfield::register("missile", "satchelChargeWarning", 1, 1, "int", &function_e402bf2c, 0, 0);
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x0
// Checksum 0xa2bb4f1c, Offset: 0x158
// Size: 0x11c
function function_34e248b6(localclientnum) {
    self endon(#"death");
    if (self isgrenadedud()) {
        return;
    }
    self util::waittill_dobj(localclientnum);
    if (isdefined(self.weapon.customsettings)) {
        var_966a1350 = getscriptbundle(self.weapon.customsettings);
        self.var_966a1350 = var_966a1350;
        if (isdefined(var_966a1350.var_b941081f) && isdefined(var_966a1350.var_40772cbe)) {
            self.light_fx = util::playfxontag(localclientnum, var_966a1350.var_b941081f, self, var_966a1350.var_40772cbe);
        }
    }
    if (self.owner == function_5c10bd79(localclientnum)) {
        self thread function_fab88840(localclientnum);
    }
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x4
// Checksum 0x77dc77d, Offset: 0x280
// Size: 0x5c
function private function_fab88840(localclientnum) {
    function_c6ab0456(localclientnum, 1, 1);
    self waittill(#"death");
    function_c6ab0456(localclientnum, 1, 0);
}

// Namespace satchel_charge/satchel_charge
// Params 7, eflags: 0x0
// Checksum 0xd19d7c95, Offset: 0x2e8
// Size: 0x14e
function function_e402bf2c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify("5ec15ced9ad90575");
    self endon("5ec15ced9ad90575");
    self endon(#"death");
    if (bwastimejump == 1) {
        self util::waittill_dobj(fieldname);
        if (isdefined(self.var_966a1350.var_b941081f) && isdefined(self.var_966a1350.var_40772cbe)) {
            while (isdefined(self)) {
                if (isdefined(self.light_fx)) {
                    stopfx(fieldname, self.light_fx);
                }
                level waittilltimeout(0.1, #"player_switch");
                self.light_fx = util::playfxontag(fieldname, self.var_966a1350.var_b941081f, self, self.var_966a1350.var_40772cbe);
            }
        }
    }
}

