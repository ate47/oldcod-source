#using scripts\abilities\ability_player;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\armor;
#using scripts\mp_common\item_drop;
#using scripts\mp_common\item_inventory_util;
#using scripts\mp_common\item_world;
#using scripts\mp_common\item_world_util;
#using scripts\mp_common\player\player_loadout;

#namespace item_inventory;

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x2
// Checksum 0x6d5f73ae, Offset: 0x1a8
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"item_inventory", &__init__, undefined, #"item_world");
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x36264f97, Offset: 0x1f8
// Size: 0x134
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    level.var_1d70db78 = &function_3fa86227;
    level.var_6ba3c5f4 = &function_ed20c165;
    clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 1, 2, "int");
    ability_player::register_gadget_activation_callbacks(23, &_gadget_health_regen_on, &_gadget_health_regen_off);
    ability_player::register_gadget_primed_callbacks(23, &function_8ee568a1);
    level.var_f4a0626e = &function_13acf61b;
    level thread function_c1b03b5();
}

// Namespace item_inventory/event_b2899454
// Params 1, eflags: 0x44
// Checksum 0xfd5041a1, Offset: 0x338
// Size: 0x118
function private event_handler[event_b2899454] function_47c92724(eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(self) && isalive(self)) {
        var_a8951def = array(#"ability_smart_cover", #"eq_concertina_wire");
        foreach (equipmentname in var_a8951def) {
            if (eventstruct.weapon.name == equipmentname) {
                self.var_9c888de5 = 1;
                return;
            }
        }
    }
}

