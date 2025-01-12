#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_inventory_util;
#using scripts\mp_common\item_world;
#using scripts\mp_common\item_world_util;

#namespace item_inventory;

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x2
// Checksum 0x9522e36b, Offset: 0x518
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"item_inventory", &__init__, undefined, #"item_world");
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x1088e67, Offset: 0x568
// Size: 0xd4
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    callback::on_localplayer_spawned(&_on_localplayer_spawned);
    clientfield::register("clientuimodel", "hudItems.multiItemPickup.status", 1, 2, "int", &function_80edf4b0, 1, 1);
    level thread function_c1b03b5();
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x7054f68b, Offset: 0x648
// Size: 0x9c
function private _on_localplayer_spawned(localclientnum) {
    if (self function_40efd9db()) {
        self thread function_bbd13033(localclientnum);
        self thread function_d3131b6d(localclientnum);
        self thread function_aae2ca00(localclientnum);
        self thread function_f56249de(localclientnum);
        self thread function_739e77a1(localclientnum);
    }
}

// Namespace item_inventory/item_inventory
// Params 7, eflags: 0x4
// Checksum 0x4b26f680, Offset: 0x6f0
// Size: 0x7a
function private function_80edf4b0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    clientdata = item_world::function_72b37ae5(localclientnum);
    if (newval == 2) {
        clientdata.var_aba7ed44 = 1;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x8d8e774a, Offset: 0x778
// Size: 0x5e
function private function_63a88614(localclientnum) {
    if (function_426e193(localclientnum)) {
        return false;
    }
    if (isgrappling(localclientnum)) {
        return false;
    }
    if (function_32180a50(localclientnum)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xd8e52f0, Offset: 0x7e0
// Size: 0x150
function private function_aae2ca00(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("645627a529866d9f");
    self endon("645627a529866d9f");
    clientdata = item_world::function_72b37ae5(localclientnum);
    var_3a37c990 = "inventory_equip" + localclientnum;
    var_4481044b = "inventory_detach" + localclientnum;
    while (true) {
        waitresult = level waittill(var_3a37c990, var_4481044b);
        if (waitresult._notify === var_3a37c990) {
            networkid = waitresult.id;
            function_4306a69(localclientnum, 2, networkid);
            continue;
        }
        if (waitresult._notify === var_4481044b) {
            networkid = waitresult.id;
            function_4306a69(localclientnum, 4, networkid);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x9ff4bbdf, Offset: 0x938
// Size: 0x98
function private function_125223a1(localclientnum, inventoryitem) {
    weapon = item_world_util::function_fe2abb62(inventoryitem.itementry);
    if (!isdefined(weapon)) {
        return 1;
    }
    if (weapon == getcurrentweapon(localclientnum) || weapon == function_3a909b8c(localclientnum)) {
        return function_63a88614(localclientnum);
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x6a34a465, Offset: 0x9d8
// Size: 0x370
function private function_d3131b6d(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("52d5dbc8e3b15aa3");
    self endon("52d5dbc8e3b15aa3");
    clientdata = item_world::function_72b37ae5(localclientnum);
    var_8bef4af9 = "inventory_drop" + localclientnum;
    var_6b5685de = "inventory_drop_current_weapon" + localclientnum;
    var_9d3e6f6c = "inventory_drop_current_weapon_and_detach" + localclientnum;
    while (true) {
        waitresult = level waittill(var_8bef4af9, var_6b5685de, var_9d3e6f6c);
        if (waitresult._notify === var_8bef4af9) {
            networkid = waitresult.id;
            count = waitresult.extraarg;
            itemid = item_world::function_3f8df821(localclientnum, networkid);
            if (itemid != 32767) {
                if (function_b93f8df2(waitresult.selectedindex)) {
                    inventoryitem = clientdata.inventory.items[waitresult.selectedindex];
                    if (isdefined(inventoryitem) && !function_125223a1(localclientnum, inventoryitem)) {
                        continue;
                    }
                }
                var_df820318 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.droppedItem");
                item = function_9c3c6ff2(itemid);
                itemname = item_world::get_item_name(item.itementry);
                if (!setuimodelvalue(var_df820318, itemname)) {
                    forcenotifyuimodel(var_df820318);
                }
            }
            function_4306a69(localclientnum, 3, networkid, count);
            continue;
        }
        if (waitresult._notify === var_6b5685de) {
            weaponslotid = function_83dd5725(localclientnum);
            networkid = item_world_util::function_5a578f3(self, weaponslotid);
            function_4306a69(localclientnum, 3, networkid);
            continue;
        }
        if (waitresult._notify === var_9d3e6f6c) {
            weaponslotid = function_83dd5725(localclientnum);
            networkid = item_world_util::function_5a578f3(self, weaponslotid);
            function_4306a69(localclientnum, 6, networkid);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x98c059f9, Offset: 0xd50
// Size: 0x484
function private function_f56249de(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("300b672422bbe298");
    self endon("300b672422bbe298");
    clientdata = item_world::function_72b37ae5(localclientnum);
    var_dee2db08 = "inventory_item_focus" + localclientnum;
    while (true) {
        waitresult = level waittill(var_dee2db08);
        data = item_world::function_72b37ae5(localclientnum);
        for (index = 0; index < data.inventory.items.size; index++) {
            item = data.inventory.items[index];
            setuimodelvalue(getuimodel(item.itemuimodel, "focusTarget"), 0);
            setuimodelvalue(getuimodel(item.itemuimodel, "notAvailable"), 0);
        }
        if (waitresult._notify !== var_dee2db08) {
            continue;
        }
        networkid = waitresult.id;
        data.inventory.var_995a6f09 = networkid;
        if (networkid === 32767) {
            continue;
        }
        inventoryitem = function_73565dbf(localclientnum, networkid);
        if (inventoryitem.itementry.itemtype !== #"attachment") {
            continue;
        }
        var_a0e2360f = function_83dd5725(localclientnum);
        foreach (weaponslotid in array(14 + 1, 14 + 1 + 6 + 1)) {
            weaponitem = data.inventory.items[weaponslotid];
            if (weaponitem.id === 32767) {
                continue;
            }
            var_e0d49b9b = item_inventory_util::function_82cb86b6(inventoryitem.itementry);
            var_7bae3009 = item_inventory_util::function_e7a671d8(weaponslotid, var_e0d49b9b);
            attachmentname = item_inventory_util::function_580900d1(weaponitem, inventoryitem.itementry);
            var_be25f677 = data.inventory.items[var_7bae3009];
            if (isdefined(attachmentname)) {
                setuimodelvalue(getuimodel(var_be25f677.itemuimodel, "focusTarget"), 1);
                continue;
            }
            setuimodelvalue(getuimodel(var_be25f677.itemuimodel, "notAvailable"), 1);
            if (weaponslotid === var_a0e2360f) {
                setuimodelvalue(getuimodel(inventoryitem.itemuimodel, "notAvailable"), 1);
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xe6a0750f, Offset: 0x11e0
// Size: 0x178
function private function_739e77a1(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("620cffbea376efb2");
    self endon("620cffbea376efb2");
    clientdata = item_world::function_72b37ae5(localclientnum);
    var_b396fb8e = "attachment_pickup";
    while (true) {
        waitresult = self waittill(var_b396fb8e);
        currentitem = self.var_a582c9fe;
        if (!isdefined(currentitem) || !isdefined(currentitem.itementry)) {
            continue;
        }
        if (distance2dsquared(self.origin, currentitem.origin) > 128 * 128 || abs(self.origin[2] - currentitem.origin[2]) > 64) {
            continue;
        }
        function_4306a69(localclientnum, 5, currentitem.networkid);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x5a966e05, Offset: 0x1360
// Size: 0xe2
function private function_b93f8df2(slotid) {
    assert(isint(slotid));
    foreach (slot in array(10, 11, 12, 13, 14 + 1, 14 + 1 + 6 + 1)) {
        if (slot == slotid) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xe129a3d7, Offset: 0x1450
// Size: 0x370
function private function_c1b03b5() {
    level endon(#"shutdown");
    waitframe(1);
    while (true) {
        players = getlocalplayers();
        time = gettime();
        foreach (player in players) {
            if (!isalive(player)) {
                continue;
            }
            localclientnum = player getlocalclientnumber();
            if (!isdefined(localclientnum)) {
                continue;
            }
            data = item_world::function_72b37ae5(localclientnum);
            if (!isdefined(data)) {
                continue;
            }
            consumed = data.inventory.consumed;
            var_5f76f521 = data.inventory.consumed.items;
            var_72da04d8 = 0;
            for (i = 0; i < var_5f76f521.size; i++) {
                item = var_5f76f521[i];
                if (item.endtime <= time) {
                    var_72da04d8 = 1;
                    arrayremoveindex(var_5f76f521, i);
                    playsound(localclientnum, #"hash_4c7a6e162e2f26a0");
                    continue;
                }
            }
            for (i = 0; i < var_5f76f521.size; i++) {
                item = var_5f76f521[i];
                duration = item.endtime - item.starttime;
                timeremaining = item.endtime - time;
                if (var_72da04d8) {
                    item.itemuimodel = createuimodel(consumed.uimodel, "item" + i);
                    function_9c0f4c30(localclientnum, item, item.networkid, item.id, 0, 0);
                }
                setuimodelvalue(createuimodel(item.itemuimodel, "endStartFraction"), 1 - timeremaining / duration, 0);
            }
            if (var_72da04d8) {
                setuimodelvalue(consumed.var_f6bd7227, var_5f76f521.size);
            }
        }
        players = undefined;
        waitframe(1);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x72a0af9, Offset: 0x17c8
// Size: 0x72
function private function_cfadf86a(itementry) {
    if (isdefined(itementry) && isdefined(itementry.weapon)) {
        return (isdefined(itementry.weapon.name) ? itementry.weapon.name : #"");
    }
    return #"";
}

// Namespace item_inventory/item_inventory
// Params 6, eflags: 0x4
// Checksum 0xb960d008, Offset: 0x1848
// Size: 0x12b4
function private function_9c0f4c30(localclientnum, inventoryitem, networkid, itemid, count, availableaction) {
    data = undefined;
    if (itemid == 32767 && isdefined(inventoryitem.networkid) && inventoryitem.networkid != 32767) {
        data = level.var_b0afee79[localclientnum];
    } else if (itemid != 32767 && inventoryitem.networkid === 32767) {
        data = level.var_b0afee79[localclientnum];
    }
    var_3af82dc8 = 0;
    if (inventoryitem.id === itemid && isdefined(inventoryitem.count) && inventoryitem.count > count) {
        var_3af82dc8 = 1;
    }
    player = function_609b5d7a(localclientnum);
    var_9ffb2f6f = isdefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype === #"attachment";
    inventoryitem.id = itemid;
    inventoryitem.networkid = networkid;
    inventoryitem.count = count;
    inventoryitem.itementry = 32767 == itemid ? undefined : function_9c3c6ff2(itemid).itementry;
    inventoryitem.availableaction = availableaction;
    inventoryitem.consumable = isdefined(inventoryitem.itementry) ? inventoryitem.itementry.consumable : undefined;
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "id"), inventoryitem.networkid);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stackCount"), count);
    if (itemid == 32767) {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "name"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "icon"), #"blacktransparent");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rarity"), "None");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "consumable"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "assetName"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "description"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "type"), "");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "equipped"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "endStartFraction"), 0, 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "disabled"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAvailable"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "focusTarget"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "armorMax"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "hasAttachments"), 0);
    } else {
        if (isdefined(inventoryitem.itementry) && inventoryitem.itementry.itemtype == #"resource") {
            inventoryuimodel = getuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
            setuimodelvalue(getuimodel(inventoryuimodel, "resourceCount"), 1);
        }
        item = function_9c3c6ff2(itemid);
        setuimodelvalue(getuimodel(inventoryitem.itemuimodel, "name"), item_world::get_item_name(item.itementry));
        setuimodelvalue(getuimodel(inventoryitem.itemuimodel, "icon"), isdefined(item.itementry.icon) ? item.itementry.icon : #"blacktransparent");
        setuimodelvalue(getuimodel(inventoryitem.itemuimodel, "rarity"), isdefined(item.itementry.rarity) ? item.itementry.rarity : "None");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "assetName"), function_cfadf86a(item.itementry));
        armormax = 0;
        if (isdefined(item.itementry) && item.itementry.itemtype == #"armor") {
            armormax = isdefined(item.itementry.amount) ? item.itementry.amount : 0;
        }
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "armorMax"), armormax);
        description = isdefined(item.itementry.description) ? item.itementry.description : #"";
        if (description == #"" && isdefined(item.itementry.weapon)) {
            itemindex = getitemindexfromref(item.itementry.weapon.name);
            var_ea73fd78 = getunlockableiteminfofromindex(itemindex);
            if (isdefined(var_ea73fd78) && isdefined(var_ea73fd78.description)) {
                description = var_ea73fd78.description;
            }
        }
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "description"), description);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "type"), item.itementry.itemtype);
        setuimodelvalue(getuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
        setuimodelvalue(getuimodel(inventoryitem.itemuimodel, "consumable"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "disabled"), 0);
        if (count != 0 && !var_3af82dc8) {
            function_b01e420f(localclientnum, item.itementry);
        }
    }
    if (isdefined(data)) {
        canusequickinventory = 0;
        filledslots = 0;
        for (i = 0; i < data.inventory.var_7d6932b1; i++) {
            if (data.inventory.items[i].networkid != 32767) {
                if (data.inventory.items[i].availableaction == 1 || data.inventory.items[i].availableaction == 4) {
                    canusequickinventory |= 1;
                }
                filledslots++;
            }
        }
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.filledSlots"), filledslots);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.canUseQuickInventory"), canusequickinventory);
        if (itemid !== 32767 && inventoryitem.itementry.itemtype === #"weapon") {
            foreach (weaponslotid in array(14 + 1, 14 + 1 + 6 + 1)) {
                if (data.inventory.items[weaponslotid].networkid === networkid) {
                    attachmentslots = array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock");
                    foreach (index, attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
                        slot = attachmentslots[index];
                        var_7bae3009 = item_inventory_util::function_e7a671d8(weaponslotid, attachmentoffset);
                        attachmentitem = data.inventory.items[var_7bae3009];
                        if (!isdefined(inventoryitem.itementry.(slot))) {
                            setuimodelvalue(createuimodel(attachmentitem.itemuimodel, "disabled"), 1);
                            continue;
                        }
                        setuimodelvalue(createuimodel(attachmentitem.itemuimodel, "disabled"), 0);
                    }
                    break;
                }
            }
        }
        if (itemid !== 32767 && inventoryitem.itementry.itemtype === #"attachment") {
            var_7bae3009 = item_world_util::function_5b57f1f9(player, inventoryitem.networkid);
            var_50abaf89 = undefined;
            foreach (weaponslotid in array(14 + 1, 14 + 1 + 6 + 1)) {
                if (item_inventory_util::function_c32bed23(weaponslotid, var_7bae3009)) {
                    var_50abaf89 = weaponslotid;
                    break;
                }
            }
            if (isdefined(var_50abaf89)) {
                function_992a69e0(localclientnum, var_50abaf89, inventoryitem);
                hasattachments = has_attachments(localclientnum, var_50abaf89);
                var_87e8421e = data.inventory.items[var_50abaf89];
                if (hasattachments) {
                    setuimodelvalue(getuimodel(var_87e8421e.itemuimodel, "hasAttachments"), 1);
                } else {
                    setuimodelvalue(getuimodel(var_87e8421e.itemuimodel, "hasAttachments"), 0);
                }
            }
            return;
        }
        if (var_9ffb2f6f) {
            var_a0e2360f = player function_83dd5725(localclientnum);
            hasattachments = has_attachments(localclientnum, var_a0e2360f);
            var_87e8421e = data.inventory.items[var_a0e2360f];
            if (hasattachments) {
                setuimodelvalue(getuimodel(var_87e8421e.itemuimodel, "hasAttachments"), 1);
                return;
            }
            setuimodelvalue(getuimodel(var_87e8421e.itemuimodel, "hasAttachments"), 0);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x4
// Checksum 0xa8c00d0d, Offset: 0x2b08
// Size: 0x324
function private function_992a69e0(localclientnum, var_a0e2360f, var_3088cb63) {
    data = item_world::function_72b37ae5(localclientnum);
    var_779f2051 = data.inventory.items[var_a0e2360f];
    noweapon = var_779f2051.networkid === 32767;
    if (var_3088cb63.networkid === 32767) {
        return;
    }
    if (var_3088cb63.itementry.itemtype !== #"attachment") {
        return;
    }
    if (noweapon) {
        setuimodelvalue(getuimodel(var_3088cb63.itemuimodel, "availableAction"), 0);
        return;
    }
    attachmentname = item_inventory_util::function_580900d1(var_779f2051, var_3088cb63.itementry);
    if (isdefined(attachmentname)) {
        var_e0d49b9b = item_inventory_util::function_82cb86b6(var_3088cb63.itementry);
        var_7bae3009 = item_inventory_util::function_e7a671d8(var_a0e2360f, var_e0d49b9b);
        if (data.inventory.items[var_7bae3009].networkid !== 32767) {
            setuimodelvalue(getuimodel(var_3088cb63.itemuimodel, "availableAction"), 3);
        } else {
            setuimodelvalue(getuimodel(var_3088cb63.itemuimodel, "availableAction"), 2);
        }
        if (data.inventory.var_995a6f09 === var_3088cb63.networkid) {
            setuimodelvalue(getuimodel(var_3088cb63.itemuimodel, "notAvailable"), 0);
        }
        return;
    }
    setuimodelvalue(getuimodel(var_3088cb63.itemuimodel, "availableAction"), 0);
    if (data.inventory.var_995a6f09 === var_3088cb63.networkid) {
        setuimodelvalue(getuimodel(var_3088cb63.itemuimodel, "notAvailable"), 1);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xe5ceb740, Offset: 0x2e38
// Size: 0x60
function is_inventory_item(localclientnum, itementry) {
    data = item_world::function_72b37ae5(localclientnum);
    if (itementry.itemtype == #"ammo") {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0xcdcc96f4, Offset: 0x2ea0
// Size: 0x2c
function private function_d19437c(localclientnum, itementry) {
    return isdefined(function_81db00d5(localclientnum, itementry));
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x50254822, Offset: 0x2ed8
// Size: 0x258
function function_81db00d5(localclientnum, itementry) {
    if (!(isdefined(itementry.stackable) && itementry.stackable)) {
        return undefined;
    }
    weapon = item_world_util::function_fe2abb62(itementry);
    maxstack = 1;
    if (!isdefined(weapon)) {
        maxstack = itementry.stackcount;
        if (!isdefined(maxstack)) {
            return undefined;
        }
    } else {
        maxstack = weapon.clipsize;
        if (weapon.name == #"eq_tripwire") {
            maxstack = 5;
        }
    }
    clientdata = item_world::function_72b37ae5(localclientnum);
    if (itementry.itemtype == #"resource") {
        if (clientdata.inventory.items[14].count < maxstack) {
            return 14;
        }
        return undefined;
    }
    for (i = 0; i < clientdata.inventory.items.size; i++) {
        if (!isdefined(clientdata.inventory.items[i].id) || clientdata.inventory.items[i].id == 32767) {
            continue;
        }
        inventoryitem = function_9c3c6ff2(clientdata.inventory.items[i].id);
        if (inventoryitem.itementry.name != itementry.name) {
            continue;
        }
        if (clientdata.inventory.items[i].count < maxstack) {
            return i;
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xfb87d8f9, Offset: 0x3138
// Size: 0x1d6
function private function_bbd13033(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("48bc6f79f0d3cf7a");
    self endon("48bc6f79f0d3cf7a");
    clientdata = item_world::function_72b37ae5(localclientnum);
    while (true) {
        waitresult = level waittill("multi_item_pickup" + localclientnum);
        if (self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
            networkid = waitresult.id;
            index = item_world::function_d6c5d0a2(clientdata.groupitems, networkid);
            itemid = item_world::function_3f8df821(localclientnum, networkid);
            if (itemid == 32767) {
                continue;
            }
            if (isdefined(index)) {
                item = function_9c3c6ff2(itemid);
                if (!function_ed433682(localclientnum, item.itementry)) {
                    continue;
                }
                function_4306a69(localclientnum, 1, networkid);
                function_a240c3ab(localclientnum, index);
                if (!is_inventory_item(localclientnum, item.itementry)) {
                    continue;
                }
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x3d674d3, Offset: 0x3318
// Size: 0x192
function private function_a7b84687(localclientnum, itementry) {
    if (!isdefined(itementry)) {
        return 0;
    }
    if (isdefined(itementry.consumable) && itementry.consumable) {
        return 4;
    }
    if (itementry.itemtype === #"generic") {
        return 0;
    }
    if (itementry.itemtype === #"killstreak") {
        return 4;
    }
    if (itementry.itemtype === #"armor") {
        return 0;
    }
    if (itementry.itemtype === #"ammo") {
        return 0;
    }
    if (itementry.itemtype == #"weapon") {
        return 0;
    }
    if (itementry.itemtype == #"quest") {
        return 0;
    }
    data = item_world::function_72b37ae5(localclientnum);
    if (isdefined(itementry.var_59637e5d)) {
        if (itementry.var_59637e5d != data.specialist) {
            return 0;
        }
    }
    if (itementry.itemtype === #"attachment") {
        return 2;
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x6af63a4b, Offset: 0x34b8
// Size: 0x162
function function_ed433682(localclientnum, itementry) {
    if (itementry.itemtype == #"weapon") {
        return true;
    }
    if (!is_inventory_item(localclientnum, itementry)) {
        return true;
    }
    if (itementry.itemtype == #"resource") {
        return true;
    }
    if (itementry.itemtype == #"armor") {
        return true;
    }
    if (function_62c0f1d9(localclientnum, itementry)) {
        return true;
    }
    if (function_d19437c(localclientnum, itementry)) {
        return true;
    }
    data = item_world::function_72b37ae5(localclientnum);
    for (i = 0; i < data.inventory.var_7d6932b1; i++) {
        if (data.inventory.items[i].networkid === 32767) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xc8064c37, Offset: 0x3628
// Size: 0x1ae
function function_62c0f1d9(localclientnum, itementry) {
    data = item_world::function_72b37ae5(localclientnum);
    switch (itementry.itemtype) {
    case #"attachment":
        slotid = function_31d52d17(localclientnum, itementry);
        if (!isdefined(slotid)) {
            return false;
        }
        return (data.inventory.items[slotid].networkid == 32767);
    case #"armor":
        return (data.inventory.items[11].networkid == 32767);
    case #"backpack":
        return (data.inventory.items[13].networkid == 32767);
    case #"equipment":
        return (data.inventory.items[12].networkid == 32767);
    case #"health":
        return (data.inventory.items[10].networkid == 32767);
    case #"weapon":
        return (data.inventory.items[14 + 1].networkid == 32767 || data.inventory.items[14 + 1 + 6 + 1].networkid == 32767);
    case #"ammo":
    case #"generic":
    case #"killstreak":
    default:
        return false;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x64c83b80, Offset: 0x3890
// Size: 0xfc
function function_83dd5725(localclientnum) {
    assert(self isplayer());
    var_c6906330 = 0;
    foreach (attachment in self.weapon.attachments) {
        if (attachment == #"null") {
            var_c6906330 = 1;
            break;
        }
    }
    return var_c6906330 ? 14 + 1 + 6 + 1 : 14 + 1;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xee4dec82, Offset: 0x3998
// Size: 0x26c
function function_2b4af13f(localclientnum, itementry) {
    assert(self isplayer());
    data = item_world::function_72b37ae5(localclientnum);
    switch (itementry.itemtype) {
    case #"armor":
        if (data.inventory.items[11].networkid == 32767) {
            return 11;
        }
        break;
    case #"backpack":
        if (data.inventory.items[13].networkid == 32767) {
            return 13;
        }
        break;
    case #"equipment":
        if (data.inventory.items[12].networkid == 32767) {
            return 12;
        }
        break;
    case #"health":
        if (data.inventory.items[10].networkid == 32767) {
            return 10;
        }
        break;
    case #"weapon":
        if (data.inventory.items[14 + 1].networkid == 32767) {
            return (14 + 1);
        } else if (data.inventory.items[14 + 1 + 6 + 1].networkid == 32767) {
            return (14 + 1 + 6 + 1);
        }
        break;
    }
    if (itementry.itemtype == #"attachment") {
        return function_31d52d17(localclientnum, itementry);
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x74c94163, Offset: 0x3c10
// Size: 0x244
function function_834a9503(localclientnum, itemid, count = 1, slotid = undefined) {
    assert(isint(itemid));
    itementry = function_9c3c6ff2(itemid).itementry;
    availableaction = function_a7b84687(localclientnum, itementry);
    data = item_world::function_72b37ae5(localclientnum);
    selectedindex = undefined;
    if (count == 0) {
        return;
    }
    if (!isdefined(selectedindex) && isdefined(slotid)) {
        selectedindex = slotid;
    }
    if (!isdefined(selectedindex)) {
        selectedindex = item_world::function_d6c5d0a2(data.inventory.items, 32767);
        if (!isdefined(selectedindex)) {
            println("<dev string:x30>" + itemid + "<dev string:x6f>");
            return;
        }
    }
    player = function_609b5d7a(localclientnum);
    networkid = item_world_util::function_5a578f3(player, selectedindex);
    inventoryitem = undefined;
    if (selectedindex < data.inventory.items.size) {
        inventoryitem = data.inventory.items[selectedindex];
    }
    assert(isdefined(inventoryitem));
    player function_9c0f4c30(localclientnum, inventoryitem, networkid, itemid, count, availableaction);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x75935bb9, Offset: 0x3e60
// Size: 0x184
function function_31d52d17(localclientnum, itementry) {
    assert(self isplayer());
    data = item_world::function_72b37ae5(localclientnum);
    if (itementry.itemtype == #"attachment") {
        weaponslotid = function_83dd5725(localclientnum);
        if (!isdefined(weaponslotid)) {
            return;
        }
        var_5317ff5e = item_world_util::function_5a578f3(self, weaponslotid);
        if (data.inventory.items[weaponslotid].networkid == 32767) {
            return;
        }
        var_e0d49b9b = item_inventory_util::function_82cb86b6(itementry);
        var_7bae3009 = item_inventory_util::function_e7a671d8(weaponslotid, var_e0d49b9b);
        weaponitem = self function_73565dbf(localclientnum, var_5317ff5e);
        attachmentname = item_inventory_util::function_580900d1(weaponitem, itementry);
        if (isdefined(attachmentname)) {
            return var_7bae3009;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xf35676fb, Offset: 0x3ff0
// Size: 0x146
function can_pickup_ammo(localclientnum, item, ammoamount = undefined) {
    assert(self isplayer());
    itementry = item.itementry;
    ammoweapon = itementry.weapon;
    ammoamount = isdefined(itementry.amount) ? itementry.amount : isdefined(ammoamount) ? ammoamount : 1;
    maxstockammo = ammoweapon.maxammo;
    currentammostock = self getweaponammostock(localclientnum, ammoweapon);
    var_b0503a4f = maxstockammo - currentammostock;
    addammo = int(min(ammoamount, var_b0503a4f));
    return addammo > 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xcd585bc3, Offset: 0x4140
// Size: 0x244
function consume_item(localclientnum, networkid) {
    data = item_world::function_72b37ae5(localclientnum);
    item = function_73565dbf(localclientnum, networkid);
    var_381bf393 = data.inventory.consumed.items.size;
    consumeditem = spawnstruct();
    consumeditem.id = item.id;
    consumeditem.itementry = item.itementry;
    consumeditem.starttime = gettime();
    consumeditem.endtime = consumeditem.starttime + int((isdefined(item.itementry.duration) ? item.itementry.duration : 0) * 1000);
    consumeditem.itemuimodel = createuimodel(data.inventory.consumed.uimodel, "item" + var_381bf393);
    data.inventory.consumed.items[var_381bf393] = consumeditem;
    function_9c0f4c30(localclientnum, consumeditem, 32767, 32767, 0, 0);
    function_9c0f4c30(localclientnum, consumeditem, networkid, item.id, 0, 0);
    setuimodelvalue(data.inventory.consumed.var_f6bd7227, data.inventory.consumed.items.size);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x7c1a3b1b, Offset: 0x4390
// Size: 0x94
function function_a240c3ab(localclientnum, index) {
    var_6d11a68c = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup");
    setuimodelvalue(createuimodel(var_6d11a68c, "item" + index + ".disabled"), 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x72d13e6f, Offset: 0x4430
// Size: 0x142
function function_637c4d2f(localclientnum, networkid) {
    if (networkid == item_world_util::function_5a578f3(function_609b5d7a(localclientnum), 13)) {
        give_backpack(localclientnum, networkid);
        return;
    }
    data = item_world::function_72b37ae5(localclientnum);
    foreach (inventoryitem in data.inventory.items) {
        if (inventoryitem.networkid === networkid) {
            function_4f7c0c40(inventoryitem, 1);
            playsound(localclientnum, #"hash_4d31bd9927d823c3");
            return;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x48af801e, Offset: 0x4580
// Size: 0xdc
function give_backpack(localclientnum, networkid) {
    data = item_world::function_72b37ae5(localclientnum);
    if (data.inventory.var_7d6932b1 != 10) {
        data.inventory.var_7d6932b1 = 10;
        inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
        setuimodelvalue(createuimodel(inventoryuimodel, "count"), data.inventory.var_7d6932b1);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x103b6456, Offset: 0x4668
// Size: 0x108
function function_73565dbf(localclientnum, networkid) {
    assert(isdefined(localclientnum));
    assert(item_world_util::function_9628594b(networkid));
    data = item_world::function_72b37ae5(localclientnum);
    assert(isdefined(data));
    for (index = 0; index < data.inventory.items.size; index++) {
        inventoryitem = data.inventory.items[index];
        if (inventoryitem.networkid === networkid) {
            return inventoryitem;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xe7a50ba3, Offset: 0x4778
// Size: 0x50
function function_2f6c4f55(localclientnum, networkid) {
    item = function_73565dbf(localclientnum, networkid);
    if (isdefined(item)) {
        return item.id;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xa3690bf1, Offset: 0x47d0
// Size: 0x12c
function has_attachments(localclientnum, weaponslotid) {
    assert(isdefined(localclientnum));
    data = item_world::function_72b37ae5(localclientnum);
    foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
        slotid = item_inventory_util::function_e7a671d8(weaponslotid, attachmentoffset);
        if (data.inventory.items[slotid].networkid != 32767) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xd1f9b3c, Offset: 0x4908
// Size: 0x85c
function inventory_init(localclientnum) {
    data = item_world::function_72b37ae5(localclientnum);
    inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
    pickedupammotypes = createuimodel(inventoryuimodel, "pickedUpAmmoTypes");
    setuimodelvalue(createuimodel(pickedupammotypes, "count"), 0);
    data.inventory = spawnstruct();
    data.inventory.consumed = {};
    data.inventory.consumed.items = [];
    data.inventory.count = 14 + 1 + 6 + 1 + 6 + 1;
    data.inventory.items = [];
    data.inventory.var_257505c7 = 0;
    data.inventory.var_7d6932b1 = 5;
    for (index = 0; index < data.inventory.count; index++) {
        data.inventory.items[index] = spawnstruct();
    }
    for (index = 0; index < 5; index++) {
        data.inventory.items[index].itemuimodel = createuimodel(inventoryuimodel, "item" + index);
        setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "backpackSlot"), 0);
    }
    for (index = 5; index < 10; index++) {
        data.inventory.items[index].itemuimodel = createuimodel(inventoryuimodel, "item" + index);
        setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "backpackSlot"), 1);
    }
    data.inventory.items[10].itemuimodel = createuimodel(inventoryuimodel, "health");
    data.inventory.items[11].itemuimodel = createuimodel(inventoryuimodel, "gear");
    data.inventory.items[13].itemuimodel = createuimodel(inventoryuimodel, "storage");
    data.inventory.items[12].itemuimodel = createuimodel(inventoryuimodel, "equipment");
    data.inventory.items[14].itemuimodel = createuimodel(inventoryuimodel, "resource0");
    weaponslots = array(14 + 1, 14 + 1 + 6 + 1);
    for (index = 0; index < weaponslots.size; index++) {
        weaponslotid = weaponslots[index];
        data.inventory.items[weaponslotid].itemuimodel = createuimodel(inventoryuimodel, "weapon" + index);
        var_8f8fd69e = array(1, 2, 3, 4, 5, 6);
        for (attachmentindex = 0; attachmentindex < var_8f8fd69e.size; attachmentindex++) {
            attachmentoffset = var_8f8fd69e[attachmentindex];
            var_7bae3009 = item_inventory_util::function_e7a671d8(weaponslotid, attachmentoffset);
            uimodelindex = attachmentindex + index * var_8f8fd69e.size;
            data.inventory.items[var_7bae3009].itemuimodel = createuimodel(inventoryuimodel, "attachment" + uimodelindex);
        }
    }
    for (index = 0; index < data.inventory.items.size; index++) {
        if (!isdefined(data.inventory.items[index].itemuimodel)) {
            continue;
        }
        function_9c0f4c30(localclientnum, data.inventory.items[index], 32767, 32767, 0, 0);
    }
    setuimodelvalue(createuimodel(inventoryuimodel, "count"), 5);
    setuimodelvalue(createuimodel(inventoryuimodel, "filledSlots"), 0);
    setuimodelvalue(createuimodel(inventoryuimodel, "attachmentCount"), 6);
    setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 0);
    data.inventory.consumed.uimodel = createuimodel(inventoryuimodel, "consumed");
    data.inventory.consumed.var_f6bd7227 = createuimodel(data.inventory.consumed.uimodel, "count");
    setuimodelvalue(data.inventory.consumed.var_f6bd7227, 0);
    level thread function_9fbf259(localclientnum);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x76e7b588, Offset: 0x5170
// Size: 0x198
function function_9fbf259(localclientnum) {
    level flagsys::wait_till(#"item_world_initialized");
    foreach (ammotype in array(#"ammo_type_9mm_item", #"ammo_type_45_item", #"ammo_type_556_item", #"ammo_type_762_item", #"ammo_type_338_item", #"ammo_type_50cal_item", #"ammo_type_12ga_item", #"ammo_type_rocket_item")) {
        point = function_a5758930(ammotype);
        if (isdefined(point) && isdefined(point.itementry) && point.itementry.itemtype == #"ammo") {
            function_f4f08c1c(localclientnum, point.id);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x7c842d52, Offset: 0x5310
// Size: 0x726
function function_c2d859ed(params) {
    if (isstruct(self)) {
        return;
    }
    if (!self function_40efd9db() || !self isplayer()) {
        return;
    }
    if (!isdefined(level.var_50e1b764) || !isdefined(level.var_50e1b764[params.localclientnum])) {
        if (!isdefined(level.var_85f01338)) {
            level.var_85f01338 = [];
        } else if (!isarray(level.var_85f01338)) {
            level.var_85f01338 = array(level.var_85f01338);
        }
        if (!isdefined(level.var_50e1b764)) {
            level.var_50e1b764 = [];
        } else if (!isarray(level.var_50e1b764)) {
            level.var_50e1b764 = array(level.var_50e1b764);
        }
        if (!isdefined(level.var_c134fbeb)) {
            level.var_c134fbeb = [];
        } else if (!isarray(level.var_c134fbeb)) {
            level.var_c134fbeb = array(level.var_c134fbeb);
        }
        if (!isdefined(level.var_78072960)) {
            level.var_78072960 = [];
        } else if (!isarray(level.var_78072960)) {
            level.var_78072960 = array(level.var_78072960);
        }
        level.var_85f01338[params.localclientnum] = createuimodel(getuimodelforcontroller(params.localclientnum), "hudItems.inventory.currentWeaponIndex");
        level.var_50e1b764[params.localclientnum] = createuimodel(getuimodelforcontroller(params.localclientnum), "hudItems.inventory.currentWeapon");
        level.var_c134fbeb[params.localclientnum] = createuimodel(getuimodelforcontroller(params.localclientnum), "hudItems.inventory.currentWeapon.ammoType");
        level.var_78072960[params.localclientnum] = createuimodel(getuimodelforcontroller(params.localclientnum), "hudItems.inventory.showAttachments");
    }
    if (isdefined(params.weapon)) {
        if (isdefined(params.weapon.statname) && params.weapon.statname != #"") {
            itemindex = getbaseweaponitemindex(getweapon(params.weapon.statname));
        } else {
            itemindex = getbaseweaponitemindex(params.weapon);
        }
        var_19447f5a = getweaponammotype(params.weapon);
        if (isdefined(level.var_11fa86c3) && isdefined(level.var_11fa86c3[var_19447f5a])) {
            setuimodelvalue(level.var_c134fbeb[params.localclientnum], level.var_11fa86c3[var_19447f5a]);
        }
        setuimodelvalue(level.var_50e1b764[params.localclientnum], itemindex);
        var_a0e2360f = self function_83dd5725(params.localclientnum);
        foreach (index, slot in array(14 + 1, 14 + 1 + 6 + 1)) {
            if (slot === var_a0e2360f) {
                setuimodelvalue(level.var_85f01338[params.localclientnum], index);
                break;
            }
        }
        networkid = item_world_util::function_5a578f3(self, var_a0e2360f);
        item = function_73565dbf(params.localclientnum, networkid);
        supportsattachments = 0;
        if (isdefined(item)) {
            supportsattachments = item_inventory_util::function_3b6b07b6(item);
        }
        setuimodelvalue(level.var_78072960[params.localclientnum], supportsattachments);
        data = item_world::function_72b37ae5(params.localclientnum);
        var_779f2051 = data.inventory.items[var_a0e2360f];
        for (itemindex = 0; itemindex < data.inventory.var_7d6932b1; itemindex++) {
            inventoryitem = data.inventory.items[itemindex];
            function_992a69e0(params.localclientnum, var_a0e2360f, inventoryitem);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xbba29dc2, Offset: 0x5a40
// Size: 0x9c
function function_b01e420f(localclientnum, item) {
    var_c4a439b5 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpItem");
    itemname = item_world::get_item_name(item);
    if (!setuimodelvalue(var_c4a439b5, itemname)) {
        forcenotifyuimodel(var_c4a439b5);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xd7ab510c, Offset: 0x5ae8
// Size: 0x4d4
function function_f4f08c1c(localclientnum, itemid) {
    if (!isdefined(level.var_11fa86c3)) {
        level.var_11fa86c3 = [];
    }
    assert(item_world_util::function_a04a2a1f(itemid));
    item = function_9c3c6ff2(itemid);
    if (!isdefined(item.itementry)) {
        return;
    }
    var_19447f5a = getweaponammotype(item.itementry.weapon);
    if (!isdefined(var_19447f5a) || item.itementry.itemtype !== #"ammo") {
        return;
    }
    var_c4a439b5 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpItem");
    var_fecbc78b = getuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory.pickedUpAmmoTypes");
    var_899b6514 = getuimodel(var_fecbc78b, "count");
    var_28eaab6c = getuimodelvalue(var_899b6514);
    for (i = 0; i < var_28eaab6c; i++) {
        var_7375f1e7 = getuimodel(var_fecbc78b, "" + i + 1);
        if (getuimodelvalue(getuimodel(var_7375f1e7, "assetName")) == var_19447f5a) {
            if (item.itementry.itemtype == #"ammo" && !getuimodelvalue(getuimodel(var_7375f1e7, "canDrop"))) {
                setuimodelvalue(createuimodel(var_7375f1e7, "id"), itemid);
                setuimodelvalue(createuimodel(var_7375f1e7, "canDrop"), item.itementry.itemtype == #"ammo");
            }
            return;
        }
    }
    level.var_11fa86c3[var_19447f5a] = item.itementry.displayname;
    var_7375f1e7 = createuimodel(var_fecbc78b, "" + var_28eaab6c + 1);
    setuimodelvalue(createuimodel(var_7375f1e7, "assetName"), var_19447f5a);
    setuimodelvalue(createuimodel(var_7375f1e7, "id"), itemid);
    setuimodelvalue(createuimodel(var_7375f1e7, "canDrop"), 1);
    setuimodelvalue(createuimodel(var_7375f1e7, "name"), item.itementry.displayname);
    setuimodelvalue(createuimodel(var_7375f1e7, "icon"), item.itementry.icon);
    setuimodelvalue(createuimodel(var_7375f1e7, "description"), item.itementry.description);
    setuimodelvalue(var_899b6514, var_28eaab6c + 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x53f0265c, Offset: 0x5fc8
// Size: 0x2b2
function function_516e33f1(localclientnum, item) {
    if (isdefined(item) && isdefined(item.origin) && isdefined(item.itementry)) {
        if (isdefined(item.itementry.var_cb796b7f)) {
            playsound(localclientnum, item.itementry.var_cb796b7f, item.origin);
            return;
        }
        switch (item.itementry.itemtype) {
        case #"weapon":
            playsound(localclientnum, #"hash_67fed8a52accbb23", item.origin);
            break;
        case #"ammo":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"health":
            playsound(localclientnum, #"hash_4d393a136d0df945", item.origin);
            break;
        case #"equipment":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"armor":
            playsound(localclientnum, #"hash_6bd51d5a531ff32", item.origin);
            break;
        case #"backpack":
            playsound(localclientnum, #"hash_60e9138ddc9660ed", item.origin);
            break;
        case #"attachment":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"generic":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x7916e66, Offset: 0x6288
// Size: 0x2b2
function function_f5a659d4(localclientnum, item) {
    if (isdefined(item) && isdefined(item.origin) && isdefined(item.itementry)) {
        if (isdefined(item.itementry.pickupsound)) {
            playsound(localclientnum, item.itementry.pickupsound, item.origin);
            return;
        }
        switch (item.itementry.itemtype) {
        case #"weapon":
            playsound(localclientnum, #"hash_62fabedcce13774c", item.origin);
            break;
        case #"ammo":
            playsound(localclientnum, #"hash_36c9bf9c68a692f6", item.origin);
            break;
        case #"health":
            playsound(localclientnum, #"hash_7cb9f9cf7068ccee", item.origin);
            break;
        case #"equipment":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        case #"armor":
            playsound(localclientnum, #"hash_2d8e1c5a5387840f", item.origin);
            break;
        case #"backpack":
            playsound(localclientnum, #"hash_69949bb7db9ef21e", item.origin);
            break;
        case #"attachment":
            playsound(localclientnum, #"hash_48ae9b1190e79fc5", item.origin);
            break;
        case #"generic":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x4a29877, Offset: 0x6548
// Size: 0x114
function function_7800f1d1(localclientnum, networkid) {
    data = item_world::function_72b37ae5(localclientnum);
    index = item_world::function_d6c5d0a2(data.inventory.items, networkid);
    if (!isdefined(index)) {
        println("<dev string:x97>" + networkid + "<dev string:xae>");
        return;
    }
    inventoryitem = data.inventory.items[index];
    function_9c0f4c30(localclientnum, inventoryitem, 32767, 32767, 0, 0);
    if (index == 13) {
        take_backpack(localclientnum, networkid);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x4abe69b8, Offset: 0x6668
// Size: 0xd4
function function_4f7c0c40(inventoryitem, equipped) {
    if (inventoryitem.itementry.itemtype == #"attachment" || inventoryitem.itementry.itemtype == #"weapon") {
        availableaction = inventoryitem.availableaction;
    } else {
        availableaction = inventoryitem.availableaction && !equipped;
    }
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x3ec0315, Offset: 0x6748
// Size: 0x1f4
function function_8882634(localclientnum, var_69bdab26, var_631e6a29) {
    assert(isdefined(var_69bdab26) && isdefined(var_631e6a29));
    data = item_world::function_72b37ae5(localclientnum);
    fromitem = data.inventory.items[var_69bdab26];
    toitem = data.inventory.items[var_631e6a29];
    var_799a40d2 = fromitem.networkid;
    var_982a8beb = fromitem.id;
    var_1ef84226 = fromitem.count;
    var_7c899e08 = fromitem.availableaction;
    player = function_609b5d7a(localclientnum);
    player function_9c0f4c30(localclientnum, fromitem, toitem.networkid != 32767 ? item_world_util::function_5a578f3(player, var_69bdab26) : 32767, toitem.id, toitem.count, toitem.availableaction);
    player function_9c0f4c30(localclientnum, toitem, var_799a40d2 != 32767 ? item_world_util::function_5a578f3(player, var_631e6a29) : 32767, var_982a8beb, var_1ef84226, var_7c899e08);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x5bd8d674, Offset: 0x6948
// Size: 0xdc
function take_backpack(localclientnum, networkid) {
    data = item_world::function_72b37ae5(localclientnum);
    if (data.inventory.var_7d6932b1 == 10) {
        data.inventory.var_7d6932b1 = 5;
        inventoryuimodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.inventory");
        setuimodelvalue(createuimodel(inventoryuimodel, "count"), data.inventory.var_7d6932b1);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x11d2c3db, Offset: 0x6a30
// Size: 0xd4
function function_a6b76462(localclientnum, networkid) {
    data = item_world::function_72b37ae5(localclientnum);
    foreach (inventoryitem in data.inventory.items) {
        if (inventoryitem.networkid === networkid) {
            function_4f7c0c40(inventoryitem, 0);
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xcd9af784, Offset: 0x6b10
// Size: 0x94
function update_inventory_item(localclientnum, networkid, value) {
    data = item_world::function_72b37ae5(localclientnum);
    player = function_609b5d7a(localclientnum);
    player function_c24f7cbe(localclientnum, data.inventory.items, networkid, value);
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x4
// Checksum 0x6fb929a1, Offset: 0x6bb0
// Size: 0x108
function private function_c24f7cbe(localclientnum, var_a60914d8, networkid, value) {
    foreach (inventoryslot, inventoryitem in var_a60914d8) {
        if (inventoryitem.networkid === networkid) {
            function_9c0f4c30(localclientnum, inventoryitem, inventoryitem.networkid, inventoryitem.id, value, inventoryitem.availableaction);
            function_4f7c0c40(inventoryitem, function_b93f8df2(inventoryslot));
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x61f211ce, Offset: 0x6cc0
// Size: 0x41c
function function_7a1ec24e(localclientnum) {
    assert(self isplayer());
    clientdata = item_world::function_72b37ae5(localclientnum);
    var_6d11a68c = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.multiItemPickup");
    var_d366f131 = createuimodel(var_6d11a68c, "count");
    if (isdefined(clientdata.groupitems)) {
        foreach (i, itemdef in clientdata.groupitems) {
            itemmodel = createuimodel(var_6d11a68c, "item" + i);
            setuimodelvalue(createuimodel(itemmodel, "id"), itemdef.networkid);
            if (itemdef.itementry.itemtype === #"ammo") {
                canpickup = self can_pickup_ammo(localclientnum, itemdef);
                setuimodelvalue(createuimodel(itemmodel, "disabled"), !canpickup);
            } else {
                setuimodelvalue(createuimodel(itemmodel, "disabled"), 0);
            }
            pickupicon = isdefined(itemdef.itementry.pickupicon) ? itemdef.itementry.pickupicon : itemdef.itementry.icon;
            setuimodelvalue(createuimodel(itemmodel, "icon"), isdefined(pickupicon) ? pickupicon : #"blacktransparent");
            setuimodelvalue(createuimodel(itemmodel, "rarity"), itemdef.itementry.rarity);
            setuimodelvalue(createuimodel(itemmodel, "name"), item_world::get_item_name(itemdef.itementry));
            setuimodelvalue(createuimodel(itemmodel, "claimsInventorySlot"), is_inventory_item(localclientnum, itemdef.itementry) && !function_d19437c(localclientnum, itemdef.itementry));
        }
        setuimodelvalue(var_d366f131, clientdata.groupitems.size);
        return;
    }
    setuimodelvalue(var_d366f131, 0);
}

