#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

// Namespace perks/perks
// Params 0, eflags: 0x6
// Checksum 0x20c49e8a, Offset: 0x140
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"perks_shared", &preinit, undefined, undefined, undefined);
}

// Namespace perks/perks
// Params 0, eflags: 0x4
// Checksum 0xa7c267f7, Offset: 0x188
// Size: 0x8c
function private preinit() {
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.tactical", 1, 5, "float");
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.lethal", 1, 5, "float");
    callback::on_spawned(&on_player_spawned);
    level.var_b8e083d0 = &function_b8e083d0;
}

// Namespace perks/perks
// Params 1, eflags: 0x0
// Checksum 0x4affdd5e, Offset: 0x220
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
// Params 1, eflags: 0x0
// Checksum 0xb01abb2b, Offset: 0x300
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
// Params 1, eflags: 0x0
// Checksum 0xef17ee74, Offset: 0x3c0
// Size: 0x4a
function perk_hasperk(str_perk) {
    if (isdefined(self.var_fb3c9d6a) && isdefined(self.var_fb3c9d6a[str_perk]) && self.var_fb3c9d6a[str_perk] > 0) {
        return true;
    }
    return false;
}

// Namespace perks/perks
// Params 0, eflags: 0x0
// Checksum 0xb1148998, Offset: 0x418
// Size: 0x26
function perk_reset_all() {
    self clearperks();
    self.var_fb3c9d6a = [];
}

// Namespace perks/perks
// Params 0, eflags: 0x4
// Checksum 0x1260b400, Offset: 0x448
// Size: 0x44
function private on_player_spawned() {
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.lethal", 0);
}

// Namespace perks/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x78df0c82, Offset: 0x498
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
        cf = var_e0ca50e9.slot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
        self clientfield::set_player_uimodel(cf, 0);
        if (self.var_7cedc725.size == 1) {
            self thread function_78976b52();
        }
    }
}

