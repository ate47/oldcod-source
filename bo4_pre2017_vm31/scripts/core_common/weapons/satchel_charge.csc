#using scripts/core_common/callbacks_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x0
// Checksum 0x878aa9fd, Offset: 0x1d0
// Size: 0x74
function init_shared(localclientnum) {
    level._effect["satchel_charge_enemy_light"] = "weapon/fx_c4_light_orng";
    level._effect["satchel_charge_friendly_light"] = "weapon/fx_c4_light_blue";
    callback::add_weapon_type("satchel_charge", &function_dcd6d73e);
}

// Namespace satchel_charge/satchel_charge
// Params 1, eflags: 0x0
// Checksum 0xf9403a09, Offset: 0x250
// Size: 0x9c
function function_dcd6d73e(localclientnum) {
    self endon(#"death");
    if (self isgrenadedud()) {
        return;
    }
    self.equipmentfriendfx = level._effect["satchel_charge_friendly_light"];
    self.equipmentenemyfx = level._effect["satchel_charge_enemy_light"];
    self.equipmenttagfx = "tag_origin";
    self thread weaponobjects::equipmentteamobject(localclientnum);
}

