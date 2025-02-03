#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace armor_carrier;

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x6
// Checksum 0x572b327e, Offset: 0xb8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"armor_carrier", &preinit, undefined, undefined, undefined);
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0x1cf2bee8, Offset: 0x100
// Size: 0xe4
function private preinit() {
    clientfield::register_clientuimodel("hudItems.armorPlateCount", #"hud_items", #"hash_7c65108f5dcd93ef", 1, 4, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.armorPlateMaxCarry", #"hud_items", #"hash_6260c609342f556d", 1, 4, "int", undefined, 0, 0);
    level.var_a05cd64e = &function_a05cd64e;
    level.var_8ef8b9e8 = getweapon(#"armor_plate");
}

// Namespace armor_carrier/armor_carrier
// Params 1, eflags: 0x4
// Checksum 0xfcf5e047, Offset: 0x1f0
// Size: 0x4c
function private function_a05cd64e(localclientnum) {
    if (self function_86b9a404()) {
        switchtoweapon(localclientnum, level.var_8ef8b9e8);
        return true;
    }
    return false;
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0xcf30cfa1, Offset: 0x248
// Size: 0x1a4
function private function_86b9a404() {
    if (!isplayer(self) || self isplayerdead()) {
        return false;
    }
    localclientnum = self getlocalclientnumber();
    if (!isdefined(localclientnum)) {
        return false;
    }
    if (isonturret(localclientnum) || self function_94ba7a2e() || self function_9a0edd92() || self isinfreefall()) {
        return false;
    }
    if (isdefined(getplayervehicle(self))) {
        if (getcurrentweapon(localclientnum) === level.weaponnone || self function_3feb54c8(localclientnum)) {
            return false;
        }
    }
    var_6aae821e = hasweapon(localclientnum, level.var_8ef8b9e8);
    currentcount = self clientfield::get_player_uimodel("hudItems.armorPlateCount");
    return currentcount > 0 && self getplayerarmor() < 225 && var_6aae821e;
}

