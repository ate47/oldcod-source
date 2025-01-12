#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x6
// Checksum 0xe9fc7444, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"hash_2af3fdb587243686", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x5 linked
// Checksum 0x74dbfc5, Offset: 0x188
// Size: 0x8c
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.tactical", 1, 5, "float");
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.lethal", 1, 5, "float");
    callback::on_spawned(&on_player_spawned);
    level.var_b8e083d0 = &function_b8e083d0;
}

// Namespace perks/perks
// Params 1, eflags: 0x1 linked
// Checksum 0xa13daa2f, Offset: 0x220
// Size: 0xd4
function perk_setperk(str_perk) {
    if (!isdefined(self.var_fb3c9d6a)) {
        self.var_fb3c9d6a = [];
    }
    if (!isdefined(self.var_fb3c9d6a[str_perk])) {
        self.var_fb3c9d6a[str_perk] = 0;
    }
    assert(self.var_fb3c9d6a[str_perk] >= 0, "<dev string:x38>");
    assert(self.var_fb3c9d6a[str_perk] < 23, "<dev string:x53>");
    self.var_fb3c9d6a[str_perk]++;
    self setperk(str_perk);
}

// Namespace perks/perks
// Params 1, eflags: 0x1 linked
// Checksum 0xddf57d44, Offset: 0x300
// Size: 0xb4
function perk_unsetperk(str_perk) {
    if (!isdefined(self.var_fb3c9d6a)) {
        self.var_fb3c9d6a = [];
    }
    if (!isdefined(self.var_fb3c9d6a[str_perk])) {
        self.var_fb3c9d6a[str_perk] = 0;
    }
    self.var_fb3c9d6a[str_perk]--;
    assert(self.var_fb3c9d6a[str_perk] >= 0, "<dev string:x38>");
    if (self.var_fb3c9d6a[str_perk] <= 0) {
        self unsetperk(str_perk);
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x1 linked
// Checksum 0x75c2a07d, Offset: 0x3c0
// Size: 0x4a
function perk_hasperk(str_perk) {
    if (isdefined(self.var_fb3c9d6a) && isdefined(self.var_fb3c9d6a[str_perk]) && self.var_fb3c9d6a[str_perk] > 0) {
        return true;
    }
    return false;
}

// Namespace perks/perks
// Params 0, eflags: 0x1 linked
// Checksum 0xd6410b32, Offset: 0x418
// Size: 0x26
function perk_reset_all() {
    self clearperks();
    self.var_fb3c9d6a = [];
}

// Namespace perks/perks
// Params 0, eflags: 0x5 linked
// Checksum 0x3a860f64, Offset: 0x448
// Size: 0x44
function private on_player_spawned() {
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.lethal", 0);
}

// Namespace perks/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0xce790cf0, Offset: 0x498
// Size: 0x244
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    weapon = eventstruct.weapon;
    if (isplayer(self) && self hasperk("specialty_equipmentrecharge") && (weapon.offhandslot == "Lethal grenade" || weapon.offhandslot == "Tactical grenade")) {
        self endon(#"death");
        waittillframeend();
        if (is_true(eventstruct.projectile.throwback) || !isalive(self)) {
            return;
        }
        var_acddd81e = isdefined(weapon.var_7d4c12af) && weapon.var_7d4c12af != "None";
        var_e0ca50e9 = {#slot:weapon.offhandslot, #weapon:weapon, #var_acddd81e:var_acddd81e};
        if (!isdefined(self.var_7cedc725)) {
            self.var_7cedc725 = [];
        } else if (!isarray(self.var_7cedc725)) {
            self.var_7cedc725 = array(self.var_7cedc725);
        }
        self.var_7cedc725[self.var_7cedc725.size] = var_e0ca50e9;
        var_2b9b7c0f = var_e0ca50e9.slot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
        self clientfield::set_player_uimodel(var_2b9b7c0f, 0);
        if (self.var_7cedc725.size == 1) {
            self thread function_78976b52();
        }
    }
}

// Namespace perks/gadget_on
// Params 1, eflags: 0x44
// Checksum 0x81d1273c, Offset: 0x6e8
// Size: 0x1cc
function private event_handler[gadget_on] function_7d697841(eventstruct) {
    player = eventstruct.entity;
    weapon = eventstruct.weapon;
    if (isplayer(player) && player hasperk("specialty_equipmentrecharge") && weapon.name == #"hash_364914e1708cb629") {
        var_e0ca50e9 = {#slot:weapon.offhandslot, #weapon:weapon, #var_acddd81e:0};
        if (!isdefined(player.var_7cedc725)) {
            player.var_7cedc725 = [];
        } else if (!isarray(player.var_7cedc725)) {
            player.var_7cedc725 = array(player.var_7cedc725);
        }
        player.var_7cedc725[player.var_7cedc725.size] = var_e0ca50e9;
        var_2b9b7c0f = var_e0ca50e9.slot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
        player clientfield::set_player_uimodel(var_2b9b7c0f, 0);
        if (player.var_7cedc725.size == 1) {
            player thread function_78976b52();
        }
    }
}

// Namespace perks/perks
// Params 0, eflags: 0x5 linked
// Checksum 0x8f14ce69, Offset: 0x8c0
// Size: 0x1ee
function private function_78976b52() {
    self endoncallback(&function_4ed3bc25, #"death", #"resupply");
    offhandslot = self.var_7cedc725[0].slot;
    var_2b9b7c0f = offhandslot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    success = self function_691948bf(var_2b9b7c0f);
    if (is_true(success)) {
        arrayremoveindex(self.var_7cedc725, 0);
        if (offhandslot == "Lethal grenade") {
            currentoffhand = self function_826ed2dd();
        } else {
            currentoffhand = getweapon(self function_b958b70d(self.class_num, "secondarygrenade"));
        }
        currentcount = self getammocount(currentoffhand);
        if (currentcount < self function_b7f1fd2c(currentoffhand)) {
            self setweaponammoclip(currentoffhand, currentcount + 1);
        }
    }
    self clientfield::set_player_uimodel(var_2b9b7c0f, 0);
    if (self.var_7cedc725.size) {
        self thread function_78976b52();
        return;
    }
    self.var_7cedc725 = undefined;
}

// Namespace perks/perks
// Params 1, eflags: 0x5 linked
// Checksum 0x36688e5a, Offset: 0xab8
// Size: 0xf8
function private function_691948bf(var_2b9b7c0f) {
    self endon(#"hash_5c998eb8e3fcffe5");
    var_ac922159 = getdvarint(#"hash_3d104eb411be9f06", 30);
    elapsedtime = 0;
    starttime = gettime();
    while (elapsedtime < var_ac922159) {
        progress = elapsedtime / var_ac922159;
        self clientfield::set_player_uimodel(var_2b9b7c0f, progress);
        waitframe(1);
        elapsedtime = gettime() - starttime;
        elapsedtime = float(elapsedtime) / 1000;
    }
    self clientfield::set_player_uimodel(var_2b9b7c0f, 1);
    return true;
}

// Namespace perks/perks
// Params 1, eflags: 0x5 linked
// Checksum 0x1d8daa2f, Offset: 0xbb8
// Size: 0x96
function private function_b8e083d0(weapon) {
    if (isdefined(self.var_7cedc725)) {
        for (i = 0; i < self.var_7cedc725.size; i++) {
            if (weapon == self.var_7cedc725[i].weapon) {
                if (i == 0) {
                    self notify(#"hash_5c998eb8e3fcffe5");
                }
                arrayremoveindex(self.var_7cedc725, i);
                return;
            }
        }
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x5 linked
// Checksum 0x53d31901, Offset: 0xc58
// Size: 0x7e
function private function_4ed3bc25(*notifyhash) {
    offhandslot = self.var_7cedc725[0].slot;
    var_2b9b7c0f = offhandslot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    self clientfield::set_player_uimodel(var_2b9b7c0f, 0);
    self.var_7cedc725 = undefined;
}