// Namespace item_inventory/weapon_change
// Params 1, eflags: 0x44
// Checksum 0xbef4b00f, Offset: 0x458
// Size: 0x2c4
function private event_handler[weapon_change] function_7c63eb83(eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(self) && isalive(self)) {
        if (isdefined(self.var_ef350cec)) {
            if (eventstruct.last_weapon.name == #"none" && eventstruct.weapon.name != #"none") {
                self.var_ef350cec = undefined;
            }
        }
        if (isdefined(self.var_27445a8d)) {
            if (eventstruct.last_weapon.name == #"none" && eventstruct.weapon.name != #"none") {
                weaponname = self.var_27445a8d;
                self.var_27445a8d = undefined;
                var_a8951def = array(#"ability_smart_cover", #"eq_concertina_wire");
                foreach (equipmentname in var_a8951def) {
                    if (equipmentname != weaponname) {
                        continue;
                    }
                    if (!(isdefined(self.var_9c888de5) && self.var_9c888de5)) {
                        return;
                    }
                }
                self.var_9c888de5 = undefined;
                weapon = getweapon(weaponname);
                networkid = self function_a1333a2b(weapon);
                if (networkid == 32767) {
                    return;
                }
                item = self get_inventory_item(networkid);
                self use_inventory_item(networkid, 1, 0);
                if (isdefined(item) && item.count > 0) {
                    self function_6670c3ed(item, weapon, item.count);
                }
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xce8508d0, Offset: 0x728
// Size: 0x64
function function_13acf61b() {
    networkid = self.inventory.items[10].networkid;
    if (isdefined(networkid) && networkid != 32767) {
        self thread use_inventory_item(networkid, 1, 0);
    }
}

// Namespace item_inventory/gadget_primed
// Params 1, eflags: 0x40
// Checksum 0x225dd287, Offset: 0x798
// Size: 0x140
function event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(eventstruct.entity) && isalive(eventstruct.entity)) {
        var_56041cf8 = array(#"ability_smart_cover", #"eq_concertina_wire", #"cymbal_monkey");
        foreach (equipmentname in var_56041cf8) {
            if (eventstruct.weapon.name == equipmentname) {
                eventstruct.entity.var_ef350cec = equipmentname;
                return;
            }
        }
    }
}

// Namespace item_inventory/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x9af4504a, Offset: 0x8e0
// Size: 0x3d2
function private event_handler[grenade_fire] function_649f6cc1(eventstruct) {
    if (sessionmodeiswarzonegame() && isplayer(self) && isalive(self)) {
        var_5fa184c6 = 0;
        var_2b96e6f7 = array(#"eq_tripwire", #"ability_smart_cover", #"eq_concertina_wire", #"cymbal_monkey");
        foreach (equipmentname in var_2b96e6f7) {
            if (eventstruct.weapon.name == equipmentname) {
                self.var_27445a8d = equipmentname;
                var_5fa184c6 = 1;
                break;
            }
        }
        if (!var_5fa184c6) {
            networkid = self function_a1333a2b(eventstruct.weapon);
            if (networkid != 32767) {
                self use_inventory_item(networkid);
            }
        }
        weaponname = eventstruct.weapon.name;
        if (weaponname == #"hatchet" || weaponname == #"basketball" || weaponname == #"cymbal_monkey") {
            if (isdefined(eventstruct.projectile)) {
                dropitem = eventstruct.projectile;
                if (weaponname == #"basketball") {
                    dropitem endon(#"death");
                    dropitem waittill(#"stationary");
                }
                if (weaponname == #"cymbal_monkey") {
                    waitframe(1);
                    dropitem = dropitem.mdl_monkey;
                }
                if (!isdefined(dropitem)) {
                    return;
                }
                itemspawnpoint = function_a0be0611(weaponname);
                if (!isdefined(itemspawnpoint)) {
                    return;
                }
                dropitem.id = itemspawnpoint.id;
                dropitem.networkid = item_world_util::function_4dec3654(dropitem);
                dropitem.itementry = itemspawnpoint.itementry;
                dropitem.hidetime = 0;
                dropitem.amount = eventstruct.weapon.name == #"basketball" ? 1 : 0;
                dropitem.count = 1;
                dropitem clientfield::set("dynamic_item_drop", 1);
                dropitem function_5d3f60ae(dropitem.id);
                level.item_spawn_drops[dropitem.networkid] = dropitem;
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x4a09b97e, Offset: 0xcc0
// Size: 0xac
function private function_3fa86227() {
    if (isplayer(self) && isdefined(self.inventory)) {
        inventoryitem = self.inventory.items[11];
        if (inventoryitem.networkid != 32767 && inventoryitem.itementry.itemtype == #"armor") {
            self remove_inventory_item(inventoryitem.networkid);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x1ccc7837, Offset: 0xd78
// Size: 0xdc
function private function_ed20c165() {
    if (isplayer(self) && isdefined(self.inventory)) {
        inventoryitem = self.inventory.items[11];
        if (inventoryitem.networkid != 32767 && inventoryitem.itementry.itemtype == #"armor") {
            inventoryitem.amount = armor::get_armor();
            if (function_6d72f623(inventoryitem)) {
                self setperk(#"specialty_damaged_armor");
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x4
// Checksum 0x47a33905, Offset: 0xe60
// Size: 0x2cc
function private function_cabc57b0(itemtype, prioritylist, var_3d6b374f = undefined) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    assert(isarray(prioritylist));
    items = [];
    var_65a9c842 = item_world_util::get_itemtype(var_3d6b374f);
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_c9531505 = item_world_util::get_itemtype(item.itementry);
        if (var_65a9c842 === var_c9531505) {
            return item;
        }
        if (item.itementry.itemtype == itemtype) {
            if (isdefined(items[var_c9531505])) {
                if (item.count > items[var_c9531505].count) {
                    items[var_c9531505] = item;
                }
                continue;
            }
            items[var_c9531505] = item;
        }
    }
    foreach (var_c9531505 in prioritylist) {
        if (isdefined(items[var_c9531505])) {
            return items[var_c9531505];
        }
    }
    foreach (item in items) {
        if (isdefined(item)) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xdc03e239, Offset: 0x1138
// Size: 0x1c4
function private function_e906fda8(var_3d6b374f = undefined) {
    assert(isplayer(self));
    item = function_cabc57b0(#"equipment", array(#"frag_grenade_wz_item", #"cluster_semtex_wz_item", #"molotov_wz_item", #"hatchet_wz_item", #"seeker_mine_wz_item", #"swat_grenade_wz_item", #"concussion_wz_item", #"smoke_grenade_wz_item", #"grapple_wz_item", #"barricade_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item"), var_3d6b374f);
    if (isdefined(item)) {
        equip_equipment(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x6a0efe1f, Offset: 0x1308
// Size: 0xb4
function private function_d651bb57(var_3d6b374f = undefined) {
    assert(isplayer(self));
    item = function_cabc57b0(#"backpack", array(#"hash_7c3701ba5f0879c2"), var_3d6b374f);
    if (isdefined(item)) {
        equip_backpack(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x67d4fa4, Offset: 0x13c8
// Size: 0xd4
function private function_c8cce2aa(var_3d6b374f = undefined) {
    assert(isplayer(self));
    item = function_cabc57b0(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large"), var_3d6b374f);
    if (isdefined(item)) {
        equip_health(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x29de077, Offset: 0x14a8
// Size: 0x12a
function private function_4fc74b3(itemtype, var_3d6b374f = undefined) {
    assert(isplayer(self));
    assert(isstring(itemtype) || ishash(itemtype));
    switch (itemtype) {
    case #"backpack":
        function_d651bb57(var_3d6b374f);
        break;
    case #"equipment":
        function_e906fda8(var_3d6b374f);
        break;
    case #"health":
        function_c8cce2aa(var_3d6b374f);
        break;
    default:
        break;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x8c16f440, Offset: 0x15e0
// Size: 0xbc
function private function_a0be0611(equipment) {
    var_c9531505 = undefined;
    switch (equipment) {
    case #"hatchet":
        var_c9531505 = #"hatchet_wz_item";
        break;
    case #"basketball":
        var_c9531505 = #"wz_ball";
        break;
    case #"cymbal_monkey":
        var_c9531505 = #"cymbal_monkey_wz_item";
        break;
    }
    if (isdefined(var_c9531505)) {
        return function_a5758930(var_c9531505);
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x26b9f535, Offset: 0x16a8
// Size: 0x72
function private function_714e3fcb() {
    item = spawnstruct();
    item.amount = 0;
    item.count = 0;
    item.id = 32767;
    item.networkid = 32767;
    item.itementry = undefined;
    item.var_3e4720d3 = undefined;
    return item;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x56c348c4, Offset: 0x1728
// Size: 0x60
function private function_6d72f623(inventoryitem) {
    if (!isdefined(inventoryitem.amount)) {
        return false;
    }
    if (inventoryitem.amount <= 0) {
        return true;
    }
    return inventoryitem.amount / inventoryitem.itementry.amount <= 0.5;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x55735797, Offset: 0x1790
// Size: 0x1e8
function private function_c1b03b5() {
    level endon(#"game_ended");
    while (true) {
        players = getplayers();
        time = gettime();
        foreach (player in players) {
            if (player.sessionstate != "playing" || !isalive(player) || !isdefined(player.inventory) || player.inventory.consumed.size <= 0) {
                continue;
            }
            consumed = player.inventory.consumed;
            var_51a6bf3b = 0;
            for (i = 0; i < consumed.size; i++) {
                item = consumed[i];
                if (item.endtime <= time) {
                    arrayremoveindex(consumed, i);
                    var_51a6bf3b = 1;
                    continue;
                }
            }
            if (var_51a6bf3b) {
                player function_8473b7bf();
            }
        }
        players = undefined;
        waitframe(1);
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xd9718dcb, Offset: 0x1980
// Size: 0x33c
function private function_8473b7bf() {
    self function_edf4fd1d();
    foreach (item in self.inventory.items) {
        itementry = item.itementry;
        if (isdefined(itementry) && !(isdefined(itementry.consumable) && itementry.consumable) && isarray(itementry.talents)) {
            foreach (var_2a84b8aa in itementry.talents) {
                self function_748988bc(var_2a84b8aa.talent);
            }
        }
    }
    foreach (item in self.inventory.consumed) {
        itementry = item.itementry;
        if (isdefined(itementry) && isarray(itementry.talents)) {
            foreach (var_2a84b8aa in itementry.talents) {
                self function_748988bc(var_2a84b8aa.talent);
            }
        }
    }
    self.specialty = self getloadoutperks(self.class_num);
    self loadout::register_perks();
    armoritem = self.inventory.items[11];
    if (armoritem.networkid != 32767 && armoritem.itementry.itemtype == #"armor") {
        if (function_6d72f623(armoritem)) {
            self setperk(#"specialty_damaged_armor");
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x1f052d8d, Offset: 0x1cc8
// Size: 0xd6
function private function_eb6af9ef(networkid) {
    assert(isplayer(self));
    item = get_inventory_item(networkid);
    if (!isdefined(item)) {
        return;
    }
    if (item.itementry.itemtype == #"weapon") {
        weapon = item_inventory_util::function_370ccb8a(item);
        ammoclip = self getweaponammoclip(weapon);
        item.amount = ammoclip;
    }
}

// Namespace item_inventory/item_inventory
// Params 8, eflags: 0x4
// Checksum 0x7f6b42b8, Offset: 0x1da8
// Size: 0x182
function private function_348949f0(itemid, weapon, count, amount, stashitem = 0, var_5a34528e = undefined, targetname = undefined, attachments = undefined) {
    assert(isplayer(self));
    assert(item_world_util::function_a04a2a1f(itemid));
    droppos = var_5a34528e;
    if (!stashitem) {
        forward = anglestoforward(self.angles);
        droppos = self.origin + 36 * forward + (0, 0, 10);
    }
    return self item_drop::drop_item(weapon, count, amount, itemid, droppos, (0, randomintrange(0, 360), 0), stashitem, 0, targetname, undefined, attachments);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x545df863, Offset: 0x1f38
// Size: 0x4e
function private function_8ee568a1(slot, weapon) {
    if (sessionmodeiswarzonegame() && isplayer(self)) {
        self.var_56ec898a = 1;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0xc442a720, Offset: 0x1f90
// Size: 0x4e
function private _gadget_health_regen_on(slot, weapon) {
    if (sessionmodeiswarzonegame() && isplayer(self)) {
        self.var_5607c314 = 1;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x56209bb1, Offset: 0x1fe8
// Size: 0x52
function private _gadget_health_regen_off(slot, weapon) {
    if (sessionmodeiswarzonegame() && isplayer(self)) {
        self.var_5607c314 = undefined;
        self.var_56ec898a = undefined;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x7138a972, Offset: 0x2048
// Size: 0xcc
function private function_6189df5e(item) {
    assert(isdefined(item));
    weapon = item_inventory_util::function_370ccb8a(item);
    if (isdefined(weapon)) {
        if (weapon.name == #"eq_tripwire") {
            return 5;
        }
        return weapon.clipsize;
    } else if (isdefined(item.itementry) && isdefined(item.itementry.stackcount)) {
        return item.itementry.stackcount;
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x1953eeb0, Offset: 0x2120
// Size: 0x4c
function private function_5822b2f2() {
    return self isgrappling() || self isusingoffhand() || self function_1b77f4ea();
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x4
// Checksum 0x599f723c, Offset: 0x2178
// Size: 0x154
function private function_6670c3ed(item, weapon, ammo) {
    assert(isplayer(self));
    assert(isdefined(weapon));
    if (weapon.gadget_type == 23) {
        return;
    }
    if (weapon.name == #"eq_tripwire") {
        newpower = weapon.gadget_powermax;
    } else {
        var_5ac6ea27 = weapon.gadget_powermax / weapon.clipsize;
        newammo = ammo;
        if (newammo > weapon.clipsize) {
            newammo = weapon.clipsize;
        }
        newpower = newammo * var_5ac6ea27;
    }
    weaponslot = self gadgetgetslot(weapon);
    if (weaponslot > -1) {
        self gadgetpowerset(weaponslot, newpower);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0xbe600fb4, Offset: 0x22d8
// Size: 0x126
function private function_57cf4e09(itementry, var_81b304a2 = 0) {
    self endon(#"death");
    self.var_2eac7111 = 1;
    if (var_81b304a2) {
        wait 1.5;
        if (!isdefined(self)) {
            return;
        }
    }
    self replace_weapon(item_world_util::function_fe2abb62(itementry), level.nullprimaryoffhand);
    self setweaponammoclip(level.nullprimaryoffhand, 0);
    self switchtooffhand(level.nullprimaryoffhand);
    var_afb75af6 = self gadgetgetslot(level.nullprimaryoffhand);
    self gadgetpowerset(var_afb75af6, 0);
    self.var_2eac7111 = 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x3ed24c9f, Offset: 0x2408
// Size: 0x156
function private function_7fd7547(itementry, var_81b304a2 = 0) {
    self endon(#"death");
    self.var_2eac7111 = 1;
    if (var_81b304a2) {
        wait 1.5;
        if (!isdefined(self)) {
            return;
        }
    }
    weapon = item_world_util::function_fe2abb62(itementry);
    slot = self gadgetgetslot(weapon);
    while (self function_a2484d54(slot)) {
        waitframe(1);
    }
    self replace_weapon(weapon, level.var_5a62046e);
    var_1d1eead7 = self gadgetgetslot(level.var_5a62046e);
    self gadgetpowerset(var_1d1eead7, 0);
    self switchtooffhand(level.var_5a62046e);
    self.var_2eac7111 = 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xe7b43b45, Offset: 0x2568
// Size: 0x13e
function can_pickup_ammo(item, ammoamount = undefined) {
    assert(isplayer(self));
    itementry = item.itementry;
    ammoweapon = itementry.weapon;
    ammoamount = isdefined(itementry.amount) ? itementry.amount : isdefined(ammoamount) ? ammoamount : 1;
    maxstockammo = ammoweapon.maxammo;
    currentammostock = self getweaponammostock(ammoweapon);
    var_b0503a4f = maxstockammo - currentammostock;
    addammo = int(min(ammoamount, var_b0503a4f));
    return addammo > 0;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x5cbe899b, Offset: 0x26b0
// Size: 0x194
function function_7a32fa96(item) {
    assert(isplayer(self));
    if (!(isdefined(item.itementry.stackable) && item.itementry.stackable)) {
        return false;
    }
    weapon = item_world_util::function_fe2abb62(item.itementry);
    maxstack = function_6189df5e(item);
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].id == 32767) {
            continue;
        }
        inventoryitem = function_9c3c6ff2(self.inventory.items[i].id);
        if (inventoryitem.itementry.name != item.itementry.name) {
            continue;
        }
        if (self.inventory.items[i].count < maxstack) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xf2f26566, Offset: 0x2850
// Size: 0x1a8
function consume_item(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    consumeditem = spawnstruct();
    consumeditem.id = item.id;
    consumeditem.itementry = item.itementry;
    consumeditem.starttime = gettime();
    consumeditem.endtime = consumeditem.starttime + int((isdefined(item.itementry.duration) ? item.itementry.duration : 0) * 1000);
    self.inventory.consumed[self.inventory.consumed.size] = consumeditem;
    self function_2aa9e8ea(10, item.networkid);
    use_inventory_item(item.networkid, 1, 0);
    self function_41066a18(item);
    self function_8473b7bf();
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x7461dbc6, Offset: 0x2a00
// Size: 0x236
function function_518a1d93(networkid) {
    assert(isplayer(self));
    slotid = function_bb5fc9d5(networkid);
    attachmentweapons = [];
    attachmentids = [];
    foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
        var_7bae3009 = item_inventory_util::function_e7a671d8(slotid, attachmentoffset);
        item = self.inventory.items[var_7bae3009];
        if (item.networkid != 32767) {
            attachmentweapons[attachmentweapons.size] = item_world_util::function_4f1a8d4a(item.id);
            attachmentids[attachmentids.size] = item.id;
            remove_inventory_item(item.networkid, 0, 1);
        }
    }
    drop_inventory_item(self.inventory.items[slotid].networkid);
    for (index = 0; index < attachmentids.size; index++) {
        self function_348949f0(attachmentids[index], attachmentweapons[index], 1, 1);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x791cad50, Offset: 0x2c40
// Size: 0x5ee
function function_e1536678(item) {
    assert(isplayer(self));
    if (!isdefined(self.inventory)) {
        return undefined;
    }
    if (item.itementry.itemtype == #"ammo") {
        return undefined;
    }
    if (item.itementry.itemtype == #"weapon") {
        foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
            if (self.inventory.items[slotid].networkid === 32767) {
                return slotid;
            }
        }
        weaponitem = function_2037faaa(self.currentweapon);
        if (!isdefined(weaponitem)) {
            return;
        }
        return function_bb5fc9d5(weaponitem.networkid);
    }
    if (item.itementry.itemtype == #"backpack" && self.inventory.items[13].networkid === 32767) {
        return 13;
    }
    if (item.itementry.itemtype == #"armor") {
        return 11;
    }
    if (item.itementry.itemtype == #"resource") {
        return 14;
    }
    if (item.itementry.itemtype == #"equipment" && self.inventory.items[12].networkid === 32767) {
        return 12;
    }
    if (item.itementry.itemtype == #"health" && self.inventory.items[10].networkid === 32767) {
        return 10;
    }
    if (item.itementry.itemtype == #"attachment") {
        weaponslotid = function_83dd5725();
        if (!isdefined(weaponslotid)) {
            return;
        }
        var_5317ff5e = item_world_util::function_5a578f3(self, weaponslotid);
        if (self.inventory.items[weaponslotid].networkid == 32767) {
            return;
        }
        var_e0d49b9b = item_inventory_util::function_82cb86b6(item.itementry);
        var_7bae3009 = item_inventory_util::function_e7a671d8(weaponslotid, var_e0d49b9b);
        weaponitem = self get_inventory_item(var_5317ff5e);
        attachmentname = item_inventory_util::function_580900d1(weaponitem, item.itementry, 1);
        if (isdefined(attachmentname)) {
            return var_7bae3009;
        }
    }
    if (isdefined(item.itementry.stackable) && item.itementry.stackable) {
        weapon = item_world_util::function_fe2abb62(item.itementry);
        if (isdefined(weapon)) {
            maxstack = function_6189df5e(item);
            foreach (i, spawnitem in self.inventory.items) {
                if (spawnitem.id == 32767) {
                    continue;
                }
                inventoryitem = function_9c3c6ff2(spawnitem.id);
                if (inventoryitem.itementry.name != item.itementry.name) {
                    continue;
                }
                if (self.inventory.items[i].count < maxstack) {
                    return undefined;
                }
            }
        }
    }
    foreach (i, spawnitem in self.inventory.items) {
        if (spawnitem.id == 32767) {
            return undefined;
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xe63e947d, Offset: 0x3238
// Size: 0xe4
function drop_armor(stashitem = 0, var_5a34528e = undefined, targetname = undefined) {
    assert(isplayer(self));
    if (self has_armor()) {
        item = self.inventory.items[11];
        self drop_inventory_item(item.networkid, stashitem, var_5a34528e, targetname);
        return true;
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x2d39e23d, Offset: 0x3328
// Size: 0xfe
function function_7ce8692e(stashitem = 0, var_5a34528e = undefined, targetname = undefined) {
    assert(isplayer(self));
    for (index = self.inventory.var_7d6932b1; index < 10; index++) {
        inventoryitem = self.inventory.items[index];
        if (inventoryitem.networkid != 32767) {
            drop_inventory_item(inventoryitem.networkid, stashitem, var_5a34528e, targetname);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x3ce17864, Offset: 0x3430
// Size: 0x3a2
function drop_inventory_item(networkid, stashitem = 0, var_5a34528e = undefined, targetname = undefined) {
    assert(isplayer(self));
    dropitem = undefined;
    item = get_inventory_item(networkid);
    if (!isdefined(item)) {
        return dropitem;
    }
    weapon = item_inventory_util::function_370ccb8a(item);
    if (isdefined(self) && isdefined(weapon) && self.currentweapon == weapon && self isfiring()) {
        waitframe(1);
    }
    if (!isdefined(self) || isdefined(weapon) && self.currentweapon == weapon && self isfiring()) {
        return dropitem;
    }
    function_eb6af9ef(networkid);
    count = isdefined(item.count) ? item.count : 1;
    amount = isdefined(item.amount) ? item.amount : 0;
    var_9abbad04 = self.inventory.items[13].networkid === networkid;
    if (self function_d880c838(networkid, 0)) {
        if (var_9abbad04) {
            function_7ce8692e(stashitem, var_5a34528e, targetname);
        }
        if (count > 0) {
            if (isdefined(item.var_1974e8e6) && item.var_1974e8e6) {
                item.var_1974e8e6 = 0;
                item_inventory_util::function_70701256(item);
            }
            weapon = item_inventory_util::function_370ccb8a(item);
            dropitem = self function_348949f0(item.id, weapon, count, amount, stashitem, var_5a34528e, targetname, item.attachments);
            if (isdefined(item.attachments)) {
                attachments = arraycopy(item.attachments);
                foreach (attachment in attachments) {
                    remove_inventory_item(attachment.networkid);
                }
            }
            return dropitem;
        }
    }
    return dropitem;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x2a8d3cc2, Offset: 0x37e0
// Size: 0x21e
function equip_ammo(item, var_a2bce25c) {
    assert(isplayer(self));
    assert(isdefined(item));
    self function_41066a18(item);
    itementry = item.itementry;
    ammoweapon = itementry.weapon;
    ammoamount = isdefined(itementry.amount) ? itementry.amount : isdefined(var_a2bce25c) ? var_a2bce25c : 1;
    maxstockammo = ammoweapon.maxammo;
    currentammostock = self getweaponammostock(ammoweapon);
    var_b0503a4f = maxstockammo - currentammostock;
    addammo = int(min(ammoamount, var_b0503a4f));
    if (isdefined(ammoweapon) && ammoweapon != level.weaponnone) {
        self.inventory.ammo[ammoweapon.name] = item.id;
        self function_942e4603(ammoweapon, addammo);
        if (isdefined(var_a2bce25c)) {
            return (ammoamount - addammo);
        }
        return 0;
    }
    assertmsg("<dev string:x30>" + itementry.name + "<dev string:x4b>");
    return ammoamount - addammo;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x2991dc4d, Offset: 0x3a08
// Size: 0x1a4
function equip_armor(item) {
    itementry = item.itementry;
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    self function_41066a18(item);
    self armor::set_armor(inventoryitem.amount, isdefined(itementry.amount) ? itementry.amount : 0, isdefined(itementry.var_bb5145f6) ? itementry.var_bb5145f6 : 1, isdefined(itementry.var_befe8a36) ? itementry.var_befe8a36 : 1, isdefined(itementry.var_9ff0db6d) ? itementry.var_9ff0db6d : 1, isdefined(itementry.var_c74f953b) ? itementry.var_c74f953b : 1, isdefined(itementry.var_2a7a79cc) ? itementry.var_2a7a79cc : 0);
    self.inventory.items[11] = inventoryitem;
    self function_2aa9e8ea(4, item.networkid);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x9c21ae2e, Offset: 0x3bb8
// Size: 0x36c
function equip_attachment(item, var_5317ff5e, var_8d8eef68 = 1) {
    assert(isplayer(self));
    assert(isstruct(item));
    weaponitem = undefined;
    if (var_5317ff5e != 32767) {
        weaponitem = get_inventory_item(var_5317ff5e);
    }
    if (!isdefined(weaponitem) || !isdefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
        return;
    }
    if (item_inventory_util::function_6bed1918(weaponitem, item, 0)) {
        function_be27f92c(item, undefined, weaponitem);
        offset = item_inventory_util::function_82cb86b6(item.itementry);
        weaponslotid = get_weapon_slot(weaponitem);
        if (!isdefined(weaponslotid)) {
            return;
        }
        var_7bae3009 = item_inventory_util::function_e7a671d8(weaponslotid, offset);
        slotid = function_bb5fc9d5(item.networkid);
        if (!isdefined(slotid)) {
            return;
        }
        function_8882634(slotid, var_7bae3009);
        self function_2aa9e8ea(4, item.networkid);
        foreach (slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock")) {
            if (isdefined(item.itementry.(slot)) && item.itementry.(slot)) {
                function_176ba32f(weaponitem, slot, undefined, item);
            }
        }
        function_522c0741(var_5317ff5e, undefined, undefined, 0);
        item_inventory_util::function_70701256(weaponitem);
        equip_weapon(weaponitem, 1, undefined, var_8d8eef68, 0);
        self function_41066a18(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x900b58cd, Offset: 0x3f30
// Size: 0x10c
function equip_backpack(item) {
    assert(isplayer(self));
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    slotid = function_bb5fc9d5(item.networkid);
    if (!isdefined(slotid)) {
        return;
    }
    self function_41066a18(item);
    function_8882634(slotid, 13);
    self.inventory.var_7d6932b1 = 10;
    self.inventory.items[13] = inventoryitem;
    self function_2aa9e8ea(4, item.networkid);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xe96dab0a, Offset: 0x4048
// Size: 0x3cc
function equip_equipment(item) {
    self notify("31f2fafac731a83d");
    self endon("31f2fafac731a83d");
    assert(isplayer(self));
    while (isdefined(self) && isdefined(self.var_2eac7111) && self.var_2eac7111) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    if (isdefined(self.var_ef350cec)) {
        return;
    }
    if (isdefined(self.var_27445a8d)) {
        return;
    }
    if (self function_5822b2f2()) {
        return;
    }
    itementry = item.itementry;
    weapon = itementry.weapon;
    equipmentitem = self.inventory.items[12];
    if (equipmentitem.id != 32767) {
        equippedweapon = function_9c3c6ff2(equipmentitem.id).itementry.weapon;
        if (isdefined(equippedweapon) && equippedweapon.isgadget && self gadgetisprimed(self gadgetgetslot(equippedweapon))) {
            return;
        }
    }
    if (isdefined(weapon) && weapon != level.weaponnone) {
        self function_41066a18(item);
        if (equipmentitem.networkid != 32767 && equipmentitem.networkid != item.networkid) {
            function_522c0741(equipmentitem.networkid);
        }
        slotid = function_bb5fc9d5(item.networkid);
        if (isdefined(slotid) && slotid < self.inventory.var_7d6932b1) {
            function_8882634(slotid, 12);
        }
        self replace_weapon(level.nullprimaryoffhand, weapon);
        self function_2aa9e8ea(4, item.networkid);
        for (i = 0; i < self.inventory.items.size; i++) {
            if (self.inventory.items[i].networkid === item.networkid) {
                self function_6670c3ed(item, weapon, self.inventory.items[i].count);
                break;
            }
        }
        self switchtooffhand(weapon);
        return;
    }
    assertmsg("<dev string:x4d>" + itementry.name + "<dev string:x4b>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x76cea05, Offset: 0x4420
// Size: 0x394
function equip_health(item) {
    self notify("1285b17180a3e89");
    self endon("1285b17180a3e89");
    assert(isplayer(self));
    while (isdefined(self) && isdefined(self.var_2eac7111) && self.var_2eac7111) {
        waitframe(1);
    }
    if (!isdefined(item) || !isdefined(self)) {
        return;
    }
    if (isdefined(self.var_5607c314) && self.var_5607c314 || isdefined(self.var_56ec898a) && self.var_56ec898a) {
        return 0;
    }
    var_3cb3ed71 = self.inventory.items[10].networkid;
    if (isdefined(var_3cb3ed71) && var_3cb3ed71 != 32767) {
        var_a95582cd = get_inventory_item(var_3cb3ed71);
        if (isdefined(var_a95582cd)) {
            var_87e0b52c = item_inventory_util::function_370ccb8a(var_a95582cd);
            if (isdefined(var_87e0b52c)) {
                slot = self gadgetgetslot(var_87e0b52c);
                if (self function_a2484d54(slot)) {
                    return 0;
                }
            }
        }
    }
    itementry = item.itementry;
    weapon = itementry.weapon;
    if (isdefined(weapon) && weapon != level.weaponnone) {
        self function_41066a18(item);
        healthitem = self.inventory.items[10];
        if (healthitem.networkid != 32767 && healthitem.networkid != item.networkid) {
            function_522c0741(healthitem.networkid);
        }
        slotid = function_bb5fc9d5(item.networkid);
        if (isdefined(slotid) && slotid < self.inventory.var_7d6932b1) {
            function_8882634(slotid, 10);
        }
        self replace_weapon(level.var_5a62046e, weapon);
        self function_2aa9e8ea(4, item.networkid);
        self function_6670c3ed(item, weapon, self.inventory.items[10].count);
        self switchtooffhand(weapon);
        return;
    }
    assertmsg("<dev string:x74>" + itementry.name + "<dev string:x4b>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xc32e183b, Offset: 0x47c0
// Size: 0x2d2
function equip_item(networkid) {
    assert(isplayer(self));
    item = get_inventory_item(networkid);
    if (isdefined(item)) {
        if (isdefined(item.itementry.consumable) && item.itementry.consumable) {
            return self consume_item(item);
        }
        itemtype = item.itementry.itemtype;
        switch (itemtype) {
        case #"ammo":
            self equip_ammo(item);
            break;
        case #"armor":
            self equip_armor(item);
            break;
        case #"attachment":
            self equip_attachment(item, function_55297349());
            break;
        case #"backpack":
            self equip_backpack(item);
            break;
        case #"equipment":
            self equip_equipment(item);
            break;
        case #"generic":
            break;
        case #"health":
            self equip_health(item);
            break;
        case #"killstreak":
            self use_killstreak(networkid, item);
            break;
        case #"weapon":
            self equip_weapon(item);
            break;
        default:
            assertmsg("<dev string:x98>" + (isdefined(item.itementry.itemtype) ? item.itementry.itemtype : "<dev string:xb0>") + "<dev string:xba>");
            return 0;
        }
        return 1;
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xc7ee0d07, Offset: 0x4aa0
// Size: 0x26
function private can_switch_weapons() {
    if (self function_5822b2f2()) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 5, eflags: 0x0
// Checksum 0x809902b6, Offset: 0x4ad0
// Size: 0x73c
function equip_weapon(item, switchweapon = 1, var_8da64411 = 0, var_8d8eef68 = 0, initialweaponraise = 0) {
    assert(isplayer(self));
    itementry = item.itementry;
    itemtype = itementry.itemtype;
    assert(itemtype == #"weapon");
    currentweapon = level.weaponbasemeleeheld;
    var_191e75e8 = 14 + 1;
    if (function_39c0e4f0() == 2) {
        if (var_8da64411) {
            currentweapon = self getstowedweapon();
        } else {
            currentweapon = self.currentweapon;
        }
        foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
            var_a31f9083 = self.inventory.items[slotid];
            if (var_a31f9083.networkid === 32767) {
                continue;
            }
            equippedweapon = item_inventory_util::function_370ccb8a(var_a31f9083);
            if (currentweapon == equippedweapon) {
                var_191e75e8 = slotid;
                function_eb6af9ef(var_a31f9083.networkid);
                function_522c0741(var_a31f9083.networkid);
                break;
            }
        }
        currentweapon = level.weaponbasemeleeheld;
    } else {
        var_191e75e8 = undefined;
        foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
            if (self.inventory.items[slotid].networkid === item.networkid) {
                var_191e75e8 = slotid;
                break;
            }
        }
        if (!isdefined(var_191e75e8)) {
            foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
                if (self.inventory.items[slotid].networkid === 32767) {
                    var_191e75e8 = slotid;
                    break;
                }
            }
        }
    }
    weapon = item_inventory_util::function_370ccb8a(item);
    if (isdefined(weapon) && weapon != level.weaponnone) {
        var_6d753e3a = self getweaponammostock(weapon);
        item.var_1974e8e6 = slotid == 14 + 1 + 6 + 1;
        if (item.var_1974e8e6) {
            item_inventory_util::function_70701256(item);
            weapon = item_inventory_util::function_370ccb8a(item);
        }
        slotid = function_bb5fc9d5(item.networkid);
        if (!isdefined(slotid)) {
            return;
        }
        self function_8882634(slotid, var_191e75e8);
        self replace_weapon(currentweapon, weapon, initialweaponraise, var_8d8eef68);
        self function_2aa9e8ea(4, item.networkid);
        inventoryitem = get_inventory_item(item.networkid);
        if (!isdefined(inventoryitem)) {
            return;
        }
        if (weapon !== currentweapon) {
            var_a80fac52 = int(min(var_6d753e3a, weapon.clipsize));
            self function_942e4603(weapon, var_a80fac52);
        }
        var_4063c283 = get_weapon_count();
        if (var_8d8eef68) {
            self function_a9ce8955(weapon);
        } else {
            self shoulddoinitialweaponraise(weapon, initialweaponraise);
        }
        self setweaponammoclip(weapon, int(inventoryitem.amount));
        if (switchweapon || var_4063c283 == 1) {
            if (self can_switch_weapons()) {
                self switchtoweapon(weapon, 1);
                self.currentweapon = weapon;
            }
        }
        self function_41066a18(item);
        return;
    }
    assertmsg("<dev string:xe0>" + itementry.name + "<dev string:x4b>");
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xac65cb50, Offset: 0x5218
// Size: 0x42
function function_55297349() {
    assert(isplayer(self));
    return function_a1333a2b(self.currentweapon);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x8819171d, Offset: 0x5268
// Size: 0x72
function function_83dd5725() {
    assert(isplayer(self));
    networkid = self function_55297349();
    if (networkid === 32767) {
        return;
    }
    return item_world_util::function_5b57f1f9(self, networkid);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xc94ed6aa, Offset: 0x52e8
// Size: 0xaa
function function_39c0e4f0() {
    assert(isplayer(self));
    weaponcount = 0;
    currentweapon = self.currentweapon;
    if (isdefined(currentweapon) && currentweapon != level.weaponnone) {
        weaponcount++;
    }
    stowedweapon = self getstowedweapon();
    if (stowedweapon != level.weaponnone) {
        weaponcount++;
    }
    return weaponcount;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x47ed731a, Offset: 0x53a0
// Size: 0x88
function function_e4e86e53() {
    assert(isplayer(self));
    for (index = 0; index < self.inventory.var_7d6932b1; index++) {
        if (self.inventory.items[index].networkid == 32767) {
            return index;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xcb475fbb, Offset: 0x5430
// Size: 0x14e
function function_2037faaa(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    foreach (weaponslot in array(10, 11, 12, 13, 14 + 1, 14 + 1 + 6 + 1)) {
        item = self.inventory.items[weaponslot];
        if (item.networkid === 32767) {
            continue;
        }
        if (item_inventory_util::function_370ccb8a(item) === weapon) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x15c9ffe2, Offset: 0x5588
// Size: 0x9a
function function_a1333a2b(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    weaponitem = function_2037faaa(weapon);
    return isdefined(weaponitem) ? weaponitem.networkid : 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x68b0e020, Offset: 0x5630
// Size: 0xb8
function function_bb5fc9d5(networkid) {
    assert(isplayer(self));
    assert(item_world_util::function_486a6ba1(networkid));
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            return i;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x7d8530ff, Offset: 0x56f0
// Size: 0xb0
function get_inventory_item(networkid) {
    assert(isint(networkid) && networkid != 32767);
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            return self.inventory.items[i];
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xf1105798, Offset: 0x57a8
// Size: 0x98
function function_2f6c4f55(networkid) {
    assert(isplayer(self));
    assert(item_world_util::function_9628594b(networkid));
    item = get_inventory_item(networkid);
    if (isdefined(item)) {
        return item.id;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xc185707e, Offset: 0x5848
// Size: 0x98
function function_c860b29c(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    item = function_2037faaa(weapon);
    if (isdefined(item)) {
        return item.id;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x35ff682b, Offset: 0x58e8
// Size: 0xf2
function get_weapon_count() {
    assert(isplayer(self));
    weaponcount = 0;
    foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
        if (self.inventory.items[slotid].networkid != 32767) {
            weaponcount++;
        }
    }
    return weaponcount;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xafff1376, Offset: 0x59e8
// Size: 0xde
function get_weapon_slot(item) {
    if (item.networkid === 32767) {
        return;
    }
    foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
        if (self.inventory.items[slotid].networkid == item.networkid) {
            return slotid;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x8e1d2ef8, Offset: 0x5ad0
// Size: 0x978
function give_inventory_item(item, itemcount = 1, var_a2bce25c = 0, slotid = undefined) {
    assert(isplayer(self));
    assert(isdefined(item));
    itementry = item.itementry;
    itemid = item.id;
    if (isdefined(item.itementry.var_a8dd3e4b)) {
        var_a8dd3e4b = getscriptbundle(item.itementry.var_a8dd3e4b);
        if (isdefined(var_a8dd3e4b)) {
            itementry = var_a8dd3e4b;
        }
        var_65d78df5 = function_a5758930(item.itementry.var_a8dd3e4b);
        if (isdefined(var_65d78df5)) {
            itemid = var_65d78df5.id;
        }
    }
    var_4ac38a2f = isdefined(itementry.stackable) && itementry.stackable;
    maxstacksize = var_4ac38a2f ? function_6189df5e(item) : 1;
    if (isdefined(itementry.name) && var_4ac38a2f) {
        for (i = 0; i < self.inventory.items.size; i++) {
            if (self.inventory.items[i].id != 32767) {
                if (self.inventory.items[i].itementry.name != itementry.name) {
                    continue;
                }
                var_4a88530e = maxstacksize - self.inventory.items[i].count;
                if (var_4a88530e <= 0) {
                    continue;
                }
                var_53a89528 = int(min(itemcount, var_4a88530e));
                self.inventory.items[i].count = self.inventory.items[i].count + var_53a89528;
                item.networkid = self.inventory.items[i].networkid;
                self function_2aa9e8ea(7, self.inventory.items[i].networkid, self.inventory.items[i].count);
                inventoryweapon = item_inventory_util::function_370ccb8a(self.inventory.items[i]);
                if (isdefined(inventoryweapon)) {
                    self function_6670c3ed(item, inventoryweapon, self.inventory.items[i].count);
                }
                itemcount -= var_53a89528;
                assert(itemcount >= 0);
                if (itemcount <= 0) {
                    self function_2aa9e8ea(2, itemid, 0);
                    self function_8473b7bf();
                    return 0;
                }
            }
        }
    }
    if (isdefined(slotid)) {
        var_f26ea073 = undefined;
        if (slotid < self.inventory.items.size) {
            var_f26ea073 = self.inventory.items[slotid];
        }
        assert(isdefined(var_f26ea073));
        if (var_f26ea073.networkid != 32767) {
            return itemcount;
        }
        if (slotid === 14 && var_f26ea073.networkid != 32767) {
            return itemcount;
        }
        var_53a89528 = int(min(itemcount, maxstacksize));
        item.networkid = item_world_util::function_5a578f3(self, slotid);
        item_inventory_util::function_70701256(item);
        var_f26ea073.amount = var_a2bce25c;
        var_f26ea073.count = var_53a89528;
        var_f26ea073.id = itemid;
        var_f26ea073.networkid = item.networkid;
        var_f26ea073.itementry = itementry;
        self function_2aa9e8ea(2, item.id, var_53a89528, slotid + 1);
        itemcount -= var_53a89528;
        assert(itemcount >= 0);
        if (itemcount <= 0) {
            if (isdefined(item.attachments)) {
                foreach (attachmentitem in item.attachments) {
                    var_fe8335f0 = item_inventory_util::function_82cb86b6(attachmentitem.itementry);
                    if (!isdefined(var_fe8335f0)) {
                        continue;
                    }
                    var_7bae3009 = item_inventory_util::function_e7a671d8(slotid, var_fe8335f0);
                    give_inventory_item(attachmentitem, undefined, undefined, var_7bae3009);
                    attachmentitem = get_inventory_item(attachmentitem.networkid);
                    item_inventory_util::function_6bed1918(var_f26ea073, attachmentitem, 0);
                }
                item_inventory_util::function_70701256(var_f26ea073);
            }
            self function_8473b7bf();
            return 0;
        }
    }
    for (i = 0; i < self.inventory.var_7d6932b1; i++) {
        if (self.inventory.items[i].networkid === 32767) {
            var_53a89528 = int(min(itemcount, maxstacksize));
            item.networkid = item_world_util::function_5a578f3(self, i);
            self.inventory.items[i].amount = var_a2bce25c;
            self.inventory.items[i].count = var_53a89528;
            self.inventory.items[i].id = itemid;
            self.inventory.items[i].networkid = item.networkid;
            self.inventory.items[i].itementry = itementry;
            item_inventory_util::function_70701256(self.inventory.items[i]);
            self function_2aa9e8ea(2, item.id, var_53a89528, i + 1);
            itemcount -= var_53a89528;
            assert(itemcount >= 0);
            if (itemcount <= 0) {
                break;
            }
        }
    }
    self function_8473b7bf();
    return itemcount;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xc96100fa, Offset: 0x6450
// Size: 0x96
function has_armor() {
    assert(isplayer(self));
    hasarmor = self.inventory.items[11].networkid != 32767 && self.inventory.items[11].itementry.itemtype == #"armor";
    return hasarmor;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xecc4a319, Offset: 0x64f0
// Size: 0xae
function has_backpack() {
    assert(isplayer(self));
    hasbackpack = isdefined(self.inventory.items[13]) && isdefined(self.inventory.items[13].itementry) && self.inventory.items[13].itementry.itemtype == #"backpack";
    return hasbackpack;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xb81e9ed6, Offset: 0x65a8
// Size: 0x100
function function_8140faa6(item_name) {
    assert(isplayer(self));
    if (!isdefined(self.inventory)) {
        return false;
    }
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_c9531505 = item_world_util::get_itemtype(item.itementry);
        if (item_name == var_c9531505) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x8be2cb87, Offset: 0x66b0
// Size: 0x72
function has_inventory_item(slotid) {
    assert(isplayer(self));
    return isdefined(self.inventory.items[slotid]) && self.inventory.items[slotid].networkid != 32767;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xe0710041, Offset: 0x6730
// Size: 0xf2
function init_inventory() {
    assert(isplayer(self));
    self.inventory = spawnstruct();
    self.inventory.items = [];
    for (i = 0; i < 14 + 1 + 6 + 1 + 6 + 1; i++) {
        self.inventory.items[i] = function_714e3fcb();
    }
    self.inventory.ammo = [];
    self.inventory.consumed = [];
    self.inventory.var_7d6932b1 = 5;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x98480244, Offset: 0x6830
// Size: 0xc4
function function_c15748f0(item) {
    assert(isplayer(self));
    if (isdefined(item.itementry.var_59637e5d)) {
        characterindex = self player_role::get();
        specialist = function_4a9245b(characterindex, currentsessionmode());
        if (item.itementry.var_59637e5d != specialist) {
            return false;
        }
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x1d8e330f, Offset: 0x6900
// Size: 0x9c
function function_782c5830(slotid) {
    assert(isplayer(self));
    assert(slotid >= 0 && slotid < 14 + 1 + 6 + 1 + 6 + 1);
    return self.inventory.items[slotid].networkid != 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xfe99b464, Offset: 0x69a8
// Size: 0x294
function function_5e921c3b(networkid) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    foreach (slot in array(10, 11, 12, 13, 14 + 1, 14 + 1 + 6 + 1)) {
        if (self.inventory.items[slot].networkid === networkid) {
            return true;
        }
    }
    foreach (weaponid in array(14 + 1, 14 + 1 + 6 + 1)) {
        foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
            attachmentid = item_inventory_util::function_e7a671d8(weaponid, attachmentoffset);
            if (self.inventory.items[attachmentid].networkid === networkid) {
                return true;
            }
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x36a3bde4, Offset: 0x6c48
// Size: 0x1e2
function function_41066a18(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    if (isdefined(item) && isdefined(item.itementry)) {
        if (isdefined(item.itementry.consumable) && item.itementry.consumable) {
            if (isdefined(item.itementry.equipsound)) {
                self playsoundtoplayer(item.itementry.equipsound, self);
                return;
            }
        }
        switch (item.itementry.itemtype) {
        case #"weapon":
            break;
        case #"ammo":
            break;
        case #"health":
            break;
        case #"equipment":
            break;
        case #"armor":
            break;
        case #"backpack":
            break;
        case #"attachment":
            if (isdefined(item.itementry.equipsound)) {
                self playsoundtoplayer(item.itementry.equipsound, self);
            }
            break;
        case #"generic":
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x15dcf5e, Offset: 0x6e38
// Size: 0x586
function remove_inventory_item(networkid, var_81b304a2 = 0, notifyclient = 1, var_cdc9a631 = 1) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    itemid = function_2f6c4f55(networkid);
    if (itemid == 32767) {
        return false;
    }
    item = get_inventory_item(networkid);
    weapon = item_inventory_util::function_370ccb8a(item);
    itementry = item.itementry;
    if (isdefined(weapon)) {
        if (weapon.isgadget) {
            if (self gadgetisprimed(self gadgetgetslot(weapon))) {
                return false;
            }
        }
        if (!can_switch_weapons()) {
            currentweapon = self getcurrentweapon();
            if (isdefined(currentweapon) && currentweapon != level.weaponnone && currentweapon == weapon) {
                foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
                    var_7268e15f = self.inventory.items[slotid].networkid;
                    if (!isdefined(var_7268e15f) || var_7268e15f == 32767) {
                        continue;
                    }
                    if (var_7268e15f == networkid) {
                        var_a31f9083 = get_inventory_item(var_7268e15f);
                        equippedweapon = item_inventory_util::function_370ccb8a(var_a31f9083);
                        if (equippedweapon == weapon) {
                            return false;
                        }
                    }
                }
            }
        }
    }
    if (self.inventory.items[12].networkid === networkid) {
        if (isdefined(self.var_27445a8d)) {
            return false;
        }
    }
    if (self.inventory.items[13].networkid === networkid) {
        self.inventory.items[13] = function_714e3fcb();
        self.inventory.var_7d6932b1 = 5;
        if (notifyclient) {
            self function_2aa9e8ea(3, networkid);
        }
        function_4fc74b3(itementry.itemtype, itementry);
        if (var_cdc9a631) {
            for (index = self.inventory.var_7d6932b1; index < 10; index++) {
                inventoryitem = self.inventory.items[index];
                if (inventoryitem.networkid != 32767) {
                    remove_inventory_item(inventoryitem.networkid);
                }
            }
        }
        return true;
    }
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            unequipped = self function_522c0741(networkid, var_81b304a2, notifyclient, var_cdc9a631);
            self.inventory.items[i] = function_714e3fcb();
            self function_8473b7bf();
            if (notifyclient) {
                self function_2aa9e8ea(3, networkid);
            }
            if (unequipped) {
                function_4fc74b3(itementry.itemtype, itementry);
            }
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 5, eflags: 0x0
// Checksum 0x27a2c4e0, Offset: 0x73c8
// Size: 0x166
function replace_weapon(old_weapon, new_weapon, primary_weapon = 0, var_d7adf15e = 1, var_c76b02ad = 0) {
    assert(isdefined(old_weapon));
    assert(isdefined(new_weapon));
    if (isdefined(old_weapon) && old_weapon != level.weaponnone) {
        self replaceweapon(old_weapon, 0, new_weapon);
        self takeweapon(old_weapon);
    } else {
        self giveweapon(new_weapon);
    }
    if (var_c76b02ad) {
        self function_a9ce8955(new_weapon);
    } else {
        self shoulddoinitialweaponraise(new_weapon, var_d7adf15e);
    }
    if (primary_weapon && self isinvehicle()) {
        self.currentweapon = new_weapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x1b85c5dc, Offset: 0x7538
// Size: 0x286
function function_21ef56e3(item) {
    assert(isdefined(item));
    if (true) {
        slotid = undefined;
        switch (item.itementry.itemtype) {
        case #"armor":
            slotid = 11;
            break;
        case #"backpack":
            slotid = 13;
            break;
        case #"equipment":
            slotid = 12;
            break;
        case #"health":
            slotid = 10;
            break;
        case #"weapon":
            slotid = array(14 + 1, 14 + 1 + 6 + 1);
            break;
        }
        if (isarray(slotid)) {
            emptyslot = 0;
            foreach (id in slotid) {
                if (self.inventory.items[id].networkid === 32767 || self.inventory.items[id].networkid === item.networkid) {
                    emptyslot = 1;
                    break;
                }
            }
            if (!emptyslot) {
                return false;
            }
        } else if (self.inventory.items[slotid].networkid !== 32767 && self.inventory.items[slotid].networkid !== item.networkid) {
            return false;
        }
        if (self function_c15748f0(item)) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xe24c19b1, Offset: 0x77c8
// Size: 0x1a4
function function_39129ea8(itemid, count) {
    assert(isplayer(self));
    assert(item_world_util::function_a04a2a1f(itemid));
    item = function_9c3c6ff2(itemid);
    assert(item.itementry.itemtype == #"ammo");
    weapon = item.itementry.weapon;
    maxammo = self getweaponammostock(weapon);
    count = int(min(isdefined(count) ? count : maxammo, maxammo));
    if (count <= 0) {
        return;
    }
    self function_942e4603(weapon, count * -1);
    self function_348949f0(item.id, item.itementry.weapon, 1, count);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x7e6a33c9, Offset: 0x7978
// Size: 0x1e4
function function_dfbf4920(networkid, count) {
    assert(isplayer(self));
    assert(isint(count) && count > 0);
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    if (self.inventory.items[12].networkid == networkid && isdefined(self.var_27445a8d) && self.var_27445a8d == item.itementry.weapon.name) {
        if (item.count == count) {
            count--;
        }
    }
    count = int(min(item.count, count));
    if (count <= 0) {
        return;
    }
    weapon = item.itementry.weapon;
    self function_348949f0(item.id, item.itementry.weapon, count, 0);
    self use_inventory_item(networkid, count);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x6c1fc701, Offset: 0x7b68
// Size: 0x4e
function function_d880c838(networkid, var_cdc9a631 = 1) {
    if (!self remove_inventory_item(networkid, undefined, undefined, var_cdc9a631)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x26deeb2e, Offset: 0x7bc0
// Size: 0x12c
function function_56cf65bc(player, item) {
    if (game.state == "pregame" || !isdefined(item)) {
        return;
    }
    data = {#game_time:function_25e96038(), #player_xuid:int(player getxuid(1)), #item:hash(item.itementry.name)};
    println("<dev string:xfe>" + item.itementry.name);
    function_b1f6086c(#"hash_50be59ef12074ce", data);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xf281bc84, Offset: 0x7cf8
// Size: 0x204
function reset_inventory() {
    assert(isplayer(self));
    while (self isgrappling()) {
        waitframe(1);
    }
    foreach (inventoryitem in self.inventory.items) {
        if (inventoryitem.networkid != 32767) {
            remove_inventory_item(inventoryitem.networkid, 0, 0);
        }
    }
    foreach (ammoweapon, itemid in self.inventory.ammo) {
        weapon = getweapon(ammoweapon);
        self setweaponammostock(weapon, 0);
    }
    if (isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]](1);
    }
    self init_inventory();
    self function_8473b7bf();
    self function_2aa9e8ea(8);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x4eec25c2, Offset: 0x7f08
// Size: 0x15c
function function_8882634(var_69bdab26, var_631e6a29) {
    assert(isplayer(self));
    assert(isdefined(var_69bdab26) && isdefined(var_631e6a29));
    fromitem = self.inventory.items[var_69bdab26];
    toitem = self.inventory.items[var_631e6a29];
    self.inventory.items[var_69bdab26] = toitem;
    self.inventory.items[var_631e6a29] = fromitem;
    if (isdefined(fromitem.itementry)) {
        fromitem.networkid = item_world_util::function_5a578f3(self, var_631e6a29);
    }
    if (isdefined(toitem.itementry)) {
        toitem.networkid = item_world_util::function_5a578f3(self, var_69bdab26);
    }
    self function_2aa9e8ea(11, var_69bdab26, var_631e6a29);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x8e0ff618, Offset: 0x8070
// Size: 0x300
function function_be27f92c(item, notifyclient = 1, ignoreweapon = undefined) {
    assert(isplayer(self));
    assert(isstruct(item));
    foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
        var_5317ff5e = self.inventory.items[slotid].networkid;
        if (var_5317ff5e == 32767) {
            continue;
        }
        if (isdefined(ignoreweapon) && ignoreweapon.networkid === var_5317ff5e) {
            continue;
        }
        weaponitem = get_inventory_item(var_5317ff5e);
        if (!isdefined(weaponitem) || !isdefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
            assert(0);
            continue;
        }
        if (item_inventory_util::function_962387cc(weaponitem, item, 0)) {
            itemtype = item.itementry.itemtype;
            networkid = item.networkid;
            if (notifyclient) {
                self function_2aa9e8ea(5, networkid);
            }
            weapon = item_inventory_util::function_370ccb8a(weaponitem);
            iscurrentweapon = weapon == self.currentweapon;
            function_522c0741(var_5317ff5e, undefined, notifyclient, 0);
            item_inventory_util::function_70701256(weaponitem);
            equip_weapon(weaponitem, iscurrentweapon, undefined, 1, 0);
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0xbdbe5b4e, Offset: 0x8378
// Size: 0x1c0
function function_176ba32f(item, slot, notifyclient = 1, ignoreattachment = undefined) {
    assert(isplayer(self));
    assert(isstruct(item));
    if (!isdefined(item.attachments)) {
        return 0;
    }
    attachments = arraycopy(item.attachments);
    foreach (attachment in attachments) {
        if (isdefined(ignoreattachment) && ignoreattachment.networkid == attachment.networkid) {
            continue;
        }
        if (isdefined(attachment.itementry.(slot)) && attachment.itementry.(slot)) {
            function_be27f92c(get_inventory_item(attachment.networkid), notifyclient);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x8bdadbb3, Offset: 0x8540
// Size: 0x26c
function function_522c0741(networkid, var_81b304a2 = 0, notifyclient = 1, var_1a757e02 = 1) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    if (!function_5e921c3b(networkid)) {
        return 0;
    }
    item = get_inventory_item(networkid);
    if (!isdefined(item)) {
        return 0;
    }
    itementry = item.itementry;
    itemtype = itementry.itemtype;
    if (itemtype == #"weapon") {
        return function_ff53b117(item, notifyclient, var_1a757e02);
    }
    if (itemtype == #"attachment") {
        return function_be27f92c(item, notifyclient);
    } else {
        if (itemtype == #"armor") {
            self armor::set_armor(0, 0, 1, 0);
        } else if (itemtype == #"equipment") {
            self thread function_57cf4e09(itementry, var_81b304a2);
        } else if (itemtype == #"health") {
            self thread function_7fd7547(itementry, var_81b304a2);
        }
        if (notifyclient) {
            self function_2aa9e8ea(5, networkid);
        }
        return 1;
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xfae3ae70, Offset: 0x87b8
// Size: 0x440
function function_ff53b117(item, notifyclient = 1, var_1a757e02 = 1) {
    assert(isplayer(self));
    assert(isstruct(item));
    itemtype = item.itementry.itemtype;
    networkid = item.networkid;
    function_eb6af9ef(networkid);
    if (isdefined(item.attachments) && var_1a757e02) {
        attachmentitems = [];
        foreach (attachment in item.attachments) {
            attachmentitem = get_inventory_item(attachment.networkid);
            attachmentitems[attachmentitems.size] = attachmentitem;
        }
        foreach (attachmentitem in attachmentitems) {
            function_be27f92c(attachmentitem, 1);
        }
    }
    weapon = item_inventory_util::function_370ccb8a(item);
    if (get_weapon_count() > 1) {
        self takeweapon(weapon);
        foreach (slotid in array(14 + 1, 14 + 1 + 6 + 1)) {
            if (self.inventory.items[slotid].networkid != 32767 && self.inventory.items[slotid].networkid != item.networkid) {
                altweapon = item_inventory_util::function_370ccb8a(self.inventory.items[slotid]);
                self switchtoweapon(altweapon, 1);
                self.currentweapon = altweapon;
                break;
            }
        }
    } else {
        self replace_weapon(weapon, level.weaponbasemeleeheld, 1);
        if (weapon == self.currentweapon) {
            self switchtoweapon(level.weaponbasemeleeheld, 1);
            self.currentweapon = level.weaponbasemeleeheld;
        }
    }
    self clearstowedweapon();
    if (notifyclient) {
        self function_2aa9e8ea(5, networkid);
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xde22a5c6, Offset: 0x8c00
// Size: 0x272
function use_inventory_item(networkid, usecount = 1, var_81b304a2 = 1) {
    self endon(#"death");
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            self.inventory.items[i].count = self.inventory.items[i].count - usecount;
            if (self.inventory.items[i].count < 0) {
                self.inventory.items[i].count = 0;
                break;
            }
            self function_2aa9e8ea(7, networkid, self.inventory.items[i].count);
            function_56cf65bc(self, self.inventory.items[i]);
            if (self.inventory.items[i].count <= 0) {
                if (var_81b304a2) {
                    wait 1;
                }
                while (isdefined(self) && self function_5822b2f2()) {
                    waitframe(1);
                }
                if (!isdefined(self)) {
                    return;
                }
                remove_inventory_item(networkid, var_81b304a2);
                break;
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x59f37f9c, Offset: 0x8e80
// Size: 0x16c
function function_66080f9d() {
    assert(isentity(self));
    if (!isentity(self)) {
        return;
    }
    self waittill(#"hash_363004a4e0ccc1f", #"death", #"stationary");
    if (!isdefined(self) || self.health <= 0) {
        return;
    }
    angles = self.angles;
    origin = self.origin;
    dropitem = item_drop::drop_item(undefined, 1, 0, self.id, origin, angles);
    if (isdefined(dropitem)) {
        dropitem.angles = angles;
        dropitem.origin = origin;
    }
    util::wait_network_frame(1);
    if (isdefined(self)) {
        self delete();
        arrayremovevalue(level.item_vehicles, undefined, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xfb092bdb, Offset: 0x8ff8
// Size: 0x36c
function use_killstreak(networkid, item) {
    assert(isplayer(self));
    assert(isdefined(item));
    self endon(#"death");
    if (self isinvehicle()) {
        return;
    }
    traceresults = self function_65c2da47(item.itementry.weapon);
    if (traceresults.isvalid && traceresults.waterdepth <= 0) {
        vehicletype = item.itementry.vehicle;
        remoteweapon = getweapon(#"warzone_remote");
        if (self hasweapon(remoteweapon)) {
            return;
        }
        self giveweapon(remoteweapon);
        self switchtoweapon(remoteweapon);
        self waittill(#"weapon_change", #"death");
        vehicle = spawnvehicle(vehicletype, traceresults.origin, traceresults.angles);
        if (isdefined(vehicle.vehicleclass) && vehicle.vehicleclass == #"helicopter") {
            vehicle.origin += (0, 0, vehicle.height);
        }
        level.item_vehicles[level.item_vehicles.size] = vehicle;
        util::wait_network_frame(1);
        if (isdefined(vehicle)) {
            vehicle.id = item.id;
            if (isdefined(vehicle.vehicleclass) && vehicle.vehicleclass != #"helicopter") {
                vehicle thread function_66080f9d();
            }
            remove_inventory_item(networkid);
            vehicle usevehicle(self, 0);
            self waittill(#"exit_vehicle");
        }
        self takeweapon(remoteweapon);
        return;
    }
    self sethintstring(#"hash_37605398dce96965");
    wait 1.5;
    if (isdefined(self)) {
        self sethintstring(#"");
    }
}

