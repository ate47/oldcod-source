#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace field_upgrades;

// Namespace field_upgrades/field_upgrades
// Params 0, eflags: 0x6
// Checksum 0x17f10586, Offset: 0xf8
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"field_upgrades", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace field_upgrades/field_upgrades
// Params 0, eflags: 0x5 linked
// Checksum 0xe9f4f23c, Offset: 0x140
// Size: 0x9c
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.ammoCooldowns.fieldUpgrade", 1, 5, "float", 0);
    callback::on_connect(&function_39a250e3);
    callback::on_spawned(&function_c07346fe);
    clientfield::register("missile", "fieldUpgradeActive", 1, 1, "int");
}

// Namespace field_upgrades/field_upgrades
// Params 0, eflags: 0x5 linked
// Checksum 0x6057d36e, Offset: 0x1e8
// Size: 0x16c
function private function_c07346fe() {
    self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
    if (self.pers[#"fieldupgrades"][#"ammo"] > 0) {
        while (self isinfreefall() || self function_9a0edd92()) {
            waitframe(1);
        }
        if (isdefined(self)) {
            if (isdefined(self.pers[#"fieldupgrades"][#"hash_3e6d442adf0713fc"])) {
                weaponindex = getitemindexfromref(self.pers[#"fieldupgrades"][#"hash_3e6d442adf0713fc"].name);
                if (weaponindex != 0) {
                    self luinotifyevent(#"hash_14ebcb39234f4126", 1, weaponindex);
                }
            }
        }
    }
}

// Namespace field_upgrades/field_upgrades
// Params 0, eflags: 0x5 linked
// Checksum 0x6c336ee2, Offset: 0x360
// Size: 0x176
function private function_39a250e3() {
    if (!isdefined(self.pers[#"fieldupgrades"])) {
        self.pers[#"fieldupgrades"] = [];
    } else if (!isarray(self.pers[#"fieldupgrades"])) {
        self.pers[#"fieldupgrades"] = array(self.pers[#"fieldupgrades"]);
    }
    if (!isdefined(self.pers[#"fieldupgrades"][#"ammo"])) {
        self.pers[#"fieldupgrades"][#"ammo"] = 0;
    }
    if (isdefined(game.playabletimepassed) && game.playabletimepassed > 0) {
        self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"] = float(game.playabletimepassed) / 1000;
    }
}

// Namespace field_upgrades/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x36954e04, Offset: 0x4e0
// Size: 0x174
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (!isplayer(self)) {
        return;
    }
    weapon = eventstruct.weapon;
    if (function_62c1bfaa(weapon) && level.var_d89ef54a !== 1) {
        projectile = eventstruct.projectile;
        if (isdefined(projectile)) {
            projectile clientfield::set("fieldUpgradeActive", 1);
        }
        self.pers[#"fieldupgrades"][#"ammo"]--;
        self function_1326b4ce(self.pers[#"fieldupgrades"][#"ammo"]);
        self function_42ee343f(#"hash_1af96128a3b1b348", self.pers[#"fieldupgrades"][#"ammo"]);
        self thread function_e7085388(weapon);
    }
}

// Namespace field_upgrades/player_loadoutchanged
// Params 1, eflags: 0x44
// Checksum 0xdfe0cf3a, Offset: 0x660
// Size: 0xfc
function private event_handler[player_loadoutchanged] function_688d2014(eventstruct) {
    if (eventstruct.event != "give_weapon") {
        return;
    }
    weapon = eventstruct.weapon;
    if (function_62c1bfaa(weapon) && getgametypesetting(#"hash_2f0beae14bf17810") !== 1) {
        weaponindex = getitemindexfromref(weapon.name);
        self notify(#"hash_5e15609b9205fae8");
        self function_18afabb5(weaponindex);
        self function_42ee343f(#"hash_14ebcb39234f4126", weaponindex);
        self thread function_63ac35a3(weapon);
    }
}

// Namespace field_upgrades/field_upgrades
// Params 1, eflags: 0x5 linked
// Checksum 0x45b1b7d1, Offset: 0x768
// Size: 0x374
function private function_63ac35a3(weapon) {
    self notify(#"hash_36a1ce93b922198d");
    self endon(#"death", #"hash_36a1ce93b922198d");
    clipsize = self getweaponammoclipsize(weapon);
    if (self function_e3774219(weapon)) {
        self notify(#"switched_field_upgrade", {#var_51246a31:1});
        var_e3774219 = 1;
        var_cd27cff2 = 0;
    } else {
        var_cd27cff2 = int(min(self.pers[#"fieldupgrades"][#"ammo"], clipsize));
    }
    waitframe(1);
    if (!self hasweapon(weapon)) {
        return;
    }
    self setweaponammoclip(weapon, var_cd27cff2);
    /#
        if (getdvarint(#"hash_559c662aa3277aeb", 0)) {
            self setweaponammoclip(weapon, 0);
        }
    #/
    if (self getweaponammoclip(weapon) >= clipsize) {
        self notify(#"hash_50ce27022d3b38c");
        self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 0);
        self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = undefined;
        return;
    }
    var_d6dbd305 = 0;
    while (level.inprematchperiod || !self.hasspawned) {
        if (!var_d6dbd305) {
            var_d6dbd305 = 1;
            if (isdefined(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"])) {
                if (self hasperk(#"hash_46e52ae259ccc1e1")) {
                    var_cdd95e58 = 1;
                }
                cooldown = function_e7967fc8(weapon, var_cdd95e58);
                self function_f6621fe5(int(cooldown));
                progress = self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] / cooldown;
                self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", progress);
            }
        }
        waitframe(1);
    }
    self thread function_e7085388(weapon, var_e3774219);
}

// Namespace field_upgrades/field_upgrades
// Params 2, eflags: 0x5 linked
// Checksum 0x5010a5bc, Offset: 0xae8
// Size: 0x85c
function private function_e7085388(weapon, var_e3774219 = 0) {
    self notify(#"hash_50ce27022d3b38c");
    self endon(#"disconnect", #"hash_50ce27022d3b38c", #"round_ended");
    var_4dcb7b2e = self.pers[#"fieldupgrades"][#"hash_1f9e227d7c859634"];
    if (self hasperk(#"hash_46e52ae259ccc1e1")) {
        var_cdd95e58 = 1;
        self.pers[#"fieldupgrades"][#"hash_1f9e227d7c859634"] = 1;
    } else {
        self.pers[#"fieldupgrades"][#"hash_1f9e227d7c859634"] = undefined;
    }
    previousweapon = self.pers[#"fieldupgrades"][#"hash_3e6d442adf0713fc"];
    self.pers[#"fieldupgrades"][#"hash_3e6d442adf0713fc"] = weapon;
    clipsize = self getweaponammoclipsize(weapon);
    cooldown = function_e7967fc8(weapon, var_cdd95e58);
    self function_f6621fe5(int(cooldown));
    if (var_e3774219 || isdefined(self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"])) {
        if (var_e3774219) {
            var_d3239b6b = function_e7967fc8(previousweapon, var_4dcb7b2e);
            var_1b634dac = self.pers[#"fieldupgrades"][#"ammo"] * var_d3239b6b;
            if (isdefined(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"])) {
                var_1b634dac += self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"];
            }
        } else {
            var_1b634dac = self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"];
            self.pers[#"fieldupgrades"][#"hash_32a0670ee5dfa2cc"] = undefined;
        }
        var_e42bf9b2 = int(min(clipsize, floor(var_1b634dac / cooldown)));
        self setweaponammoclip(weapon, var_e42bf9b2);
        self.pers[#"fieldupgrades"][#"ammo"] = var_e42bf9b2;
        if (var_e42bf9b2 < clipsize) {
            self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = var_1b634dac - var_e42bf9b2 * cooldown;
        } else {
            self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 0);
            self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = undefined;
            return;
        }
    }
    elapsedtime = isdefined(self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"]) ? self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] : 0;
    if (is_true(var_cdd95e58) && !is_true(var_4dcb7b2e)) {
        elapsedtime *= 0.75;
    }
    var_9d2ffe1e = int(floor(elapsedtime));
    self function_cfb0d7cc(var_9d2ffe1e);
    while (elapsedtime < cooldown) {
        progress = elapsedtime / cooldown;
        self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", progress);
        if (var_9d2ffe1e < int(floor(elapsedtime))) {
            var_9d2ffe1e = int(floor(elapsedtime));
            self function_cfb0d7cc(var_9d2ffe1e);
        }
        waitframe(1);
        elapsedtime += float(function_60d95f53()) / 1000;
        self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = elapsedtime;
    }
    self function_cfb0d7cc(int(floor(elapsedtime)));
    self.pers[#"fieldupgrades"][#"ammo"]++;
    self function_1326b4ce(self.pers[#"fieldupgrades"][#"ammo"]);
    if (isalive(self) && self hasweapon(weapon)) {
        self setweaponammoclip(weapon, self.pers[#"fieldupgrades"][#"ammo"]);
    }
    self.pers[#"fieldupgrades"][#"hash_67e7b008344d0e5e"] = undefined;
    weaponindex = getitemindexfromref(weapon.name);
    self luinotifyevent(#"hash_14ebcb39234f4126", 1, weaponindex);
    if (self getweaponammoclip(weapon) < clipsize) {
        self thread function_e7085388(weapon);
        return;
    }
    self clientfield::set_player_uimodel("hudItems.ammoCooldowns.fieldUpgrade", 0);
}

// Namespace field_upgrades/field_upgrades
// Params 2, eflags: 0x5 linked
// Checksum 0xe9cfd325, Offset: 0x1350
// Size: 0xbc
function private function_e7967fc8(weapon, var_cdd95e58 = 0) {
    cooldown = weapon.var_2adfbb2f;
    if (cooldown <= 0) {
        cooldown = 60;
    }
    /#
        if (getdvarint(#"hash_ecac33069a44354", 0)) {
            cooldown = getdvarint(#"hash_ecac33069a44354", 0);
        }
    #/
    if (var_cdd95e58) {
        cooldown *= 0.75;
    }
    return cooldown;
}

// Namespace field_upgrades/field_upgrades
// Params 1, eflags: 0x5 linked
// Checksum 0x33cc8c83, Offset: 0x1418
// Size: 0x3a
function private function_62c1bfaa(weapon) {
    return weapon.offhandslot == "Special" && weapon.inventorytype == "ability";
}

// Namespace field_upgrades/field_upgrades
// Params 1, eflags: 0x5 linked
// Checksum 0xe9aba46c, Offset: 0x1460
// Size: 0x52
function private function_e3774219(weapon) {
    previousweapon = self.pers[#"fieldupgrades"][#"hash_3e6d442adf0713fc"];
    return isdefined(previousweapon) && previousweapon != weapon;
}

// Namespace field_upgrades/field_upgrades
// Params 2, eflags: 0x5 linked
// Checksum 0xacd5df59, Offset: 0x14c0
// Size: 0x3c
function private function_42ee343f(eventstring, data) {
    self function_8ba40d2f(eventstring, 2, self.clientid, data);
}

