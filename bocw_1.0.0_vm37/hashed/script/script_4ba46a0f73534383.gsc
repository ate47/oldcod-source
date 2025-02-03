#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\weapons\weapons;

#namespace armor_carrier;

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x6
// Checksum 0xac9cc966, Offset: 0xd8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"armor_carrier", &preinit, undefined, &finalize, undefined);
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0x546bc07e, Offset: 0x128
// Size: 0xcc
function private preinit() {
    level.var_8ef8b9e8 = getweapon(#"armor_plate");
    clientfield::register_clientuimodel("hudItems.armorPlateCount", 1, 4, "int");
    clientfield::register_clientuimodel("hudItems.armorPlateMaxCarry", 1, 4, "int");
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"on_loadout", &on_player_loadout);
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0x91dbb658, Offset: 0x200
// Size: 0x34
function private finalize() {
    item_world::function_861f348d(#"generic_pickup", &function_e74225a7);
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0x7c888d1f, Offset: 0x240
// Size: 0x64
function private on_player_spawned() {
    self.var_7d7d976a = 0;
    self.var_c52363ab = 5;
    self clientfield::set_player_uimodel("hudItems.armorPlateCount", self.var_7d7d976a);
    self clientfield::set_player_uimodel("hudItems.armorPlateMaxCarry", self.var_c52363ab);
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0x73885d3d, Offset: 0x2b0
// Size: 0x1a4
function private on_player_loadout() {
    self giveweapon(level.var_8ef8b9e8);
    self lockweapon(level.var_8ef8b9e8, 1, 1);
    if (is_true(getgametypesetting(#"hash_5700fdc9d17186f7"))) {
        self armor::set_armor(225, 225, 3, 0.4, 1, 0.5, 0, 1, 1, 1);
        return;
    }
    if ((isdefined(getgametypesetting(#"hash_64f2892e3a0fd0b")) ? getgametypesetting(#"hash_64f2892e3a0fd0b") : 0) > 0) {
        self armor::set_armor(getgametypesetting(#"hash_64f2892e3a0fd0b") * 75, 225, 3, 0.4, 1, 0.5, 0, 1, 1, 1);
    }
}

// Namespace armor_carrier/armor_carrier
// Params 7, eflags: 0x4
// Checksum 0xbb008b89, Offset: 0x460
// Size: 0xf0
function private function_e74225a7(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, *slot) {
    if (itemcount.itementry.itemtype == #"armor_shard") {
        var_82da4e0 = int(min(slot, self.var_c52363ab - var_aec6fa7f.var_7d7d976a));
        var_aec6fa7f.var_7d7d976a += var_82da4e0;
        var_aec6fa7f clientfield::set_player_uimodel("hudItems.armorPlateCount", var_aec6fa7f.var_7d7d976a);
        return (slot - var_82da4e0);
    }
    return slot;
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0xd9219c4b, Offset: 0x558
// Size: 0xc2
function private function_86b9a404() {
    if (self isonladder() || self function_b4813488() || self inlaststand() || self isparachuting() || self isinfreefall() || self isskydiving()) {
        return false;
    }
    return self.var_7d7d976a > 0 && armor::get_armor() < 225;
}

// Namespace armor_carrier/armor_carrier
// Params 1, eflags: 0x0
// Checksum 0x7c298417, Offset: 0x628
// Size: 0x84
function function_e12c220a(var_16888a24) {
    assert(isplayer(self));
    if (!isplayer(self)) {
        return;
    }
    self.var_c52363ab = var_16888a24;
    self clientfield::set_player_uimodel("hudItems.armorPlateMaxCarry", self.var_c52363ab);
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0xc533cc66, Offset: 0x6b8
// Size: 0x114
function private function_d66636df() {
    if (function_86b9a404()) {
        self.var_7d7d976a -= 1;
        self clientfield::set_player_uimodel("hudItems.armorPlateCount", self.var_7d7d976a);
        var_8b8faf32 = armor::get_armor();
        var_3d557ef9 = var_8b8faf32 + 75;
        var_3d557ef9 = int(min(var_3d557ef9, 225));
        self armor::set_armor(var_3d557ef9, 225, 3, 0.4, 1, 0.5, 0, 1, 1, 1);
        return true;
    }
    return false;
}

// Namespace armor_carrier/armor_carrier
// Params 1, eflags: 0x4
// Checksum 0x9f73eae8, Offset: 0x7d8
// Size: 0x2d4
function private function_a7879258(lastweapon) {
    self endon(#"disconnect");
    if (self getcurrentweapon() === level.var_8ef8b9e8 && !self isswitchingweapons()) {
        self weapons::function_d571ac59(lastweapon);
        return;
    }
    waitresult = self waittilltimeout(2, #"weapon_change_complete", #"death", #"enter_vehicle", #"exit_vehicle");
    if (waitresult._notify !== #"weapon_change_complete") {
        self weapons::function_d571ac59(lastweapon);
        return;
    }
    if (self getcurrentweapon() === level.var_8ef8b9e8) {
        self thread function_c81e4a7c();
        self.var_6a0f2dd7 = 0;
        for (;;) {
            if (!function_86b9a404() || self.var_32b4a72a === 1 && self.var_6a0f2dd7) {
                self weapons::function_d571ac59(lastweapon);
                return;
            }
            waitresult = self waittilltimeout(1.2, #"death", #"enter_vehicle", #"exit_vehicle");
            if (waitresult._notify !== #"timeout") {
                self weapons::function_d571ac59(lastweapon);
                return;
            }
            if (self getcurrentweapon() !== level.var_8ef8b9e8 || self isdroppingweapon()) {
                break;
            }
            if (function_d66636df()) {
                self.var_6a0f2dd7 = 1;
            }
        }
    } else {
        return;
    }
    currentweapon = self getcurrentweapon();
    if (currentweapon === level.var_8ef8b9e8 || currentweapon === level.weaponnone) {
        self weapons::function_d571ac59(lastweapon);
    }
}

// Namespace armor_carrier/armor_carrier
// Params 0, eflags: 0x4
// Checksum 0xb5be9dfb, Offset: 0xab8
// Size: 0xba
function private function_c81e4a7c() {
    self endon(#"disconnect");
    self.var_32b4a72a = 0;
    while (isalive(self) && (self weaponswitchbuttonpressed() || self function_315b0f70()) && self getcurrentweapon() === level.var_8ef8b9e8 && !self isdroppingweapon()) {
        waitframe(1);
    }
    self.var_32b4a72a = 1;
}

// Namespace armor_carrier/weapon_change
// Params 1, eflags: 0x40
// Checksum 0xa2f79454, Offset: 0xb80
// Size: 0x44
function event_handler[weapon_change] function_62befac0(eventstruct) {
    if (eventstruct.weapon === level.var_8ef8b9e8) {
        self thread function_a7879258(eventstruct.last_weapon);
    }
}