// Namespace perks/gadget_on
// Params 1, eflags: 0x44
// Checksum 0x4bd0a8ab, Offset: 0x6e8
// Size: 0x224
function private event_handler[gadget_on] function_7d697841(eventstruct) {
    player = eventstruct.entity;
    weapon = eventstruct.weapon;
    if (level.var_222e62a6 === 1) {
        if (isplayer(player) && weapon.name == #"hash_364914e1708cb629") {
            player thread function_845e1139();
        }
        return;
    }
    if (isplayer(player) && player hasperk("specialty_equipmentrecharge") && weapon.name == #"hash_364914e1708cb629") {
        var_e0ca50e9 = {#slot:weapon.offhandslot, #weapon:weapon, #var_acddd81e:0};
        if (!isdefined(player.var_7cedc725)) {
            player.var_7cedc725 = [];
        } else if (!isarray(player.var_7cedc725)) {
            player.var_7cedc725 = array(player.var_7cedc725);
        }
        player.var_7cedc725[player.var_7cedc725.size] = var_e0ca50e9;
        cf = var_e0ca50e9.slot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
        player clientfield::set_player_uimodel(cf, 0);
        if (player.var_7cedc725.size == 1) {
            player thread function_78976b52();
        }
    }
}

// Namespace perks/perks
// Params 0, eflags: 0x4
// Checksum 0xe73bdc13, Offset: 0x918
// Size: 0x16c
function private function_845e1139() {
    self endoncallback(&function_c2b5717d, #"death", #"resupply");
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
    success = self function_e5f5216f("hudItems.ammoCooldowns.equipment.tactical");
    if (is_true(success)) {
        currentoffhand = getweapon(self function_b958b70d(self.class_num, "secondarygrenade"));
        if (self hasweapon(currentoffhand)) {
            currentcount = self getammocount(currentoffhand);
            if (currentcount < self function_b7f1fd2c(currentoffhand)) {
                self setweaponammoclip(currentoffhand, currentcount + 1);
            }
        }
    }
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
}

// Namespace perks/perks
// Params 0, eflags: 0x4
// Checksum 0x47144d98, Offset: 0xa90
// Size: 0x206
function private function_78976b52() {
    self endoncallback(&function_4ed3bc25, #"death", #"resupply");
    offhandslot = self.var_7cedc725[0].slot;
    cf = offhandslot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    success = self function_691948bf(cf);
    if (is_true(success)) {
        arrayremoveindex(self.var_7cedc725, 0);
        if (offhandslot == "Lethal grenade") {
            currentoffhand = self function_826ed2dd();
        } else {
            currentoffhand = getweapon(self function_b958b70d(self.class_num, "secondarygrenade"));
        }
        if (self hasweapon(currentoffhand)) {
            currentcount = self getammocount(currentoffhand);
            if (currentcount < self function_b7f1fd2c(currentoffhand)) {
                self setweaponammoclip(currentoffhand, currentcount + 1);
            }
        }
    }
    self clientfield::set_player_uimodel(cf, 0);
    if (self.var_7cedc725.size) {
        self thread function_78976b52();
        return;
    }
    self.var_7cedc725 = undefined;
}

// Namespace perks/perks
// Params 1, eflags: 0x4
// Checksum 0x5f6ae654, Offset: 0xca0
// Size: 0x100
function private function_e5f5216f(cf) {
    rechargetime = getdvarint(#"hash_72fe00ba2b98e139", 8);
    elapsedtime = 0;
    starttime = gettime();
    while (elapsedtime < rechargetime) {
        progress = elapsedtime / rechargetime;
        self clientfield::set_player_uimodel(cf, progress);
        waitframe(1);
        elapsedtime = float(gettime() - starttime) / 1000;
    }
    self playsoundtoplayer(#"hash_23df0ddc8d4048a2", self);
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 1);
    return true;
}

// Namespace perks/perks
// Params 1, eflags: 0x4
// Checksum 0x56742089, Offset: 0xda8
// Size: 0x150
function private function_691948bf(cf) {
    self endon(#"hash_5c998eb8e3fcffe5");
    rechargetime = getdvarint(#"hash_3d104eb411be9f06", 25);
    elapsedtime = 0;
    starttime = gettime();
    while (elapsedtime < rechargetime) {
        progress = elapsedtime / rechargetime;
        self clientfield::set_player_uimodel(cf, progress);
        waitframe(1);
        elapsedtime = gettime() - starttime;
        elapsedtime = float(elapsedtime) / 1000;
    }
    sound = cf == "hudItems.ammoCooldowns.equipment.lethal" ? #"hash_6d4b6b0490117874" : #"hash_23df0ddc8d4048a2";
    self playsoundtoplayer(sound, self);
    self clientfield::set_player_uimodel(cf, 1);
    return true;
}

// Namespace perks/perks
// Params 1, eflags: 0x4
// Checksum 0x69ee7b55, Offset: 0xf00
// Size: 0xfe
function private function_b8e083d0(weapon) {
    if (isdefined(self.var_7cedc725)) {
        for (i = 0; i < self.var_7cedc725.size; i++) {
            if (weapon == self.var_7cedc725[i].weapon) {
                if (i == 0) {
                    if (self.var_7cedc725.size > 1) {
                        for (j = 1; j < self.var_7cedc725.size; j++) {
                            if (weapon == self.var_7cedc725[j].weapon) {
                                arrayremoveindex(self.var_7cedc725, j);
                                return;
                            }
                        }
                    }
                    self notify(#"hash_5c998eb8e3fcffe5");
                }
                arrayremoveindex(self.var_7cedc725, i);
                return;
            }
        }
    }
}

// Namespace perks/perks
// Params 1, eflags: 0x4
// Checksum 0x4ce5b147, Offset: 0x1008
// Size: 0x7e
function private function_4ed3bc25(*notifyhash) {
    offhandslot = self.var_7cedc725[0].slot;
    cf = offhandslot == "Lethal grenade" ? "hudItems.ammoCooldowns.equipment.lethal" : "hudItems.ammoCooldowns.equipment.tactical";
    self clientfield::set_player_uimodel(cf, 0);
    self.var_7cedc725 = undefined;
}

// Namespace perks/perks
// Params 1, eflags: 0x4
// Checksum 0x43f3b053, Offset: 0x1090
// Size: 0x2c
function private function_c2b5717d(*notifyhash) {
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.equipment.tactical", 0);
}

