#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x31de00e9, Offset: 0xd8
// Size: 0x84
function init_shared(*localclientnum) {
    callback::add_weapon_type(#"satchel_charge", &function_34e248b6);
    clientfield::register("missile", "satchelChargeWarning", 1, 1, "int", &function_e402bf2c, 0, 0);
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x1 linked
// Checksum 0x4a6dd902, Offset: 0x168
// Size: 0xbc
function function_34e248b6(localclientnum) {
    self endon(#"death");
    if (self isgrenadedud()) {
        return;
    }
    self.equipmentfriendfx = #"weapon/fx_c4_light_blue";
    self.equipmentenemyfx = #"weapon/fx_c4_light_orng";
    self.var_7701a848 = "tag_origin";
    self thread weaponobjects::equipmentteamobject(localclientnum);
    if (self.owner == function_5c10bd79(localclientnum)) {
        self thread function_fab88840(localclientnum);
    }
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x5 linked
// Checksum 0xba294743, Offset: 0x230
// Size: 0x5c
function private function_fab88840(localclientnum) {
    function_c6ab0456(localclientnum, 1, 1);
    self waittill(#"death");
    function_c6ab0456(localclientnum, 1, 0);
}

// Namespace satchel_charge/satchel_charge
// Params 7, eflags: 0x1 linked
// Checksum 0x6a47c432, Offset: 0x298
// Size: 0x1b2
function function_e402bf2c(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self notify("7f462336c290299c");
    self endon("7f462336c290299c");
    self endon(#"death");
    if (bwastimejump == 1) {
        interval = 0.3;
        self util::waittill_dobj(fieldname);
        if (isdefined(self.weapon.customsettings)) {
            var_966a1350 = getscriptbundle(self.weapon.customsettings);
            if (isdefined(var_966a1350.var_b941081f) && isdefined(var_966a1350.var_40772cbe)) {
                while (isdefined(self)) {
                    self.fx = util::playfxontag(fieldname, var_966a1350.var_b941081f, self, var_966a1350.var_40772cbe);
                    level waittilltimeout(interval, #"player_switch");
                    stopfx(fieldname, self.fx);
                    interval = math::clamp(interval / 1.2, 0.08, 0.3);
                }
            }
        }
    }
}

