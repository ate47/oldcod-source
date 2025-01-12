#using script_2358831c5878ace3;
#using script_3d35e2ff167b3a82;
#using script_680dddbda86931fa;
#using script_7ebad89114ecedb1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace item_inventory;

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x6
// Checksum 0x5f5bae59, Offset: 0x988
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"item_inventory", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x4bfd1fe6, Offset: 0x9d8
// Size: 0x104
function private function_70a657d8() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    if (function_7d5553ac()) {
        return;
    }
    clientfield::register_clientuimodel("hudItems.healthItemstackCount", #"hash_6f4b11a0bee9b73d", #"healthitemstackcount", 1, 8, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.equipmentStackCount", #"hash_6f4b11a0bee9b73d", #"equipmentstackcount", 1, 8, "int", undefined, 0, 0);
    callback::on_localplayer_spawned(&_on_localplayer_spawned);
    level thread function_d2f05352();
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x81452a6f, Offset: 0xae8
// Size: 0x50
function function_7d5553ac() {
    return isdefined(getgametypesetting(#"hash_1cc3f98086d6f5dd")) ? getgametypesetting(#"hash_1cc3f98086d6f5dd") : 0;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x912e5704, Offset: 0xb40
// Size: 0xcc
function private _on_localplayer_spawned(localclientnum) {
    if (self function_da43934d()) {
        self thread function_3e624606(localclientnum);
        self thread function_ac4df751(localclientnum);
        self thread function_ca87f318(localclientnum);
        self thread function_7f35a045(localclientnum);
        self thread function_d1e6731e(localclientnum);
        self thread function_2ae9881d(localclientnum);
        self thread function_9b83c65d(localclientnum);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x77947caf, Offset: 0xc18
// Size: 0xfe
function private function_3fe6ef04(localclientnum) {
    data = item_world::function_a7e98a1a(localclientnum);
    var_cfa0e915 = [];
    foreach (consumeditem in data.inventory.consumed.items) {
        if (isdefined(var_cfa0e915[consumeditem.var_a6762160.name])) {
            continue;
        }
        var_cfa0e915[consumeditem.var_a6762160.name] = 1;
    }
    return var_cfa0e915.size;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x7d6bf632, Offset: 0xd20
// Size: 0x4e
function private function_88da0c8e(localclientnum) {
    paintcans = stats::get_stat_global(localclientnum, #"items_paint_cans_collected");
    return (isdefined(paintcans) ? paintcans : 0) >= 150;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xbfffcaca, Offset: 0xd78
// Size: 0x5e
function private function_99b22bbc(localclientnum) {
    if (function_96d4f30e(localclientnum)) {
        return false;
    }
    if (isgrappling(localclientnum)) {
        return false;
    }
    if (function_d5f07a6e(localclientnum)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xc158172c, Offset: 0xde0
// Size: 0x3ba
function private function_ca87f318(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("31ed427ae9eb44a1");
    self endon("31ed427ae9eb44a1");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_790695cc = "inventory_equip" + localclientnum;
    var_6e7b39bc = "inventory_detach" + localclientnum;
    clientdata.var_b9730e2b = gettime();
    while (true) {
        waitresult = level waittill(var_790695cc, var_6e7b39bc);
        if (gettime() - clientdata.var_b9730e2b < 300) {
            continue;
        }
        if (waitresult._notify === var_790695cc) {
            networkid = waitresult.id;
            quickequip = isdefined(waitresult.extraarg) ? waitresult.extraarg : 0;
            if (quickequip) {
                var_ed98a5fe = function_15d578f4(localclientnum, networkid);
                if (isdefined(var_ed98a5fe)) {
                    var_a6762160 = var_ed98a5fe.var_a6762160;
                }
                if (isdefined(var_a6762160) && (var_a6762160.itemtype == #"generic" || var_a6762160.itemtype == #"killstreak")) {
                    data = item_world::function_a7e98a1a(localclientnum);
                    name = isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name;
                    for (index = 0; index < data.inventory.items.size && index < 17 + 1; index++) {
                        inventoryitem = data.inventory.items[index];
                        if (!isdefined(inventoryitem.var_a6762160) || isdefined(inventoryitem.endtime)) {
                            continue;
                        }
                        if (inventoryitem.networkid == networkid) {
                            continue;
                        }
                        if (name == (isdefined(inventoryitem.var_a6762160.parentname) ? inventoryitem.var_a6762160.parentname : inventoryitem.var_a6762160.name)) {
                            networkid = inventoryitem.networkid;
                            break;
                        }
                    }
                }
            }
            if (isdefined(waitresult.extraarg2)) {
                function_97fedb0d(localclientnum, 11, networkid, quickequip);
            } else {
                function_97fedb0d(localclientnum, 4, networkid, quickequip);
            }
        } else if (waitresult._notify === var_6e7b39bc) {
            networkid = waitresult.id;
            function_97fedb0d(localclientnum, 6, networkid);
        }
        clientdata.var_b9730e2b = gettime();
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x2f3f63d0, Offset: 0x11a8
// Size: 0x8c
function private function_10861362(localclientnum) {
    vehicle = getplayervehicle(self);
    if (!isdefined(vehicle)) {
        return true;
    }
    var_88fa0205 = vehicle getoccupantseat(localclientnum, self);
    if (isdefined(var_88fa0205) && (var_88fa0205 == 0 || var_88fa0205 == 4)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x394d0cc0, Offset: 0x1240
// Size: 0x98
function private function_ee44351a(localclientnum, inventoryitem) {
    weapon = item_world_util::function_35e06774(inventoryitem.var_a6762160);
    if (!isdefined(weapon)) {
        return 1;
    }
    if (weapon == getcurrentweapon(localclientnum) || weapon == function_e9fe14ee(localclientnum)) {
        return function_99b22bbc(localclientnum);
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x40ecec44, Offset: 0x12e0
// Size: 0x1ca
function private function_e23e5e85(localclientnum) {
    clientdata = item_world::function_a7e98a1a(localclientnum);
    if (!isdefined(clientdata) || !isdefined(clientdata.inventory) || !isdefined(clientdata.inventory.items)) {
        return false;
    }
    armoritem = clientdata.inventory.items[6];
    if (!isdefined(armoritem) || armoritem.networkid === 32767 || armoritem.var_a6762160.itemtype !== #"armor") {
        return false;
    }
    clientmodel = getuimodelvalue(getuimodel(function_1df4c3b0(localclientnum, #"hash_6f4b11a0bee9b73d"), "predictedClientModel"));
    armormodel = getuimodel(clientmodel, "armor");
    var_15663411 = getuimodel(armoritem.itemuimodel, "armorMax");
    if (!isdefined(armormodel) || !isdefined(var_15663411) || getuimodelvalue(armormodel) == getuimodelvalue(var_15663411)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x72a264a6, Offset: 0x14b8
// Size: 0x96
function private function_e094fd92(item) {
    if (!isdefined(item) || !isdefined(item.networkid) || item.networkid == 32767 || !isdefined(item.quickequip) || item.quickequip != 1 || !isdefined(item.consumable) || item.consumable != 1) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x6f5241ea, Offset: 0x1558
// Size: 0xde
function private function_f3ef5269(localclientnum) {
    perksarray = [];
    clientdata = item_world::function_a7e98a1a(localclientnum);
    for (i = 0; i < 5; i++) {
        currentitem = clientdata.inventory.items[i];
        if (function_e094fd92(currentitem)) {
            if (!isdefined(perksarray)) {
                perksarray = [];
            } else if (!isarray(perksarray)) {
                perksarray = array(perksarray);
            }
            perksarray[perksarray.size] = currentitem;
        }
    }
    return perksarray;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x5c2e5269, Offset: 0x1640
// Size: 0xbe
function private function_e090a831(localclientnum, networkid) {
    clientdata = item_world::function_a7e98a1a(localclientnum);
    perkindex = 0;
    for (i = 0; i < 5; i++) {
        currentitem = clientdata.inventory.items[i];
        if (function_e094fd92(currentitem)) {
            if (currentitem.networkid == networkid) {
                return perkindex;
            }
            perkindex++;
        }
    }
    return -1;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x65f94c7e, Offset: 0x1708
// Size: 0x170
function private function_535a5a06(localclientnum, var_6e51c00) {
    assert(var_6e51c00 >= -1 && var_6e51c00 <= 1);
    inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
    var_f99434b1 = createuimodel(inventoryuimodel, "quickConsumeIndex");
    perksarray = function_f3ef5269(localclientnum);
    var_be32fa6d = perksarray.size;
    if (var_be32fa6d < 2) {
        setuimodelvalue(var_f99434b1, 0);
        return 0;
    }
    quickconsumeindex = getuimodelvalue(var_f99434b1);
    if (!isdefined(quickconsumeindex)) {
        quickconsumeindex = 0;
    }
    quickconsumeindex += var_6e51c00;
    if (quickconsumeindex >= var_be32fa6d) {
        quickconsumeindex = 0;
    } else if (quickconsumeindex < 0) {
        quickconsumeindex = var_be32fa6d - 1;
    }
    setuimodelvalue(var_f99434b1, quickconsumeindex);
    return quickconsumeindex;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xb3c5cb26, Offset: 0x1880
// Size: 0x22
function private function_91483494(localclientnum) {
    return function_1606ff3(localclientnum, 1);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x33524dda, Offset: 0x18b0
// Size: 0x22
function private function_9f5d2dc8(localclientnum) {
    return function_1606ff3(localclientnum, 0);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0xe7ea47c, Offset: 0x18e0
// Size: 0x124
function private function_1606ff3(localclientnum, var_6e51c00) {
    perksarray = function_f3ef5269(localclientnum);
    currentindex = function_535a5a06(localclientnum, var_6e51c00);
    inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
    var_98d32f1c = createuimodel(inventoryuimodel, "quickConsumeNetworkId");
    if (isdefined(perksarray[currentindex])) {
        setuimodelvalue(var_98d32f1c, perksarray[currentindex].networkid);
    } else {
        setuimodelvalue(var_98d32f1c, 32767);
    }
    if (perksarray.size > 1) {
        playsound(localclientnum, #"hash_4d31bd9927d823c3");
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0xef865b7b, Offset: 0x1a10
// Size: 0x104
function private function_22759012(localclientnum, networkid) {
    perkindex = function_e090a831(localclientnum, networkid);
    if (perkindex > -1) {
        inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
        var_f99434b1 = createuimodel(inventoryuimodel, "quickConsumeIndex");
        setuimodelvalue(var_f99434b1, perkindex);
        var_98d32f1c = createuimodel(inventoryuimodel, "quickConsumeNetworkId");
        setuimodelvalue(var_98d32f1c, networkid);
        return;
    }
    function_9f5d2dc8(localclientnum);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x387e119f, Offset: 0x1b20
// Size: 0xee
function private function_1470ccfe(localclientnum, item) {
    clientdata = item_world::function_a7e98a1a(localclientnum);
    for (i = 0; i < 5; i++) {
        currentitem = clientdata.inventory.items[i];
        if (currentitem.networkid == 32767 || !namespace_a0d533d1::function_73593286(item.var_a6762160, currentitem.var_a6762160) || !isdefined(currentitem.availableaction) || item.availableaction != currentitem.availableaction) {
            continue;
        }
        return currentitem.networkid;
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x65a1972, Offset: 0x1c18
// Size: 0xba2
function private function_9b83c65d(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("747e977dfcc86e93");
    self endon("747e977dfcc86e93");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_ca4fc719 = "inventory_consume" + localclientnum;
    var_e2d1f454 = "inventory_armor_repair_pressed" + localclientnum;
    var_3731e165 = "inventory_armor_repair_released" + localclientnum;
    var_6a10d173 = "inventory_quick_consume" + localclientnum;
    var_ce5c0b10 = "inventory_cycle_quick_consumable" + localclientnum;
    var_17bdd1c3 = "inventory_equip_quick_consumable" + localclientnum;
    while (true) {
        waitresult = level waittill(var_ca4fc719, var_e2d1f454, var_3731e165, var_6a10d173, var_ce5c0b10, var_17bdd1c3);
        if (waitresult._notify === var_ca4fc719) {
            if (!function_10861362(localclientnum)) {
                self playsound(localclientnum, #"uin_default_action_denied");
                continue;
            }
            inventoryitem = function_15d578f4(localclientnum, waitresult.id);
            function_22759012(localclientnum, inventoryitem.networkid);
        } else if (waitresult._notify === var_17bdd1c3) {
            inventoryitem = function_15d578f4(localclientnum, waitresult.id);
            networkid = function_1470ccfe(localclientnum, inventoryitem);
            function_22759012(localclientnum, isdefined(networkid) ? networkid : inventoryitem.networkid);
            continue;
        } else if (waitresult._notify === var_6a10d173) {
            currentindex = function_535a5a06(localclientnum, 0);
            perksarray = function_f3ef5269(localclientnum);
            if (isdefined(perksarray[currentindex])) {
                inventoryitem = perksarray[currentindex];
            } else {
                continue;
            }
        } else if (waitresult._notify === var_ce5c0b10) {
            function_91483494(localclientnum);
            continue;
        } else {
            inventoryitem = clientdata.inventory.items[11];
            if (!isdefined(inventoryitem) || inventoryitem.networkid === 32767 || inventoryitem.var_a6762160.itemtype !== #"armor_shard") {
                if (waitresult._notify === var_e2d1f454) {
                    inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
                    var_3ea10284 = createuimodel(inventoryuimodel, "armorShardNotAvailable");
                    forcenotifyuimodel(var_3ea10284);
                }
                continue;
            }
            var_a3162739 = isdefined(clientdata.inventory.var_f3518190) && inventoryitem == clientdata.inventory.var_f3518190.item;
            if (waitresult._notify === var_e2d1f454) {
                if (!function_e23e5e85(localclientnum) || inventoryitem.count == 0 || !function_10861362(localclientnum)) {
                    self playsound(localclientnum, #"uin_default_action_denied");
                    inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
                    var_3ea10284 = createuimodel(inventoryuimodel, "armorShardNotAvailable");
                    forcenotifyuimodel(var_3ea10284);
                    continue;
                }
            } else if (!var_a3162739) {
                continue;
            }
        }
        if (!isdefined(inventoryitem.var_a6762160.casttime) || inventoryitem.var_a6762160.casttime <= 0) {
            function_97fedb0d(localclientnum, 4, inventoryitem.networkid);
            continue;
        }
        var_eaae8ced = 0;
        if (isdefined(clientdata.inventory.consumed.items) && isarray(clientdata.inventory.consumed.items)) {
            foreach (consumeditem in clientdata.inventory.consumed.items) {
                if (isdefined(consumeditem.var_a6762160.talents) && isarray(consumeditem.var_a6762160.talents)) {
                    foreach (talent in consumeditem.var_a6762160.talents) {
                        if (talent.talent == #"talent_consumer_wz") {
                            var_eaae8ced = 1;
                            break;
                        }
                    }
                }
                if (var_eaae8ced) {
                    break;
                }
            }
        }
        if (isdefined(clientdata.inventory.var_f3518190)) {
            if (inventoryitem != clientdata.inventory.var_f3518190.item) {
                setuimodelvalue(createuimodel(clientdata.inventory.var_f3518190.item.itemuimodel, "castTimeFraction"), 0, 0);
                playsound(localclientnum, #"hash_4d31bd9927d823c3");
                var_f3518190 = spawnstruct();
                var_f3518190.item = inventoryitem;
                var_f3518190.caststart = gettime();
                var_f3518190.castend = var_f3518190.caststart + int((isdefined(var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime) ? var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime : 0) * 1000);
                clientdata.inventory.var_f3518190 = var_f3518190;
                function_de74158f(localclientnum, var_f3518190.item.networkid);
                clientdata.inventory.var_4d4ec560 = inventoryitem.networkid;
            } else {
                setuimodelvalue(createuimodel(clientdata.inventory.var_f3518190.item.itemuimodel, "castTimeFraction"), 0, 0);
                setuimodelvalue(clientdata.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
                clientdata.inventory.var_f3518190 = undefined;
                clientdata.inventory.var_4d4ec560 = undefined;
            }
            continue;
        }
        if (!isdefined(clientdata.inventory.var_4d4ec560) || clientdata.inventory.var_4d4ec560 != inventoryitem.networkid) {
            playsound(localclientnum, #"hash_4d31bd9927d823c3");
            var_f3518190 = spawnstruct();
            var_f3518190.item = inventoryitem;
            var_f3518190.caststart = gettime();
            var_f3518190.castend = var_f3518190.caststart + int((isdefined(var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime) ? var_eaae8ced ? var_f3518190.item.var_a6762160.casttime * 0.5 : var_f3518190.item.var_a6762160.casttime : 0) * 1000);
            clientdata.inventory.var_f3518190 = var_f3518190;
            function_de74158f(localclientnum, var_f3518190.item.networkid);
            clientdata.inventory.var_4d4ec560 = inventoryitem.networkid;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xff76c5c1, Offset: 0x27c8
// Size: 0x460
function private function_ac4df751(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("5027aed7efa1a218");
    self endon("5027aed7efa1a218");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_5054e2f7 = "inventory_drop" + localclientnum;
    var_ffec0c46 = "inventory_drop_current_weapon" + localclientnum;
    var_46a7a0e3 = "inventory_drop_current_weapon_and_detach" + localclientnum;
    var_fcd005cc = "inventory_drop_weapon_in_slot" + localclientnum;
    var_3d759450 = "inventory_drop_weapon_in_slot_and_detach" + localclientnum;
    while (true) {
        waitresult = level waittill(var_5054e2f7, var_ffec0c46, var_46a7a0e3, var_fcd005cc, var_3d759450);
        if (waitresult._notify === var_5054e2f7) {
            networkid = waitresult.id;
            count = waitresult.extraarg;
            itemid = item_world::function_28b42f1c(localclientnum, networkid);
            if (itemid != 32767) {
                if (function_6d9d9cd7(waitresult.selectedindex)) {
                    inventoryitem = clientdata.inventory.items[waitresult.selectedindex];
                    if (isdefined(inventoryitem) && !function_ee44351a(localclientnum, inventoryitem)) {
                        continue;
                    }
                }
                if (isdefined(clientdata.inventory.var_f3518190) && clientdata.inventory.var_f3518190.item.id == itemid) {
                    clientdata.inventory.var_f3518190 = undefined;
                    clientdata.inventory.var_4d4ec560 = undefined;
                    setuimodelvalue(clientdata.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
                }
                function_97fedb0d(localclientnum, 5, networkid, count);
            }
            continue;
        }
        if (waitresult._notify === var_ffec0c46 || waitresult._notify === var_fcd005cc) {
            var_4838b749 = isdefined(waitresult.slotid) ? array(17 + 1, 17 + 1 + 8 + 1)[waitresult.slotid] : function_d768ea30(localclientnum);
            if (isdefined(var_4838b749)) {
                networkid = item_world_util::function_970b8d86(var_4838b749);
                function_97fedb0d(localclientnum, 5, networkid);
            }
            continue;
        }
        if (waitresult._notify === var_46a7a0e3 || waitresult._notify === var_3d759450) {
            var_4838b749 = isdefined(waitresult.slotid) ? array(17 + 1, 17 + 1 + 8 + 1)[waitresult.slotid] : function_d768ea30(localclientnum);
            if (isdefined(var_4838b749)) {
                networkid = item_world_util::function_970b8d86(var_4838b749);
                function_97fedb0d(localclientnum, 8, networkid);
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x947341f8, Offset: 0x2c30
// Size: 0x1d0
function private function_8edef5cc(localclientnum, inventoryitem) {
    data = item_world::function_a7e98a1a(localclientnum);
    slot = function_daf3ebda(localclientnum, inventoryitem.var_a6762160);
    if (!isdefined(slot)) {
        slot = self function_78ed4455(localclientnum, inventoryitem.var_a6762160);
    }
    if (isdefined(slot)) {
        if (inventoryitem.var_a6762160.type != #"attachment") {
            item = data.inventory.items[slot];
            setuimodelvalue(createuimodel(item.itemuimodel, "focusTarget"), 1);
        }
        return;
    }
    if (function_ad4c6116(localclientnum, inventoryitem.var_a6762160)) {
        for (i = 0; i < data.inventory.var_c212de25; i++) {
            if (data.inventory.items[i].networkid === 32767) {
                setuimodelvalue(createuimodel(data.inventory.items[i].itemuimodel, "focusTarget"), 1);
                break;
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x5 linked
// Checksum 0x320460bb, Offset: 0x2e08
// Size: 0x178
function private function_96ce9058(localclientnum, var_6c2b2289, inventoryitem, item) {
    level endon(var_6c2b2289);
    self notify("56711e9daae5a283");
    self endon("56711e9daae5a283");
    if (isdefined(item.var_a6762160.unlockableitemref)) {
        var_1ce96a13 = array(0, 0, 0, 0, 0);
        while (true) {
            waitframe(1);
            for (i = 0; i < 5; i++) {
                if (isdefined(item.var_a6762160.objectives[i]) && isdefined(item.var_a6762160.objectives[i].var_7e835304)) {
                    value = stats::get_stat_global(localclientnum, item.var_a6762160.objectives[i].var_7e835304);
                    if (isdefined(value) && value != var_1ce96a13[i]) {
                        var_1ce96a13[i] = value;
                        function_39b663b7(localclientnum, inventoryitem, item);
                    }
                }
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x478c5097, Offset: 0x2f88
// Size: 0x954
function private function_7f35a045(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("54ba5fd072afbdea");
    self endon("54ba5fd072afbdea");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_6c2b2289 = "inventory_item_focus" + localclientnum;
    while (true) {
        waitresult = level waittill(var_6c2b2289);
        data = item_world::function_a7e98a1a(localclientnum);
        function_534dcb9c(localclientnum);
        if (isdefined(level.var_6d21daaf[localclientnum])) {
            setuimodelvalue(level.var_6d21daaf[localclientnum], 0);
        }
        foreach (var_4838b749 in array(17 + 1, 17 + 1 + 8 + 1)) {
            foreach (var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
                var_f9f8c0b5 = var_4838b749 + var_259f58f3;
                item = data.inventory.items[var_f9f8c0b5];
                setuimodelvalue(createuimodel(item.itemuimodel, "focusTarget"), 0);
                setuimodelvalue(createuimodel(item.itemuimodel, "notAvailable"), 0);
            }
        }
        setuimodelvalue(createuimodel(data.inventory.items[6].itemuimodel, "focusTarget"), 0);
        setuimodelvalue(createuimodel(data.inventory.items[8].itemuimodel, "focusTarget"), 0);
        setuimodelvalue(createuimodel(data.inventory.items[7].itemuimodel, "focusTarget"), 0);
        setuimodelvalue(createuimodel(data.inventory.items[5].itemuimodel, "focusTarget"), 0);
        for (i = 0; i < 5; i++) {
            setuimodelvalue(createuimodel(data.inventory.items[i].itemuimodel, "focusTarget"), 0);
        }
        if (waitresult._notify !== var_6c2b2289) {
            continue;
        }
        networkid = waitresult.id;
        data.inventory.var_9d51958c = networkid;
        if (networkid === 32767) {
            continue;
        }
        inventoryitem = function_15d578f4(localclientnum, networkid);
        if (isdefined(inventoryitem) && 32767 != inventoryitem.id) {
            item = function_b1702735(inventoryitem.id);
            if (isdefined(item) && isdefined(item.var_a6762160)) {
                self thread function_96ce9058(localclientnum, var_6c2b2289, inventoryitem, item);
            }
        }
        if (!isdefined(inventoryitem) && item_world::function_a5c2a6b8(localclientnum) && self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
            arrayremovevalue(data.groupitems, undefined, 0);
            for (index = 0; index < data.groupitems.size; index++) {
                var_81bb13f5 = data.groupitems[index];
                if (var_81bb13f5.networkid === networkid) {
                    if (var_81bb13f5.var_a6762160.itemtype != #"ammo" && var_81bb13f5.var_a6762160.itemtype != #"weapon") {
                        inventoryitem = var_81bb13f5;
                        function_8edef5cc(localclientnum, inventoryitem);
                    }
                    break;
                }
            }
        }
        if (!isdefined(inventoryitem) || !isdefined(inventoryitem.var_a6762160) || inventoryitem.var_a6762160.itemtype !== #"attachment") {
            continue;
        }
        var_a4250c2b = function_d768ea30(localclientnum);
        foreach (var_4838b749 in array(17 + 1, 17 + 1 + 8 + 1)) {
            weaponitem = data.inventory.items[var_4838b749];
            if (weaponitem.id === 32767) {
                continue;
            }
            var_ceefbd10 = namespace_a0d533d1::function_837f4a57(inventoryitem.var_a6762160);
            var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
            attachmentname = namespace_a0d533d1::function_2ced1d34(weaponitem, inventoryitem.var_a6762160);
            var_86364446 = data.inventory.items[var_f9f8c0b5];
            if (isdefined(attachmentname)) {
                if (networkid != var_86364446.networkid) {
                    setuimodelvalue(createuimodel(var_86364446.itemuimodel, "focusTarget"), 1);
                }
                var_fdc9fcff = isdefined(var_a4250c2b) && var_a4250c2b == 17 + 1 ? 17 + 1 + 8 + 1 : 17 + 1;
                if (var_fdc9fcff == var_4838b749) {
                    setuimodelvalue(level.var_6d21daaf[localclientnum], 1);
                }
                continue;
            }
            setuimodelvalue(createuimodel(var_86364446.itemuimodel, "notAvailable"), 1);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xc02877e3, Offset: 0x38e8
// Size: 0x1ea
function private function_2ae9881d(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("638e4b13eb0cb6e6");
    self endon("638e4b13eb0cb6e6");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_f3efb06b = "cycle_health" + localclientnum;
    var_db83305d = "cycle_equipment" + localclientnum;
    var_d991a20a = "cycle_scorestreak" + localclientnum;
    var_58ea832 = "cycle_field_upgrade" + localclientnum;
    clientdata.var_cb55ac3c = gettime();
    while (true) {
        waitresult = level waittill(var_f3efb06b, var_db83305d, var_d991a20a, var_58ea832);
        if (gettime() - clientdata.var_cb55ac3c < 200) {
            continue;
        }
        if (waitresult._notify === var_f3efb06b) {
            function_97fedb0d(localclientnum, 10);
        } else if (waitresult._notify === var_db83305d) {
            function_97fedb0d(localclientnum, 9);
        } else if (waitresult._notify === var_d991a20a) {
            function_97fedb0d(localclientnum, 14);
        } else if (waitresult._notify === var_58ea832) {
            function_97fedb0d(localclientnum, 15);
        }
        clientdata.var_cb55ac3c = gettime();
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xc5d2fc10, Offset: 0x3ae0
// Size: 0x448
function private function_d1e6731e(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("6a6d92db248c5728");
    self endon("6a6d92db248c5728");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_bd0cdac3 = "attachment_pickup";
    var_b784f644 = var_bd0cdac3 + localclientnum;
    while (true) {
        util::waittill_any_ents(self, var_bd0cdac3, level, var_b784f644);
        currentitem = self.var_9b882d22;
        if (!isdefined(currentitem) || !isdefined(currentitem.var_a6762160)) {
            continue;
        }
        var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
        if (item_world_util::function_83c20f83(self.var_9b882d22) && !var_512ddf16) {
            continue;
        }
        if (var_512ddf16 && self.var_54d9f4a6) {
            continue;
        }
        origin = getlocalclienteyepos(localclientnum);
        if (distance2dsquared(origin, currentitem.origin) > function_a3f6cdac(128) || abs(origin[2] - currentitem.origin[2]) > 128) {
            continue;
        }
        if (!isdefined(currentitem.var_a6762160)) {
            continue;
        }
        var_fc7876fd = 0;
        if (!function_ad4c6116(localclientnum, currentitem.var_a6762160)) {
            swap = 0;
            data = item_world::function_a7e98a1a(localclientnum);
            switch (currentitem.var_a6762160.itemtype) {
            case #"tactical":
            case #"scorestreak":
            case #"equipment":
            case #"field_upgrade":
            case #"perk_tier_3":
            case #"perk_tier_2":
            case #"perk_tier_1":
            case #"health":
                swap = 1;
                break;
            default:
                break;
            }
            if (!swap) {
                continue;
            }
            function_97fedb0d(localclientnum, 7, currentitem.networkid, 2);
            continue;
        } else {
            switch (currentitem.var_a6762160.itemtype) {
            case #"tactical":
            case #"weapon":
            case #"scorestreak":
            case #"equipment":
            case #"field_upgrade":
            case #"perk_tier_3":
            case #"perk_tier_2":
            case #"perk_tier_1":
            case #"health":
                var_fc7876fd = 1;
                break;
            }
        }
        function_97fedb0d(localclientnum, 7, currentitem.networkid, var_fc7876fd);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x2b9847a2, Offset: 0x3f30
// Size: 0x104
function private function_6d9d9cd7(slotid) {
    assert(isint(slotid));
    foreach (slot in array(5, 6, 12, 7, 13, 8, 17 + 1, 17 + 1 + 8 + 1, 14, 15, 16, 17)) {
        if (slot == slotid) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x20a0324f, Offset: 0x4040
// Size: 0x740
function private function_d2f05352() {
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
            data = item_world::function_a7e98a1a(localclientnum);
            if (!isdefined(data) || !isdefined(data.inventory) || !isdefined(data.inventory.items)) {
                continue;
            }
            consumed = data.inventory.consumed;
            var_3ef517e = data.inventory.consumed.items;
            var_95dcc077 = 0;
            for (i = 0; i < var_3ef517e.size; i++) {
                item = var_3ef517e[i];
                if (item.endtime <= time) {
                    var_95dcc077 = 1;
                    arrayremoveindex(var_3ef517e, i);
                    playsound(localclientnum, #"hash_4c7a6e162e2f26a0");
                    continue;
                }
            }
            var_cfa0e915 = [];
            for (i = 0; i < var_3ef517e.size; i++) {
                item = var_3ef517e[i];
                if (isdefined(var_cfa0e915[item.var_a6762160.name])) {
                    continue;
                }
                var_cfa0e915[item.var_a6762160.name] = 1;
                duration = item.endtime - item.starttime;
                timeremaining = item.endtime - time;
                if (var_95dcc077) {
                    item.itemuimodel = createuimodel(consumed.uimodel, "item" + var_cfa0e915.size - 1);
                    function_1a99656a(localclientnum, item, item.networkid, item.id, 0, 0, 0, 0);
                }
                frac = 1;
                if (duration > 0) {
                    frac = 1 - timeremaining / duration;
                }
                setuimodelvalue(createuimodel(item.itemuimodel, "endStartFraction"), frac, 0);
            }
            var_f3518190 = data.inventory.var_f3518190;
            if (isdefined(var_f3518190) && var_f3518190.item.id != 32767) {
                duration = var_f3518190.castend - var_f3518190.caststart;
                timeremaining = var_f3518190.castend - time;
                if (timeremaining <= 0) {
                    function_97fedb0d(localclientnum, 4, var_f3518190.item.networkid);
                    setuimodelvalue(createuimodel(var_f3518190.item.itemuimodel, "castTimeFraction"), 0, 0);
                    data.inventory.var_f3518190 = undefined;
                    if (var_f3518190.item.networkid == data.inventory.items[11].networkid) {
                        var_95dcc077 = 1;
                        if (!function_e23e5e85(localclientnum)) {
                            data.inventory.var_4d4ec560 = undefined;
                        }
                    }
                } else {
                    setuimodelvalue(createuimodel(var_f3518190.item.itemuimodel, "castTimeFraction"), 1 - timeremaining / duration, 0);
                    uimodel = getuimodel(data.inventory.consumed.uimodel, "item" + function_3fe6ef04(localclientnum));
                    if (isdefined(uimodel)) {
                        setuimodelvalue(createuimodel(uimodel, "castTimeFraction"), 1 - timeremaining / duration, 0);
                    }
                }
            }
            for (index = 0; index < 5; index++) {
                item = data.inventory.items[index];
                if (!isdefined(item.endtime)) {
                    continue;
                }
                duration = item.endtime - item.starttime;
                timeremaining = item.endtime - time;
                frac = 1;
                if (duration > 0) {
                    frac = 1 - timeremaining / duration;
                }
                setuimodelvalue(createuimodel(item.itemuimodel, "endStartFraction"), frac, 0);
            }
            if (var_95dcc077) {
                setuimodelvalue(consumed.var_a25538fb, var_cfa0e915.size);
                function_9f5d2dc8(localclientnum);
            }
        }
        players = undefined;
        waitframe(1);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xbcfdc680, Offset: 0x4788
// Size: 0x72
function private function_fe189514(var_a6762160) {
    if (isdefined(var_a6762160) && isdefined(var_a6762160.weapon)) {
        return (isdefined(var_a6762160.weapon.name) ? var_a6762160.weapon.name : #"");
    }
    return #"";
}

// Namespace item_inventory/item_inventory
// Params 10, eflags: 0x5 linked
// Checksum 0x9cccabe, Offset: 0x4808
// Size: 0x1f84
function private function_1a99656a(localclientnum, inventoryitem, networkid, itemid, count, totalcount, availableaction, var_e35261f6 = 1, var_189fcf49 = 0, var_1204dfe9 = 1) {
    data = undefined;
    if (itemid == 32767 && isdefined(inventoryitem.networkid) && inventoryitem.networkid != 32767) {
        data = level.var_d342a3fd[localclientnum];
    } else if (itemid != 32767 && inventoryitem.networkid === 32767) {
        data = level.var_d342a3fd[localclientnum];
    } else if (isdefined(inventoryitem.var_a6762160) && (inventoryitem.var_a6762160.itemtype === #"armor_shard" || inventoryitem.var_a6762160.itemtype === #"scorestreak" || item_world_util::function_a57773a4(inventoryitem.var_a6762160))) {
        data = level.var_d342a3fd[localclientnum];
    }
    var_dbce1e30 = 0;
    if (inventoryitem.id === itemid && isdefined(inventoryitem.count) && inventoryitem.count > count) {
        var_dbce1e30 = 1;
        if (isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype === #"armor_shard") {
            clientdata = item_world::function_a7e98a1a(localclientnum);
            if (isdefined(clientdata) && isdefined(clientdata.inventory) && networkid === clientdata.inventory.var_4d4ec560) {
                clientdata.inventory.var_4d4ec560 = undefined;
            }
        }
    }
    player = function_27673a7(localclientnum);
    var_1bd87f37 = 1;
    if (isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype == #"armor_shard" && networkid == 32767 && var_1204dfe9 == 0) {
        var_1bd87f37 = 0;
    }
    var_e3f9d92b = item_world_util::function_a57773a4(inventoryitem.var_a6762160);
    var_75b43169 = isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype === #"scorestreak";
    var_d5042302 = isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype === #"attachment";
    var_1c54cff7 = inventoryitem.var_a6762160;
    if (var_1bd87f37) {
        inventoryitem.id = itemid;
        inventoryitem.networkid = networkid;
    } else {
        itemid = inventoryitem.id;
        networkid = inventoryitem.networkid;
    }
    inventoryitem.count = count;
    inventoryitem.var_a6762160 = 32767 == itemid ? undefined : function_b1702735(itemid).var_a6762160;
    inventoryitem.availableaction = availableaction;
    inventoryitem.consumable = isdefined(inventoryitem.var_a6762160) ? inventoryitem.var_a6762160.consumable : undefined;
    inventoryitem.quickequip = 0;
    if (var_e35261f6) {
        inventoryitem.starttime = undefined;
        inventoryitem.endtime = undefined;
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "endStartFraction"), 0, 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTimeFraction"), 0, 0);
    }
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "id"), inventoryitem.networkid);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "realId"), inventoryitem.id);
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stackCount"), count);
    if (isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype == #"armor_shard") {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "totalCount"), count);
    } else {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "totalCount"), totalcount);
    }
    item = undefined;
    if (itemid != 32767) {
        item = function_b1702735(itemid);
    }
    if (itemid == 32767 || !isdefined(item.var_a6762160)) {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "name"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "icon"), #"blacktransparent");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rarity"), "None");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stowedAvailableAction"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "canTransferAttachment"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "consumable"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "assetName"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "description"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTime"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "type"), "");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "equipped"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "endStartFraction"), 0, 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTimeFraction"), 0, 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAvailable"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAccessible"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "focusTarget"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "cycle"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "armorMax"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "hasAttachments"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "supportsAttachments"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "unlockableItemRef"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quote"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rewardName"), #"");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "ammoType"), #"");
        function_442857e2(localclientnum, var_1c54cff7);
    } else {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "name"), item_world::get_item_name(item.var_a6762160));
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "icon"), isdefined(item.var_a6762160.icon) ? item.var_a6762160.icon : #"blacktransparent");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rarity"), isdefined(item.var_a6762160.rarity) ? item.var_a6762160.rarity : "None");
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "assetName"), function_fe189514(item.var_a6762160));
        armormax = 0;
        if (isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"armor") {
            armormax = isdefined(item.var_a6762160.amount) ? item.var_a6762160.amount : 0;
        }
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "armorMax"), armormax);
        description = isdefined(item.var_a6762160.description) ? item.var_a6762160.description : #"";
        if (getdvar(#"hash_4a5fd7d94cfc9dfd", 0) == 1) {
            if (isdefined(item.var_a6762160.unlockableitemref)) {
                if (isdefined(item.var_a6762160.var_a51bc1f7)) {
                    description = isdefined(item.var_a6762160.var_a51bc1f7) ? item.var_a6762160.var_a51bc1f7 : #"";
                }
            }
        }
        if (description == #"" && isdefined(item.var_a6762160.weapon)) {
            itemindex = getitemindexfromref(item.var_a6762160.weapon.name);
            var_97dcd0a5 = getunlockableiteminfofromindex(itemindex);
            if (isdefined(var_97dcd0a5) && isdefined(var_97dcd0a5.description)) {
                description = var_97dcd0a5.description;
            }
        }
        if (isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"resource") {
            if (function_88da0c8e(localclientnum)) {
                setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "notAccessible"), 1);
                description = isdefined(item.var_a6762160.var_3b8219fd) ? item.var_a6762160.var_3b8219fd : description;
            }
        }
        if (isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"weapon") {
            supportsattachments = namespace_a0d533d1::function_4bd83c04(item);
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "supportsAttachments"), supportsattachments);
            var_754fe8c5 = getweaponammotype(item.var_a6762160.weapon);
            if (isdefined(level.var_c53d118f) && isdefined(level.var_c53d118f[var_754fe8c5])) {
                setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "ammoType"), level.var_c53d118f[var_754fe8c5]);
            } else {
                setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "ammoType"), #"");
            }
        }
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "description"), description);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "castTime"), isdefined(item.var_a6762160.casttime) ? item.var_a6762160.casttime : 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "type"), item.var_a6762160.itemtype);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "equipped"), isdefined(inventoryitem.endtime));
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "stowedAvailableAction"), 0);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "consumable"), 0);
        if (isdefined(item.var_a6762160.unlockableitemref)) {
            function_39b663b7(localclientnum, inventoryitem, item);
        } else {
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "unlockableItemRef"), #"");
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quote"), #"");
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rewardName"), #"");
        }
        if (!var_189fcf49) {
            function_442857e2(localclientnum, isdefined(inventoryitem.var_a6762160) ? inventoryitem.var_a6762160 : var_1c54cff7);
        }
        if (count != 0 && !var_dbce1e30) {
            function_8ffee46f(localclientnum, inventoryitem);
        }
    }
    if (isdefined(data)) {
        canusequickinventory = 0;
        filledslots = 0;
        for (i = 0; i < data.inventory.var_c212de25; i++) {
            if (data.inventory.items[i].networkid != 32767) {
                if (data.inventory.items[i].availableaction == 1 || data.inventory.items[i].availableaction == 4 || data.inventory.items[i].availableaction == 2 || data.inventory.items[i].availableaction == 6) {
                    if (is_true(data.inventory.items[i].quickequip)) {
                        canusequickinventory |= 1;
                    }
                }
                filledslots++;
            }
        }
        shardcount = 0;
        if (data.inventory.items[11].networkid != 32767 && data.inventory.items[11].count > 0) {
            filledslots++;
            canusequickinventory |= 1;
        }
        if (isdefined(level.var_37076fe8)) {
            shoulddisable = [[ level.var_37076fe8 ]](player);
            if (shoulddisable) {
                canusequickinventory = 0;
            }
        }
        inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
        setuimodelvalue(createuimodel(inventoryuimodel, "filledSlots"), filledslots);
        setuimodelvalue(createuimodel(inventoryuimodel, "canUseQuickInventory"), canusequickinventory);
        var_a966c73b = data.inventory.items[10];
        if (var_a966c73b.networkid != 32767) {
            setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 2);
        } else {
            setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 1);
        }
        if (var_e3f9d92b) {
            function_950ae846(localclientnum);
        }
        if (var_75b43169) {
            function_b5b6a9a4(localclientnum);
        }
        if (itemid !== 32767 && isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype === #"weapon") {
            foreach (var_4838b749 in array(17 + 1, 17 + 1 + 8 + 1)) {
                if (data.inventory.items[var_4838b749].networkid === networkid) {
                    attachmentslots = array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock");
                    foreach (index, var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
                        slot = attachmentslots[index];
                        var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_259f58f3);
                        attachmentitem = data.inventory.items[var_f9f8c0b5];
                        if (!isdefined(inventoryitem.var_a6762160.(slot))) {
                            setuimodelvalue(createuimodel(attachmentitem.itemuimodel, "disabled"), 1);
                            continue;
                        }
                        setuimodelvalue(createuimodel(attachmentitem.itemuimodel, "disabled"), 0);
                    }
                    break;
                }
            }
        }
        if (itemid !== 32767 && isdefined(inventoryitem.var_a6762160) && inventoryitem.var_a6762160.itemtype === #"attachment") {
            var_f9f8c0b5 = item_world_util::function_808be9a3(inventoryitem.networkid);
            var_2cf6fb05 = undefined;
            foreach (var_4838b749 in array(17 + 1, 17 + 1 + 8 + 1)) {
                if (namespace_a0d533d1::function_398b9770(var_4838b749, var_f9f8c0b5)) {
                    var_2cf6fb05 = var_4838b749;
                    break;
                }
            }
            if (isdefined(var_2cf6fb05)) {
                function_cb7cfe5b(localclientnum, var_2cf6fb05, inventoryitem);
                hasattachments = has_attachments(localclientnum, var_2cf6fb05);
                var_508262d4 = data.inventory.items[var_2cf6fb05];
                if (hasattachments) {
                    setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 1);
                } else {
                    setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 0);
                }
            } else {
                var_a4250c2b = player function_d768ea30(localclientnum);
                function_cb7cfe5b(localclientnum, var_a4250c2b, inventoryitem);
            }
            function_ce628f27(localclientnum);
            return;
        }
        if (var_d5042302) {
            var_a4250c2b = player function_d768ea30(localclientnum);
            hasattachments = has_attachments(localclientnum, var_a4250c2b);
            if (isdefined(var_a4250c2b)) {
                var_508262d4 = data.inventory.items[var_a4250c2b];
                if (hasattachments) {
                    setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 1);
                } else {
                    setuimodelvalue(createuimodel(var_508262d4.itemuimodel, "hasAttachments"), 0);
                }
            }
            function_deddbdf0(localclientnum, var_a4250c2b);
            function_ce628f27(localclientnum);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 6, eflags: 0x5 linked
// Checksum 0x8aa04c57, Offset: 0x6798
// Size: 0x264
function private function_2ecc089c(localclientnum, var_67bed85d, type, var_bd4c63f1, var_9286261, var_a3a763a3) {
    data = item_world::function_a7e98a1a(localclientnum);
    if (!isdefined(data)) {
        return;
    }
    currentitem = data.inventory.items[var_67bed85d];
    var_7007b688 = [];
    if (isdefined(currentitem.var_a6762160)) {
        var_7007b688 = item_world_util::function_4cbb6617(data.inventory, type, var_bd4c63f1, currentitem.var_a6762160);
    }
    for (index = 0; index < var_7007b688.size && index < var_9286261; index++) {
        item = var_a3a763a3[index];
        inventoryitem = var_7007b688[index];
        function_1a99656a(localclientnum, item, inventoryitem.networkid, inventoryitem.id, inventoryitem.count, function_bba770de(localclientnum, inventoryitem.var_a6762160), inventoryitem.availableaction, undefined, 1);
        setuimodelvalue(createuimodel(item.itemuimodel, "cycle"), 1);
        forcenotifyuimodel(createuimodel(item.itemuimodel, "totalCount"));
    }
    for (index = var_7007b688.size; index < var_9286261; index++) {
        item = var_a3a763a3[index];
        function_1a99656a(localclientnum, item, 32767, 32767, 0, 0, 0, undefined, 1);
        setuimodelvalue(createuimodel(item.itemuimodel, "cycle"), 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x554c8beb, Offset: 0x6a08
// Size: 0xc5c
function private function_442857e2(localclientnum, var_a6762160) {
    if (!isdefined(var_a6762160)) {
        return;
    }
    if (var_a6762160.itemtype !== #"equipment" && var_a6762160.itemtype !== #"field_upgrade" && var_a6762160.itemtype !== #"tactical" && var_a6762160.itemtype !== #"generic" && var_a6762160.itemtype !== #"health" && var_a6762160.itemtype !== #"killstreak" && var_a6762160.itemtype !== #"scorestreak" && var_a6762160.itemtype !== #"attachment" && var_a6762160.itemtype !== #"armor_shard") {
        return;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    if (!isdefined(data)) {
        return;
    }
    var_6962e967 = 0;
    if (var_a6762160.itemtype == #"attachment") {
        player = function_27673a7(localclientnum);
        var_a4250c2b = player function_d768ea30(localclientnum);
        if (isdefined(var_a4250c2b)) {
            var_55022c4f = array(1, 2, 3, 4, 5, 6, 7, 8);
            for (attachmentindex = 0; attachmentindex < var_55022c4f.size; attachmentindex++) {
                var_259f58f3 = var_55022c4f[attachmentindex];
                var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_a4250c2b, var_259f58f3);
                inventoryitem = data.inventory.items[var_f9f8c0b5];
                if (inventoryitem.networkid != 32767 && namespace_a0d533d1::function_73593286(var_a6762160, inventoryitem.var_a6762160)) {
                    var_6962e967 = 1;
                    break;
                }
            }
        }
    } else if (var_a6762160.itemtype == #"armor_shard") {
        inventoryitem = data.inventory.items[11];
    } else {
        foreach (slot in array(5, 6, 12, 7, 13, 8, 17 + 1, 17 + 1 + 8 + 1, 14, 15, 16, 17)) {
            inventoryitem = data.inventory.items[slot];
            if (inventoryitem.networkid != 32767 && namespace_a0d533d1::function_73593286(var_a6762160, inventoryitem.var_a6762160)) {
                var_6962e967 = 1;
                break;
            }
        }
    }
    totalcount = function_bba770de(localclientnum, var_a6762160);
    if (var_a6762160.itemtype == #"armor_shard") {
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), totalcount > 0);
    } else {
        var_6d4bb070 = 0;
        for (index = 0; index < 5; index++) {
            inventoryitem = data.inventory.items[index];
            if (inventoryitem.networkid == 32767 || !namespace_a0d533d1::function_73593286(var_a6762160, inventoryitem.var_a6762160)) {
                continue;
            }
            if (var_6962e967 || var_6d4bb070 || isdefined(inventoryitem.endtime)) {
                setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), 0);
                inventoryitem.quickequip = 0;
            } else if (!var_6d4bb070) {
                setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quickEquip"), 1);
                inventoryitem.quickequip = 1;
                var_6d4bb070 = 1;
            }
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "totalCount"), totalcount);
        }
    }
    if (var_a6762160.itemtype === #"health") {
        function_2ecc089c(localclientnum, 5, #"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad", #"hash_20699a922abaf2e1"), 2, data.inventory.healthitems);
        return;
    }
    if (var_a6762160.itemtype === #"equipment") {
        function_2ecc089c(localclientnum, 7, #"equipment", array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de", #"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"), 2, data.inventory.equipmentitems);
        return;
    }
    if (var_a6762160.itemtype === #"field_upgrade") {
        function_2ecc089c(localclientnum, 12, #"field_upgrade", array(#"hash_3f154f45479130ed", #"hash_2c9b75b17410f2de", #"field_upgrade_frost_blast_item_sr", #"field_upgrade_frost_blast_2_item_sr", #"field_upgrade_frost_blast_3_item_sr", #"field_upgrade_frost_blast_4_item_sr", #"field_upgrade_frost_blast_5_item_sr"), 2, data.inventory.var_d4de469a);
        return;
    }
    if (var_a6762160.itemtype === #"tactical") {
        function_2ecc089c(localclientnum, 13, #"tactical", array(), 2, data.inventory.var_d4de469a);
        return;
    }
    if (var_a6762160.itemtype === #"scorestreak") {
        function_2ecc089c(localclientnum, 17, #"scorestreak", array(#"hash_6eb09ea5da35e18f", #"hash_654445f6cc7a7e1c", #"item_survival_scorestreak_pineapple_gun", #"item_survival_scorestreak_deathmachine", #"item_survival_scorestreak_flamethrower", #"item_survival_scorestreak_hand_cannon", #"item_survival_scorestreak_ultimate_turret", #"hash_18fa1f3e4e43437c"), 2, data.inventory.var_cb8b68cf);
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x5 linked
// Checksum 0x3fa683ce, Offset: 0x7670
// Size: 0x56c
function private function_39b663b7(localclientnum, inventoryitem, item) {
    var_409a5960 = function_1df4c3b0(localclientnum, #"hash_1bfcdf95a55f5ed6");
    itemindex = getitemindexfromref(item.var_a6762160.unlockableitemref);
    if (itemindex !== 0) {
        var_10d25c94 = createuimodel(var_409a5960, itemindex);
        if (!isdefined(getuimodel(var_10d25c94, "completed"))) {
            setuimodelvalue(createuimodel(var_10d25c94, "completed"), 0);
        }
        for (i = 0; i < 5; i++) {
            description = undefined;
            objectivemodel = createuimodel(var_10d25c94, "objective" + i + 1);
            if (!isdefined(objectivemodel)) {
                continue;
            }
            if (!isdefined(getuimodel(objectivemodel, "state"))) {
                setuimodelvalue(createuimodel(objectivemodel, "state"), 0);
            }
            if (isdefined(item.var_a6762160.objectives[i])) {
                if (isdefined(item.var_a6762160.objectives[i].teamsizedescriptions) && item.var_a6762160.objectives[i].teamsizedescriptions.size > 0) {
                    numplayers = getgametypesetting("maxTeamPlayers");
                    foreach (objectivestruct in item.var_a6762160.objectives[i].teamsizedescriptions) {
                        if (objectivestruct.teamsize == numplayers) {
                            description = objectivestruct.description;
                            break;
                        }
                    }
                }
                if (!isdefined(description)) {
                    description = item.var_a6762160.objectives[i].description;
                }
                var_2571317b = 0;
                if (isdefined(item.var_a6762160.objectives[i].var_7e835304)) {
                    var_2571317b = setuimodelvalue(createuimodel(objectivemodel, "unlockProgress"), stats::get_stat_global(localclientnum, item.var_a6762160.objectives[i].var_7e835304));
                } else {
                    setuimodelvalue(createuimodel(objectivemodel, "unlockProgress"), -1);
                }
                if (!setuimodelvalue(createuimodel(objectivemodel, "description"), description) && var_2571317b) {
                    forcenotifyuimodel(createuimodel(objectivemodel, "description"));
                }
                continue;
            }
            setuimodelvalue(createuimodel(objectivemodel, "unlockProgress"), -1);
            setuimodelvalue(createuimodel(objectivemodel, "description"), #"");
        }
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "unlockableItemRef"), item.var_a6762160.unlockableitemref);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "quote"), item.var_a6762160.var_e8b98a8a);
        setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "rewardName"), item.var_a6762160.rewardname);
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x5 linked
// Checksum 0x56f1656, Offset: 0x7be8
// Size: 0x634
function private function_cb7cfe5b(localclientnum, var_a4250c2b, var_ac517de7) {
    if (var_ac517de7.networkid === 32767 || !isdefined(var_ac517de7.var_a6762160) || var_ac517de7.var_a6762160.itemtype !== #"attachment") {
        return;
    }
    if (!isdefined(var_a4250c2b)) {
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 0);
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 1);
        return;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    var_ac044d12 = undefined;
    var_fdc9fcff = undefined;
    var_ffd2f6e4 = undefined;
    var_ac044d12 = data.inventory.items[var_a4250c2b];
    var_fdc9fcff = var_a4250c2b == 17 + 1 ? 17 + 1 + 8 + 1 : 17 + 1;
    var_ffd2f6e4 = data.inventory.items[var_fdc9fcff];
    noweapon = !isdefined(var_ac044d12) || var_ac044d12.networkid === 32767 || !isdefined(var_ac044d12.var_a6762160) || var_ac044d12.var_a6762160.itemtype !== #"weapon";
    var_cdef462d = !isdefined(var_ffd2f6e4) || var_ffd2f6e4.networkid === 32767 || !isdefined(var_ffd2f6e4.var_a6762160) || var_ffd2f6e4.var_a6762160.itemtype !== #"weapon";
    if (noweapon) {
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 0);
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 1);
        if (var_cdef462d) {
            setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 0);
            return;
        }
    }
    var_ceefbd10 = namespace_a0d533d1::function_837f4a57(var_ac517de7.var_a6762160);
    if (isdefined(namespace_a0d533d1::function_2ced1d34(var_ac044d12, var_ac517de7.var_a6762160))) {
        var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_a4250c2b, var_ceefbd10);
        if (data.inventory.items[var_f9f8c0b5].networkid !== 32767) {
            setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 3);
        } else {
            setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 2);
        }
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 0);
        function_442857e2(localclientnum, var_ac517de7.var_a6762160);
    } else {
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "availableAction"), 0);
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "notAvailable"), 1);
    }
    if (var_cdef462d) {
        setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 0);
        return;
    }
    if (isdefined(namespace_a0d533d1::function_2ced1d34(var_ffd2f6e4, var_ac517de7.var_a6762160))) {
        var_50f8a92d = namespace_a0d533d1::function_dfaca25e(var_fdc9fcff, var_ceefbd10);
        if (data.inventory.items[var_50f8a92d].networkid !== 32767) {
            setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 3);
        } else {
            setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 2);
        }
        return;
    }
    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "stowedAvailableAction"), 0);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x6416783d, Offset: 0x8228
// Size: 0x9c
function private function_deddbdf0(localclientnum, var_f7956021) {
    data = item_world::function_a7e98a1a(localclientnum);
    for (itemindex = 0; itemindex < data.inventory.var_c212de25; itemindex++) {
        inventoryitem = data.inventory.items[itemindex];
        function_cb7cfe5b(localclientnum, var_f7956021, inventoryitem);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xe1aeeaa6, Offset: 0x82d0
// Size: 0x14c
function private function_950ae846(localclientnum) {
    data = item_world::function_a7e98a1a(localclientnum);
    for (itemindex = 0; itemindex < data.inventory.var_c212de25; itemindex++) {
        inventoryitem = data.inventory.items[itemindex];
        if (!isdefined(inventoryitem.var_a6762160) || !item_world_util::function_a57773a4(inventoryitem.var_a6762160)) {
            continue;
        }
        availableaction = function_30697356(localclientnum, inventoryitem.var_a6762160);
        if (inventoryitem.availableaction != availableaction) {
            totalcount = function_bba770de(localclientnum, inventoryitem.var_a6762160);
            function_1a99656a(localclientnum, inventoryitem, inventoryitem.networkid, inventoryitem.id, inventoryitem.count, totalcount, availableaction);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x7ed0a33d, Offset: 0x8428
// Size: 0x14c
function private function_b5b6a9a4(localclientnum) {
    data = item_world::function_a7e98a1a(localclientnum);
    for (itemindex = 0; itemindex < data.inventory.var_c212de25; itemindex++) {
        inventoryitem = data.inventory.items[itemindex];
        if (!isdefined(inventoryitem.var_a6762160) || inventoryitem.var_a6762160.itemtype != #"scorestreak") {
            continue;
        }
        availableaction = function_30697356(localclientnum, inventoryitem.var_a6762160);
        if (inventoryitem.availableaction != availableaction) {
            totalcount = function_bba770de(localclientnum, inventoryitem.var_a6762160);
            function_1a99656a(localclientnum, inventoryitem, inventoryitem.networkid, inventoryitem.id, inventoryitem.count, totalcount, availableaction);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x74718d1b, Offset: 0x8580
// Size: 0x40c
function private function_ce628f27(localclientnum) {
    data = item_world::function_a7e98a1a(localclientnum);
    foreach (var_a4250c2b in array(17 + 1, 17 + 1 + 8 + 1)) {
        var_ac044d12 = data.inventory.items[var_a4250c2b];
        var_fdc9fcff = var_a4250c2b == 17 + 1 ? 17 + 1 + 8 + 1 : 17 + 1;
        var_ffd2f6e4 = data.inventory.items[var_fdc9fcff];
        foreach (var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
            var_f9f8c0b5 = var_a4250c2b + var_259f58f3;
            var_50f8a92d = var_fdc9fcff + var_259f58f3;
            var_ac517de7 = data.inventory.items[var_f9f8c0b5];
            var_3c2da577 = data.inventory.items[var_50f8a92d];
            if (var_ac517de7.networkid === 32767 || !isdefined(var_ac517de7.var_a6762160)) {
                continue;
            }
            if (var_3c2da577.networkid === 32767 || !isdefined(var_3c2da577.var_a6762160)) {
                if (isdefined(var_ffd2f6e4) && isdefined(var_ffd2f6e4.var_a6762160) && isdefined(namespace_a0d533d1::function_2ced1d34(var_ffd2f6e4, var_ac517de7.var_a6762160))) {
                    setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 2);
                    continue;
                }
                setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 0);
                continue;
            }
            if (isdefined(namespace_a0d533d1::function_2ced1d34(var_ffd2f6e4, var_ac517de7.var_a6762160)) && isdefined(namespace_a0d533d1::function_2ced1d34(var_ac044d12, var_3c2da577.var_a6762160))) {
                setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 3);
                continue;
            }
            setuimodelvalue(createuimodel(var_ac517de7.itemuimodel, "canTransferAttachment"), 0);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xfccf9792, Offset: 0x8998
// Size: 0x58
function is_inventory_item(localclientnum, var_a6762160) {
    data = item_world::function_a7e98a1a(localclientnum);
    if (var_a6762160.itemtype == #"ammo") {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xf850614c, Offset: 0x89f8
// Size: 0x2c
function function_a303c8ef(localclientnum, var_a6762160) {
    return isdefined(function_daf3ebda(localclientnum, var_a6762160));
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x52c1db96, Offset: 0x8a30
// Size: 0x336
function function_daf3ebda(localclientnum, var_a6762160) {
    if (function_7d5553ac()) {
        return undefined;
    }
    if (!is_true(var_a6762160.stackable)) {
        return undefined;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    maxstack = namespace_a0d533d1::function_cfa794ca(data.inventory.var_7658cbec, var_a6762160);
    if (maxstack <= 1) {
        return undefined;
    }
    clientdata = item_world::function_a7e98a1a(localclientnum);
    if (var_a6762160.itemtype == #"resource") {
        if (item_world_util::function_41f06d9d(var_a6762160) && isdefined(clientdata.inventory) && clientdata.inventory.items[9].count < maxstack) {
            return 9;
        }
        var_ee79c3a4 = clientdata.inventory.items[10];
        if (!isdefined(var_ee79c3a4.id) || var_ee79c3a4.id == 32767) {
            return 10;
        }
        if (var_ee79c3a4.var_a6762160.name !== var_a6762160.name) {
            return undefined;
        }
        if (var_ee79c3a4.count < maxstack) {
            return 10;
        }
        return undefined;
    }
    if (var_a6762160.itemtype == #"armor_shard") {
        if (clientdata.inventory.items[11].count < maxstack) {
            return 11;
        }
        return undefined;
    }
    for (i = 0; i < clientdata.inventory.items.size; i++) {
        if (!isdefined(clientdata.inventory.items[i].id) || clientdata.inventory.items[i].id == 32767) {
            continue;
        }
        inventoryitem = function_b1702735(clientdata.inventory.items[i].id);
        if (!isdefined(inventoryitem) || !isdefined(inventoryitem.var_a6762160)) {
            continue;
        }
        if (inventoryitem.var_a6762160.name !== var_a6762160.name) {
            continue;
        }
        if (clientdata.inventory.items[i].count < maxstack) {
            return i;
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xf19e96a7, Offset: 0x8d70
// Size: 0x236
function private function_3e624606(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("15b92451ab6f1bf");
    self endon("15b92451ab6f1bf");
    clientdata = item_world::function_a7e98a1a(localclientnum);
    var_99fe8c78 = "multi_item_pickup" + localclientnum;
    var_dab12fb1 = "multi_item_pickup_stowed_weapon" + localclientnum;
    while (true) {
        waitresult = level waittill(var_99fe8c78, var_dab12fb1);
        if (self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
            networkid = waitresult.id;
            index = item_world::function_73436347(clientdata.groupitems, networkid);
            itemid = item_world::function_28b42f1c(localclientnum, networkid);
            if (itemid == 32767) {
                continue;
            }
            if (isdefined(index)) {
                item = function_b1702735(itemid);
                if (!function_ad4c6116(localclientnum, item.var_a6762160)) {
                    continue;
                }
                if (waitresult._notify === var_dab12fb1) {
                    function_97fedb0d(localclientnum, 12, networkid);
                } else {
                    function_97fedb0d(localclientnum, 3, networkid);
                }
                function_7f056944(localclientnum, index);
                if (!is_inventory_item(localclientnum, item.var_a6762160)) {
                    continue;
                }
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x69bc4a31, Offset: 0x8fb0
// Size: 0x172
function private function_30697356(*localclientnum, var_a6762160) {
    if (!isdefined(var_a6762160)) {
        return 0;
    }
    if (var_a6762160.itemtype === #"armor_shard") {
        return 6;
    }
    if (is_true(var_a6762160.consumable)) {
        return 4;
    }
    if (var_a6762160.itemtype === #"generic") {
        return 0;
    }
    if (var_a6762160.itemtype === #"cash") {
        return 0;
    }
    if (var_a6762160.itemtype === #"killstreak") {
        return 4;
    }
    if (var_a6762160.itemtype === #"armor") {
        return 0;
    }
    if (var_a6762160.itemtype === #"ammo") {
        return 0;
    }
    if (var_a6762160.itemtype == #"weapon") {
        return 0;
    }
    if (var_a6762160.itemtype == #"quest") {
        return 0;
    }
    if (var_a6762160.itemtype === #"attachment") {
        return 2;
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xa9d1a285, Offset: 0x9130
// Size: 0x690
function function_ad4c6116(localclientnum, var_a6762160) {
    if (var_a6762160.itemtype == #"weapon") {
        return 1;
    }
    if (!is_inventory_item(localclientnum, var_a6762160)) {
        return 1;
    }
    if (var_a6762160.itemtype == #"resource") {
        if (item_world_util::function_41f06d9d(var_a6762160)) {
            return !function_88da0c8e(localclientnum);
        }
    }
    if (var_a6762160.itemtype == #"armor") {
        if (var_a6762160.var_4a1a4613 === #"armor_heal") {
            data = item_world::function_a7e98a1a(localclientnum);
            var_8b8faf32 = self getplayerarmor();
            maxarmor = self function_a07288ec();
            armortier = 0;
            var_fda5463f = data.inventory.items[6];
            if (isdefined(var_fda5463f) && var_fda5463f.networkid != 32767) {
                armortier = var_fda5463f.var_a6762160.armortier;
            }
            armortier = isdefined(armortier) ? armortier : 0;
            if ((isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 0) > armortier) {
                return 1;
            }
            if ((isdefined(maxarmor) ? maxarmor : 0) != 0 && var_8b8faf32 == maxarmor) {
                return 0;
            }
        }
        return 1;
    }
    if (var_a6762160.itemtype == #"attachment") {
        slotid = function_1415f8f1(localclientnum, var_a6762160);
        if (isdefined(slotid)) {
            return 1;
        }
    }
    if (function_a243ddd6(localclientnum, var_a6762160)) {
        return 1;
    }
    if (function_a303c8ef(localclientnum, var_a6762160)) {
        return 1;
    }
    if (var_a6762160.itemtype == #"armor_shard") {
        return 0;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    if (var_a6762160.itemtype == #"resource") {
        if (data.inventory.items[10].networkid === 32767) {
            return 1;
        }
        return 0;
    }
    if (var_a6762160.itemtype === #"survival_ammo") {
        canpickup = self function_4d0a2ba4(localclientnum);
        return canpickup;
    }
    if (var_a6762160.itemtype === #"survival_perk") {
        var_6c32d092 = 0;
        if (isdefined(var_a6762160.talents)) {
            foreach (talent in var_a6762160.talents) {
                if (self function_6c32d092(localclientnum, talent.talent)) {
                    var_6c32d092 = 1;
                    break;
                }
            }
        }
        return !var_6c32d092;
    }
    if (var_a6762160.itemtype === #"survival_armor_shard") {
        var_8b8faf32 = self getplayerarmor();
        maxarmor = self function_a07288ec();
        if (maxarmor <= 0) {
            return 0;
        }
        if (var_8b8faf32 == maxarmor) {
            return 0;
        }
        return 1;
    }
    if (var_a6762160.itemtype == #"survival_scrap") {
        return 1;
    }
    if (var_a6762160.itemtype == #"survival_essence") {
        return 1;
    }
    if (var_a6762160.itemtype == #"hash_fc797c2a8f4d208") {
        data = item_world::function_a7e98a1a(localclientnum);
        ammoweapon = var_a6762160.weapon;
        var_1326fcc7 = isdefined(var_a6762160.amount) ? var_a6762160.amount : isdefined(var_1326fcc7) ? var_1326fcc7 : 1;
        var_2f399b51 = namespace_a0d533d1::function_2879cbe0(data.inventory.var_7658cbec, ammoweapon);
        currentammostock = self getweaponammostock(localclientnum, ammoweapon);
        var_9b9ba643 = var_2f399b51 - currentammostock;
        addammo = int(min(var_1326fcc7, var_9b9ba643));
        return (addammo > 0);
    }
    if (!namespace_a0d533d1::function_819781bf()) {
        for (i = 0; i < data.inventory.var_c212de25; i++) {
            if (data.inventory.items[i].networkid === 32767) {
                return 1;
            }
        }
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x2ddfdc91, Offset: 0x97c8
// Size: 0x4bc
function function_a243ddd6(localclientnum, var_a6762160) {
    data = item_world::function_a7e98a1a(localclientnum);
    if (namespace_a0d533d1::function_819781bf()) {
        var_662e1704 = 1;
    } else {
        var_662e1704 = 0;
    }
    switch (var_a6762160.itemtype) {
    case #"attachment":
        slotid = function_1415f8f1(localclientnum, var_a6762160);
        if (!isdefined(slotid)) {
            return false;
        }
        return (data.inventory.items[slotid].networkid == 32767);
    case #"armor":
        return (data.inventory.items[6].networkid == 32767);
    case #"backpack":
        return (data.inventory.items[8].networkid == 32767);
    case #"equipment":
        return (var_662e1704 || data.inventory.items[7].networkid == 32767);
    case #"field_upgrade":
        return (var_662e1704 || data.inventory.items[12].networkid == 32767);
    case #"tactical":
        return (var_662e1704 || data.inventory.items[13].networkid == 32767);
    case #"health":
        return (var_662e1704 || data.inventory.items[5].networkid == 32767);
    case #"weapon":
        return (data.inventory.items[17 + 1].networkid == 32767 || data.inventory.items[17 + 1 + 8 + 1].networkid == 32767);
    case #"perk_tier_1":
        point = function_4ba8fde(#"hash_383a1390efa15e8a");
        return (var_662e1704 || data.inventory.items[14].networkid == point.id);
    case #"perk_tier_2":
        point = function_4ba8fde(#"hash_383a1390efa15e8a");
        return (var_662e1704 || data.inventory.items[15].networkid == point.id);
    case #"perk_tier_3":
        point = function_4ba8fde(#"hash_383a1390efa15e8a");
        return (var_662e1704 || data.inventory.items[16].networkid == point.id);
    case #"scorestreak":
        point = function_4ba8fde(#"scorestreak_item_t9");
        return (var_662e1704 || data.inventory.items[17].networkid == point.id);
    case #"ammo":
    case #"generic":
    case #"killstreak":
    case #"cash":
    default:
        return false;
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x2019a922, Offset: 0x9c90
// Size: 0xe2
function function_d768ea30(localclientnum) {
    assert(isplayer(self));
    currentweapon = isdefined(self.currentweapon) ? weapons::function_251ec78c(self.currentweapon) : self.weapon;
    if (currentweapon == level.weaponbasemeleeheld) {
        data = item_world::function_a7e98a1a(localclientnum);
        return;
    }
    if (function_9f1cc9a9(currentweapon) > 0) {
        return (17 + 1 + 8 + 1);
    }
    return 17 + 1;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x908c991e, Offset: 0x9d80
// Size: 0x384
function function_78ed4455(localclientnum, var_a6762160) {
    assert(isplayer(self));
    data = item_world::function_a7e98a1a(localclientnum);
    switch (var_a6762160.itemtype) {
    case #"armor":
        return 6;
    case #"backpack":
        return 8;
    case #"equipment":
        if (data.inventory.items[7].networkid == 32767) {
            return 7;
        }
        break;
    case #"field_upgrade":
        if (data.inventory.items[12].networkid == 32767) {
            return 12;
        }
        break;
    case #"tactical":
        if (data.inventory.items[13].networkid == 32767) {
            return 13;
        }
        break;
    case #"health":
        if (data.inventory.items[5].networkid == 32767) {
            return 5;
        }
        break;
    case #"weapon":
        if (data.inventory.items[17 + 1].networkid == 32767) {
            return (17 + 1);
        } else if (data.inventory.items[17 + 1 + 8 + 1].networkid == 32767) {
            return (17 + 1 + 8 + 1);
        }
        break;
    case #"scorestreak":
        if (data.inventory.items[17].networkid == 32767) {
            return 17;
        }
        break;
    case #"perk_tier_1":
        if (data.inventory.items[14].networkid == 32767) {
            return 14;
        }
        break;
    case #"perk_tier_2":
        if (data.inventory.items[15].networkid == 32767) {
            return 15;
        }
        break;
    case #"perk_tier_3":
        if (data.inventory.items[16].networkid == 32767) {
            return 16;
        }
        break;
    }
    if (var_a6762160.itemtype == #"attachment") {
        return function_1415f8f1(localclientnum, var_a6762160);
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x1 linked
// Checksum 0xec6fc30c, Offset: 0xa110
// Size: 0x27c
function function_9c4460e0(localclientnum, itemid, count = 1, slotid = undefined) {
    assert(isint(itemid));
    if (!isdefined(itemid)) {
        return;
    }
    point = function_b1702735(itemid);
    if (!isdefined(point)) {
        return;
    }
    var_a6762160 = point.var_a6762160;
    availableaction = function_30697356(localclientnum, var_a6762160);
    data = item_world::function_a7e98a1a(localclientnum);
    selectedindex = undefined;
    if (count == 0) {
        return;
    }
    if (!isdefined(selectedindex) && isdefined(slotid)) {
        selectedindex = slotid;
    }
    if (!isdefined(selectedindex)) {
        selectedindex = item_world::function_73436347(data.inventory.items, 32767);
        if (!isdefined(selectedindex)) {
            println("<dev string:x38>" + itemid + "<dev string:x7a>");
            return;
        }
    }
    player = function_27673a7(localclientnum);
    networkid = item_world_util::function_970b8d86(selectedindex);
    inventoryitem = undefined;
    if (selectedindex < data.inventory.items.size) {
        inventoryitem = data.inventory.items[selectedindex];
    }
    assert(isdefined(inventoryitem));
    totalcount = function_bba770de(localclientnum, var_a6762160);
    totalcount += count;
    player function_1a99656a(localclientnum, inventoryitem, networkid, itemid, count, totalcount, availableaction);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xd640dfb6, Offset: 0xa398
// Size: 0x17c
function function_1415f8f1(localclientnum, var_a6762160) {
    assert(isplayer(self));
    data = item_world::function_a7e98a1a(localclientnum);
    if (var_a6762160.itemtype == #"attachment") {
        var_4838b749 = function_d768ea30(localclientnum);
        if (!isdefined(var_4838b749)) {
            return;
        }
        var_f0dc4e93 = item_world_util::function_970b8d86(var_4838b749);
        if (data.inventory.items[var_4838b749].networkid == 32767) {
            return;
        }
        var_ceefbd10 = namespace_a0d533d1::function_837f4a57(var_a6762160);
        var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
        weaponitem = self function_15d578f4(localclientnum, var_f0dc4e93);
        attachmentname = namespace_a0d533d1::function_2ced1d34(weaponitem, var_a6762160);
        if (isdefined(attachmentname)) {
            return var_f9f8c0b5;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x92e7a96, Offset: 0xa520
// Size: 0x168
function function_bba770de(localclientnum, var_a6762160) {
    data = item_world::function_a7e98a1a(localclientnum);
    count = 0;
    if (!isdefined(var_a6762160)) {
        return count;
    }
    name = isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name;
    for (index = 0; index < data.inventory.items.size && index < 17 + 1; index++) {
        inventoryitem = data.inventory.items[index];
        if (!isdefined(inventoryitem.var_a6762160) || isdefined(inventoryitem.endtime)) {
            continue;
        }
        if (name == (isdefined(inventoryitem.var_a6762160.parentname) ? inventoryitem.var_a6762160.parentname : inventoryitem.var_a6762160.name)) {
            count += inventoryitem.count;
        }
    }
    return count;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xc282d802, Offset: 0xa690
// Size: 0x102
function function_eeab09d6(talent) {
    switch (talent) {
    case #"hash_75fc14c83c2558d6":
        return #"hash_210097a75bb6c49a";
    case #"hash_4328584be9c34d32":
        return #"hash_4110e6372aa77f7e";
    case #"hash_3c460440a624b110":
        return #"talent_juggernog";
    case #"hash_677c6dddba8fbb86":
        return #"hash_7f98b3dd3cce95aa";
    case #"hash_53cf3948c8c89f96":
        return #"hash_5930cf0eb070e35a";
    case #"hash_4c43d91560234da1":
        return #"hash_602a1b6107105f07";
    case #"hash_6853ebf21abb287":
        return #"hash_51b6cc6dbafb7f31";
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x772eb400, Offset: 0xa7a0
// Size: 0x24e
function function_4d0a2ba4(localclientnum) {
    var_452ce25f = isdefined(level.var_13339abf) ? level.var_13339abf : array(#"ammo_small_caliber_item_t9", #"ammo_large_caliber_item_t9", #"ammo_ar_item_t9", #"ammo_sniper_item_t9", #"ammo_shotgun_item_t9", #"ammo_special_item_t9");
    var_e20637be = 1;
    data = item_world::function_a7e98a1a(localclientnum);
    foreach (ammo_item in var_452ce25f) {
        var_a6762160 = getscriptbundle(ammo_item);
        if (isdefined(var_a6762160)) {
            ammoweapon = var_a6762160.weapon;
            var_1326fcc7 = isdefined(var_a6762160.amount) ? var_a6762160.amount : 25;
            if (isdefined(ammoweapon) && ammoweapon != level.weaponnone) {
                var_2f399b51 = namespace_a0d533d1::function_2879cbe0(data.inventory.var_7658cbec, ammoweapon);
                currentammostock = self getweaponammostock(localclientnum, ammoweapon);
                var_9b9ba643 = var_2f399b51 - currentammostock;
                if (var_9b9ba643 != 0) {
                    var_e20637be = 0;
                }
            }
        }
    }
    if (!var_e20637be) {
        return true;
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x279b2ed0, Offset: 0xa9f8
// Size: 0x176
function can_pickup_ammo(localclientnum, item, var_1326fcc7 = undefined) {
    assert(isplayer(self));
    data = item_world::function_a7e98a1a(localclientnum);
    var_a6762160 = item.var_a6762160;
    ammoweapon = var_a6762160.weapon;
    var_1326fcc7 = isdefined(var_a6762160.amount) ? var_a6762160.amount : isdefined(var_1326fcc7) ? var_1326fcc7 : 1;
    var_2f399b51 = namespace_a0d533d1::function_2879cbe0(data.inventory.var_7658cbec, ammoweapon);
    currentammostock = self getweaponammostock(localclientnum, ammoweapon);
    var_9b9ba643 = var_2f399b51 - currentammostock;
    addammo = int(min(var_1326fcc7, var_9b9ba643));
    return addammo > 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0xc8aca9a6, Offset: 0xab78
// Size: 0xe2
function private function_85645978(data, item) {
    currtime = gettime();
    foreach (consumeditem in data.inventory.consumed.items) {
        if (item.var_a6762160.name == consumeditem.var_a6762160.name && currtime < consumeditem.endtime) {
            return consumeditem;
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xebf7532d, Offset: 0xac68
// Size: 0x126
function function_52e537be(localclientnum, networkid) {
    item = function_15d578f4(localclientnum, networkid);
    if (isdefined(item)) {
        setuimodelvalue(createuimodel(item.itemuimodel, "castTimeFraction"), 0, 0);
    }
    data = item_world::function_a7e98a1a(localclientnum);
    if (isdefined(data) && isdefined(data.inventory) && networkid === data.inventory.var_4d4ec560) {
        setuimodelvalue(data.inventory.consumed.var_a25538fb, function_3fe6ef04(localclientnum));
        data.inventory.var_4d4ec560 = undefined;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x7fa009d2, Offset: 0xad98
// Size: 0x4fc
function consume_item(localclientnum, networkid) {
    assert(networkid != 32767);
    if (networkid == 32767) {
        return;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    item = function_15d578f4(localclientnum, networkid);
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return;
    }
    duration = int((isdefined(item.var_a6762160.duration) ? item.var_a6762160.duration : 0) * 1000);
    starttime = gettime();
    endtime = starttime + duration;
    item.starttime = starttime;
    item.endtime = endtime;
    totalcount = function_bba770de(localclientnum, item.var_a6762160);
    function_1a99656a(localclientnum, item, networkid, item.id, 1, totalcount, 5, 0);
    var_3285d88f = data.inventory.consumed.items.size;
    var_cfa0e915 = [];
    foreach (consumeditem in data.inventory.consumed.items) {
        if (isdefined(var_cfa0e915[consumeditem.var_a6762160.name])) {
            continue;
        }
        var_cfa0e915[consumeditem.var_a6762160.name] = 1;
    }
    consumeditem = function_85645978(data, item);
    if (isdefined(consumeditem)) {
        consumeditem.endtime += duration;
        for (index = 0; index < 5; index++) {
            inventoryitem = data.inventory.items[index];
            if (!isdefined(inventoryitem.endtime)) {
                continue;
            }
            if (inventoryitem.var_a6762160.name == item.var_a6762160.name) {
                inventoryitem.starttime = consumeditem.starttime;
                inventoryitem.endtime = consumeditem.endtime;
            }
        }
    } else {
        consumeditem = spawnstruct();
        consumeditem.id = item.id;
        consumeditem.var_a6762160 = item.var_a6762160;
        consumeditem.itemuimodel = createuimodel(data.inventory.consumed.uimodel, "item" + var_cfa0e915.size);
        consumeditem.starttime = gettime();
        consumeditem.endtime = consumeditem.starttime + duration;
        var_cfa0e915[consumeditem.var_a6762160.name] = 1;
    }
    data.inventory.consumed.items[var_3285d88f] = consumeditem;
    var_31c78e6f = consumeditem.var_a6762160;
    function_1a99656a(localclientnum, consumeditem, 32767, 32767, 0, 0, 0, 0);
    function_1a99656a(localclientnum, consumeditem, networkid, item.id, 0, 0, 0, 0);
    setuimodelvalue(data.inventory.consumed.var_a25538fb, var_cfa0e915.size);
    function_442857e2(localclientnum, var_31c78e6f);
    level thread function_451ebd83(localclientnum, consumeditem.var_a6762160, networkid);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xda7383d1, Offset: 0xb2a0
// Size: 0x28c
function function_de74158f(localclientnum, networkid) {
    assert(networkid != 32767);
    if (networkid == 32767) {
        return;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    item = function_15d578f4(localclientnum, networkid);
    if (!isdefined(item)) {
        return;
    }
    var_cfa0e915 = [];
    foreach (consumeditem in data.inventory.consumed.items) {
        if (isdefined(var_cfa0e915[consumeditem.var_a6762160.name])) {
            continue;
        }
        var_cfa0e915[consumeditem.var_a6762160.name] = 1;
    }
    consumeditem = spawnstruct();
    consumeditem.id = item.id;
    consumeditem.var_a6762160 = item.var_a6762160;
    consumeditem.itemuimodel = createuimodel(data.inventory.consumed.uimodel, "item" + var_cfa0e915.size);
    var_cfa0e915[consumeditem.var_a6762160.name] = 1;
    function_1a99656a(localclientnum, consumeditem, 32767, 32767, 0, 0, 0, 0);
    function_1a99656a(localclientnum, consumeditem, networkid, item.id, 0, 0, 0, 0);
    setuimodelvalue(data.inventory.consumed.var_a25538fb, var_cfa0e915.size);
    level thread function_451ebd83(localclientnum, item.var_a6762160, undefined);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x845a7dd3, Offset: 0xb538
// Size: 0x84
function function_7f056944(localclientnum, index) {
    var_6e2c91d0 = function_1df4c3b0(localclientnum, #"hash_23febb0b8f867ca1");
    setuimodelvalue(createuimodel(var_6e2c91d0, "item" + index + ".disabled"), 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x5eae7ae3, Offset: 0xb5c8
// Size: 0x132
function function_3bd1836f(localclientnum, networkid) {
    if (networkid == item_world_util::function_970b8d86(8)) {
        give_backpack(localclientnum, networkid);
        return;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    foreach (inventoryitem in data.inventory.items) {
        if (inventoryitem.networkid === networkid) {
            function_8063170(inventoryitem, 1);
            playsound(localclientnum, #"hash_4d31bd9927d823c3");
            return;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x26c276f0, Offset: 0xb708
// Size: 0x204
function give_backpack(localclientnum, networkid) {
    data = item_world::function_a7e98a1a(localclientnum);
    if (!isdefined(data)) {
        return;
    }
    item = function_15d578f4(localclientnum, networkid);
    if (!isdefined(item)) {
        waittillframeend();
        item = function_15d578f4(localclientnum, networkid);
        if (!isdefined(item)) {
            return;
        }
    }
    data.inventory.var_7658cbec = namespace_a0d533d1::function_d8cebda3(item.var_a6762160);
    if (data.inventory.var_7658cbec & 1 && data.inventory.var_c212de25 != 5) {
        for (index = data.inventory.var_c212de25; index < 5; index++) {
            inventoryitem = data.inventory.items[index];
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "disabled"), 0);
        }
        data.inventory.var_c212de25 = 5;
        inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
        setuimodelvalue(createuimodel(inventoryuimodel, "count"), data.inventory.var_c212de25);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x54862e1f, Offset: 0xb918
// Size: 0xfe
function function_15d578f4(localclientnum, networkid) {
    assert(isdefined(localclientnum));
    assert(item_world_util::function_d9648161(networkid));
    data = item_world::function_a7e98a1a(localclientnum);
    assert(isdefined(data));
    for (index = 0; index < data.inventory.items.size; index++) {
        inventoryitem = data.inventory.items[index];
        if (inventoryitem.networkid === networkid) {
            return inventoryitem;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xf9a6ad9f, Offset: 0xba20
// Size: 0x4c
function function_c48cd17f(localclientnum, networkid) {
    item = function_15d578f4(localclientnum, networkid);
    if (isdefined(item)) {
        return item.id;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xde22eb2f, Offset: 0xba78
// Size: 0x140
function has_attachments(localclientnum, var_4838b749) {
    assert(isdefined(localclientnum));
    if (!isdefined(var_4838b749)) {
        return false;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    foreach (var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
        slotid = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_259f58f3);
        if (data.inventory.items[slotid].networkid != 32767) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x6745f119, Offset: 0xbbc0
// Size: 0xf74
function inventory_init(localclientnum) {
    data = item_world::function_a7e98a1a(localclientnum);
    inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
    pickedupammotypes = createuimodel(inventoryuimodel, "pickedUpAmmoTypes");
    setuimodelvalue(createuimodel(pickedupammotypes, "count"), 0);
    data.inventory = spawnstruct();
    data.inventory.consumed = {};
    data.inventory.consumed.items = [];
    data.inventory.count = 17 + 1 + 8 + 1 + 8 + 1;
    data.inventory.items = [];
    data.inventory.var_a7a2b773 = 0;
    data.inventory.var_c212de25 = 3;
    data.inventory.var_7658cbec = 0;
    data.inventory.var_f3518190 = undefined;
    data.inventory.var_4d4ec560 = undefined;
    for (index = 0; index < data.inventory.count; index++) {
        data.inventory.items[index] = spawnstruct();
    }
    for (index = 0; index < 3; index++) {
        data.inventory.items[index].itemuimodel = createuimodel(inventoryuimodel, "item" + index);
        setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "backpackSlot"), 0);
        setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "disabled"), 0);
    }
    for (index = 3; index < 5; index++) {
        data.inventory.items[index].itemuimodel = createuimodel(inventoryuimodel, "item" + index);
        setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "backpackSlot"), 1);
        setuimodelvalue(createuimodel(data.inventory.items[index].itemuimodel, "disabled"), 1);
    }
    data.inventory.items[5].itemuimodel = createuimodel(inventoryuimodel, "health");
    data.inventory.items[6].itemuimodel = createuimodel(inventoryuimodel, "gear");
    data.inventory.items[8].itemuimodel = createuimodel(inventoryuimodel, "storage");
    data.inventory.items[7].itemuimodel = createuimodel(inventoryuimodel, "equipment");
    data.inventory.items[12].itemuimodel = createuimodel(inventoryuimodel, "fieldUpgrade");
    data.inventory.items[13].itemuimodel = createuimodel(inventoryuimodel, "tactical");
    data.inventory.items[9].itemuimodel = createuimodel(inventoryuimodel, "resource0");
    data.inventory.items[10].itemuimodel = createuimodel(inventoryuimodel, "resource1");
    data.inventory.items[11].itemuimodel = createuimodel(inventoryuimodel, "shard0");
    foreach (index, slotid in array(14, 15, 16)) {
        data.inventory.items[slotid].itemuimodel = createuimodel(inventoryuimodel, "perk" + index);
    }
    data.inventory.items[17].itemuimodel = createuimodel(inventoryuimodel, "scorestreak");
    weaponslots = array(17 + 1, 17 + 1 + 8 + 1);
    for (index = 0; index < weaponslots.size; index++) {
        var_4838b749 = weaponslots[index];
        data.inventory.items[var_4838b749].itemuimodel = createuimodel(inventoryuimodel, "weapon" + index);
        var_55022c4f = array(1, 2, 3, 4, 5, 6, 7, 8);
        for (attachmentindex = 0; attachmentindex < var_55022c4f.size; attachmentindex++) {
            var_259f58f3 = var_55022c4f[attachmentindex];
            var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_259f58f3);
            uimodelindex = attachmentindex + index * var_55022c4f.size;
            data.inventory.items[var_f9f8c0b5].itemuimodel = createuimodel(inventoryuimodel, "attachment" + uimodelindex);
        }
    }
    for (index = 0; index < data.inventory.items.size; index++) {
        if (!isdefined(data.inventory.items[index].itemuimodel)) {
            continue;
        }
        function_1a99656a(localclientnum, data.inventory.items[index], 32767, 32767, 0, 0, 0);
    }
    data.inventory.healthitems = [];
    for (index = 0; index < 2; index++) {
        data.inventory.healthitems[index] = spawnstruct();
        data.inventory.healthitems[index].itemuimodel = createuimodel(inventoryuimodel, "health" + index);
        function_1a99656a(localclientnum, data.inventory.healthitems[index], 32767, 32767, 0, 0, 0);
    }
    data.inventory.equipmentitems = [];
    for (index = 0; index < 2; index++) {
        data.inventory.equipmentitems[index] = spawnstruct();
        data.inventory.equipmentitems[index].itemuimodel = createuimodel(inventoryuimodel, "equipment" + index);
        function_1a99656a(localclientnum, data.inventory.equipmentitems[index], 32767, 32767, 0, 0, 0);
    }
    data.inventory.var_d4de469a = [];
    for (index = 0; index < 2; index++) {
        data.inventory.var_d4de469a[index] = spawnstruct();
        data.inventory.var_d4de469a[index].itemuimodel = createuimodel(inventoryuimodel, "fieldUpgrade" + index);
        function_1a99656a(localclientnum, data.inventory.var_d4de469a[index], 32767, 32767, 0, 0, 0);
    }
    data.inventory.var_cb8b68cf = [];
    for (index = 0; index < 2; index++) {
        data.inventory.var_cb8b68cf[index] = spawnstruct();
        data.inventory.var_cb8b68cf[index].itemuimodel = createuimodel(inventoryuimodel, "scorestreak" + index);
        function_1a99656a(localclientnum, data.inventory.var_cb8b68cf[index], 32767, 32767, 0, 0, 0);
    }
    setuimodelvalue(createuimodel(inventoryuimodel, "count"), 3);
    setuimodelvalue(createuimodel(inventoryuimodel, "filledSlots"), 0);
    setuimodelvalue(createuimodel(inventoryuimodel, "attachmentCount"), 8);
    setuimodelvalue(createuimodel(inventoryuimodel, "resourceCount"), 1);
    setuimodelvalue(createuimodel(inventoryuimodel, "perkCount"), array(14, 15, 16).size);
    setuimodelvalue(createuimodel(inventoryuimodel, "scorestreakCount"), 1);
    setuimodelvalue(createuimodel(inventoryuimodel, "shardCount"), 1);
    setuimodelvalue(createuimodel(inventoryuimodel, "canUseQuickInventory"), 0);
    if (function_88da0c8e(localclientnum)) {
        setuimodelvalue(createuimodel(data.inventory.items[9].itemuimodel, "notAccessible"), 1);
    }
    data.inventory.consumed.uimodel = createuimodel(inventoryuimodel, "consumed");
    data.inventory.consumed.var_a25538fb = createuimodel(data.inventory.consumed.uimodel, "count");
    setuimodelvalue(data.inventory.consumed.var_a25538fb, 0);
    level thread function_dab42db1(localclientnum);
    level thread function_d7869556(localclientnum);
    level thread function_cf96d951(localclientnum);
    level thread function_3b3ad5c2(localclientnum);
    level thread function_99bb24f8(localclientnum);
    forcenotifyuimodel(createuimodel(inventoryuimodel, "initialize"));
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x7286ca55, Offset: 0xcb40
// Size: 0x1ec
function function_dab42db1(localclientnum) {
    level flag::wait_till(#"item_world_initialized");
    foreach (ammotype in array(#"ammo_small_caliber_item_t9", #"ammo_large_caliber_item_t9", #"ammo_ar_item_t9", #"ammo_sniper_item_t9", #"ammo_shotgun_item_t9", #"ammo_special_item_t9")) {
        point = function_4ba8fde(ammotype);
        if (isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"ammo") {
            function_4f16aa30(localclientnum, point.id);
        }
    }
    inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
    pickedupammotypes = createuimodel(inventoryuimodel, "pickedUpAmmoTypes");
    forcenotifyuimodel(pickedupammotypes);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xb8a01ea5, Offset: 0xcd38
// Size: 0xf4
function function_cf96d951(localclientnum) {
    level flag::wait_till(#"item_world_initialized");
    data = item_world::function_a7e98a1a(localclientnum);
    point = function_4ba8fde(#"armor_shard_item");
    if (isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"armor_shard") {
        function_1a99656a(localclientnum, data.inventory.items[11], point.networkid, point.id, 0, 0, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xc8e1b325, Offset: 0xce38
// Size: 0xf4
function function_d7869556(localclientnum) {
    level flag::wait_till(#"item_world_initialized");
    data = item_world::function_a7e98a1a(localclientnum);
    point = function_4ba8fde(#"resource_item_paint");
    if (isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"resource") {
        function_1a99656a(localclientnum, data.inventory.items[9], point.networkid, point.id, 0, 0, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x67b495fc, Offset: 0xcf38
// Size: 0x178
function function_3b3ad5c2(localclientnum) {
    level flag::wait_till(#"item_world_initialized");
    data = item_world::function_a7e98a1a(localclientnum);
    point = function_4ba8fde(#"hash_383a1390efa15e8a");
    if (isdefined(point) && isdefined(point.var_a6762160) && item_world_util::function_a57773a4(point.var_a6762160)) {
        foreach (slotid in array(14, 15, 16)) {
            function_1a99656a(localclientnum, data.inventory.items[slotid], point.networkid, point.id, 0, 0, 0);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xc4c68cc8, Offset: 0xd0b8
// Size: 0xf4
function function_99bb24f8(localclientnum) {
    level flag::wait_till(#"item_world_initialized");
    data = item_world::function_a7e98a1a(localclientnum);
    point = function_4ba8fde(#"scorestreak_item_t9");
    if (isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.itemtype == #"scorestreak") {
        function_1a99656a(localclientnum, data.inventory.items[17], point.networkid, point.id, 0, 0, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xa5d44f67, Offset: 0xd1b8
// Size: 0x3b8
function private function_534dcb9c(localclientnum) {
    if (!isdefined(level.var_af8f97c8) || !isdefined(level.var_af8f97c8[localclientnum])) {
        if (!isdefined(level.var_aa75d3e)) {
            level.var_aa75d3e = [];
        } else if (!isarray(level.var_aa75d3e)) {
            level.var_aa75d3e = array(level.var_aa75d3e);
        }
        if (!isdefined(level.var_af8f97c8)) {
            level.var_af8f97c8 = [];
        } else if (!isarray(level.var_af8f97c8)) {
            level.var_af8f97c8 = array(level.var_af8f97c8);
        }
        if (!isdefined(level.var_53cbbb33)) {
            level.var_53cbbb33 = [];
        } else if (!isarray(level.var_53cbbb33)) {
            level.var_53cbbb33 = array(level.var_53cbbb33);
        }
        if (!isdefined(level.var_3a0390dd)) {
            level.var_3a0390dd = [];
        } else if (!isarray(level.var_3a0390dd)) {
            level.var_3a0390dd = array(level.var_3a0390dd);
        }
        if (!isdefined(level.var_c8a5f79b)) {
            level.var_c8a5f79b = [];
        } else if (!isarray(level.var_c8a5f79b)) {
            level.var_c8a5f79b = array(level.var_c8a5f79b);
        }
        if (!isdefined(level.var_7086ad4f)) {
            level.var_7086ad4f = [];
        } else if (!isarray(level.var_7086ad4f)) {
            level.var_7086ad4f = array(level.var_7086ad4f);
        }
        inventoryuimodel = function_1df4c3b0(localclientnum, #"hash_159966ba825013a2");
        level.var_aa75d3e[localclientnum] = createuimodel(inventoryuimodel, "currentWeaponIndex");
        level.var_af8f97c8[localclientnum] = createuimodel(inventoryuimodel, "currentWeapon");
        level.var_c8a5f79b[localclientnum] = createuimodel(inventoryuimodel, "currentWeapon.ammoType");
        level.var_53cbbb33[localclientnum] = createuimodel(inventoryuimodel, "currentWeapon.isOperator");
        level.var_3a0390dd[localclientnum] = createuimodel(inventoryuimodel, "currentWeapon.isTactical");
        level.var_7086ad4f[localclientnum] = createuimodel(inventoryuimodel, "showAttachments");
        level.var_6d21daaf[localclientnum] = createuimodel(inventoryuimodel, "canTransferFromStash");
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xc8944532, Offset: 0xd578
// Size: 0x8b4
function function_6231c19(params) {
    if (params.weapon.name == #"none") {
        return;
    }
    if (isstruct(self)) {
        return;
    }
    if (!self function_da43934d() || !isplayer(self) || !isalive(self)) {
        return;
    }
    function_534dcb9c(params.localclientnum);
    if (isdefined(params.weapon)) {
        data = item_world::function_a7e98a1a(params.localclientnum);
        if (!isdefined(data) || !isdefined(data.inventory) || !isdefined(data.inventory.items) || data.inventory.items.size == 0) {
            return;
        }
        self.currentweapon = params.weapon;
        if (params.weapon == level.weaponbasemeleeheld) {
            setuimodelvalue(level.var_7086ad4f[params.localclientnum], 0);
            itemindex = getbaseweaponitemindex(getweapon(#"none"));
            foreach (index, slot in array(17 + 1, 17 + 1 + 8 + 1)) {
                if (data.inventory.items[slot].networkid == 32767) {
                    break;
                }
            }
            if (!isdefined(index)) {
                return;
            }
            setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
            setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
            if (!setuimodelvalue(level.var_aa75d3e[params.localclientnum], index)) {
                forcenotifyuimodel(level.var_aa75d3e[params.localclientnum]);
            }
            if (!setuimodelvalue(level.var_af8f97c8[params.localclientnum], itemindex)) {
                forcenotifyuimodel(level.var_af8f97c8[params.localclientnum]);
            }
            function_deddbdf0(params.localclientnum);
            function_ce628f27(params.localclientnum);
            return;
        }
        var_a4250c2b = self function_d768ea30(params.localclientnum);
        foreach (index, slot in array(17 + 1, 17 + 1 + 8 + 1)) {
            if (slot === var_a4250c2b) {
                if (!setuimodelvalue(level.var_aa75d3e[params.localclientnum], index)) {
                    forcenotifyuimodel(level.var_aa75d3e[params.localclientnum]);
                }
                break;
            }
        }
        networkid = item_world_util::function_970b8d86(var_a4250c2b);
        item = function_15d578f4(params.localclientnum, networkid);
        if (isdefined(item) && isdefined(item.var_a6762160) && is_true(item.var_a6762160.var_340eac1f)) {
            setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
            setuimodelvalue(level.var_3a0390dd[params.localclientnum], 1);
        } else if (isdefined(item) && isdefined(item.var_a6762160) && is_true(item.var_a6762160.var_dc6c5d3b)) {
            setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
            setuimodelvalue(level.var_53cbbb33[params.localclientnum], 1);
        } else {
            setuimodelvalue(level.var_3a0390dd[params.localclientnum], 0);
            setuimodelvalue(level.var_53cbbb33[params.localclientnum], 0);
        }
        if (isdefined(params.weapon.statname) && params.weapon.statname != #"") {
            itemindex = getbaseweaponitemindex(getweapon(params.weapon.statname));
        } else {
            itemindex = getbaseweaponitemindex(params.weapon);
        }
        var_754fe8c5 = getweaponammotype(params.weapon);
        if (isdefined(level.var_c53d118f) && isdefined(level.var_c53d118f[var_754fe8c5])) {
            setuimodelvalue(level.var_c8a5f79b[params.localclientnum], level.var_c53d118f[var_754fe8c5]);
        } else {
            setuimodelvalue(level.var_c8a5f79b[params.localclientnum], #"");
        }
        setuimodelvalue(level.var_af8f97c8[params.localclientnum], itemindex);
        forcenotifyuimodel(level.var_af8f97c8[params.localclientnum]);
        supportsattachments = 0;
        if (isdefined(item)) {
            supportsattachments = namespace_a0d533d1::function_4bd83c04(item);
        }
        setuimodelvalue(level.var_7086ad4f[params.localclientnum], supportsattachments);
        function_deddbdf0(params.localclientnum, var_a4250c2b);
        function_ce628f27(params.localclientnum);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x44a2c0c3, Offset: 0xde38
// Size: 0x18c
function function_8ffee46f(localclientnum, item) {
    var_f9b70cae = createuimodel(function_1df4c3b0(localclientnum, #"hash_159966ba825013a2"), "pickedUpItem");
    itemname = item_world::get_item_name(item.var_a6762160);
    if (!setuimodelvalue(var_f9b70cae, itemname)) {
        forcenotifyuimodel(var_f9b70cae);
    }
    if (item.var_a6762160.itemtype == #"weapon") {
        var_d9659d2a = createuimodel(function_1df4c3b0(localclientnum, #"hash_159966ba825013a2"), "pickedUpWeapon");
        if (!setuimodelvalue(var_d9659d2a, itemname)) {
            forcenotifyuimodel(var_d9659d2a);
        }
        return;
    }
    if (item.var_a6762160.itemtype == #"generic") {
        function_22759012(localclientnum, item.networkid);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x872d586, Offset: 0xdfd0
// Size: 0x64
function function_c9764f6d(localclientnum) {
    var_80c295ff = createuimodel(function_1df4c3b0(localclientnum, #"hash_159966ba825013a2"), "droppedWeapon");
    forcenotifyuimodel(var_80c295ff);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x6ddd59b9, Offset: 0xe040
// Size: 0x12c
function function_451ebd83(localclientnum, item, networkid) {
    itemname = item_world::get_item_name(item);
    waittillframeend();
    var_e16dbee1 = createuimodel(function_1df4c3b0(localclientnum, #"hash_159966ba825013a2"), "consumedItem");
    if (!setuimodelvalue(var_e16dbee1, itemname)) {
        forcenotifyuimodel(var_e16dbee1);
    }
    data = item_world::function_a7e98a1a(localclientnum);
    if (isdefined(data) && isdefined(data.inventory) && networkid === data.inventory.var_4d4ec560) {
        data.inventory.var_4d4ec560 = undefined;
    }
    function_9f5d2dc8(localclientnum);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x496d9d63, Offset: 0xe178
// Size: 0x4d4
function function_4f16aa30(localclientnum, itemid) {
    if (!isdefined(level.var_c53d118f)) {
        level.var_c53d118f = [];
    }
    assert(item_world_util::function_2c7fc531(itemid));
    item = function_b1702735(itemid);
    if (!isdefined(item.var_a6762160)) {
        return;
    }
    var_754fe8c5 = getweaponammotype(item.var_a6762160.weapon);
    if (!isdefined(var_754fe8c5) || item.var_a6762160.itemtype !== #"ammo") {
        return;
    }
    var_f9b70cae = createuimodel(function_1df4c3b0(localclientnum, #"hash_159966ba825013a2"), "pickedUpItem");
    var_7268d07 = createuimodel(function_1df4c3b0(localclientnum, #"hash_159966ba825013a2"), "pickedUpAmmoTypes");
    var_5a2db7bb = createuimodel(var_7268d07, "count");
    var_b4676aed = getuimodelvalue(var_5a2db7bb);
    for (i = 0; i < var_b4676aed; i++) {
        var_acd2831f = createuimodel(var_7268d07, "" + i + 1);
        if (getuimodelvalue(createuimodel(var_acd2831f, "assetName")) == var_754fe8c5) {
            if (item.var_a6762160.itemtype == #"ammo" && !getuimodelvalue(createuimodel(var_acd2831f, "canDrop"))) {
                setuimodelvalue(createuimodel(var_acd2831f, "id"), itemid);
                setuimodelvalue(createuimodel(var_acd2831f, "canDrop"), item.var_a6762160.itemtype == #"ammo");
            }
            return;
        }
    }
    level.var_c53d118f[var_754fe8c5] = item.var_a6762160.displayname;
    var_acd2831f = createuimodel(var_7268d07, "" + var_b4676aed + 1);
    setuimodelvalue(createuimodel(var_acd2831f, "assetName"), var_754fe8c5);
    setuimodelvalue(createuimodel(var_acd2831f, "id"), itemid);
    setuimodelvalue(createuimodel(var_acd2831f, "canDrop"), 1);
    setuimodelvalue(createuimodel(var_acd2831f, "name"), item.var_a6762160.displayname);
    setuimodelvalue(createuimodel(var_acd2831f, "icon"), item.var_a6762160.icon);
    setuimodelvalue(createuimodel(var_acd2831f, "description"), item.var_a6762160.description);
    setuimodelvalue(var_5a2db7bb, var_b4676aed + 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xc726f7e2, Offset: 0xe658
// Size: 0x44a
function function_b1136fc8(localclientnum, item) {
    if (isdefined(item) && isdefined(item.origin) && isdefined(item.var_a6762160)) {
        if (isdefined(item.var_a6762160.var_36781d9f)) {
            playsound(localclientnum, item.var_a6762160.var_36781d9f, item.origin);
            return;
        }
        switch (item.var_a6762160.itemtype) {
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
        case #"field_upgrade":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"tactical":
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
        case #"quest":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"generic":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"cash":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"perk_tier_3":
        case #"perk_tier_2":
        case #"perk_tier_1":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        case #"scorestreak":
            playsound(localclientnum, #"fly_drop_generic", item.origin);
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x6329cd9f, Offset: 0xeab0
// Size: 0xa4
function function_d1da833d(localclientnum, item) {
    if (isdefined(item) && isdefined(item.origin) && isdefined(item.var_a6762160)) {
        if (isdefined(item.var_a6762160.var_1b0b57d1)) {
            playsound(localclientnum, item.var_a6762160.var_1b0b57d1, item.origin);
            return;
        }
        function_31868137(localclientnum, item);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x9b716fb4, Offset: 0xeb60
// Size: 0x44a
function function_31868137(localclientnum, item) {
    if (isdefined(item) && isdefined(item.origin) && isdefined(item.var_a6762160)) {
        if (isdefined(item.var_a6762160.pickupsound)) {
            playsound(localclientnum, item.var_a6762160.pickupsound, item.origin);
            return;
        }
        switch (item.var_a6762160.itemtype) {
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
        case #"field_upgrade":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        case #"tactical":
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
        case #"quest":
            playsound(localclientnum, #"hash_5738a0fcb2e4efca", item.origin);
            break;
        case #"generic":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        case #"cash":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        case #"perk_tier_3":
        case #"perk_tier_2":
        case #"perk_tier_1":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        case #"scorestreak":
            playsound(localclientnum, #"fly_pickup_generic", item.origin);
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x1a80a502, Offset: 0xefb8
// Size: 0x70c
function function_c6ff0aa2(localclientnum, networkid) {
    data = item_world::function_a7e98a1a(localclientnum);
    index = item_world::function_73436347(data.inventory.items, networkid);
    if (!isdefined(index)) {
        println("<dev string:xa5>" + networkid + "<dev string:xbf>");
        return;
    }
    item = data.inventory.items[index];
    isweapon = isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"weapon";
    var_53aa3063 = isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"generic";
    var_ac3edb34 = item.var_a6762160;
    if (isdefined(item.endtime)) {
        consumeditem = function_85645978(data, item);
        if (isdefined(consumeditem)) {
            var_ee0e9af9 = [];
            for (index = 0; index < 5; index++) {
                inventoryitem = data.inventory.items[index];
                if (!isdefined(inventoryitem.endtime)) {
                    continue;
                }
                if (inventoryitem.var_a6762160.name == item.var_a6762160.name) {
                    var_ee0e9af9[var_ee0e9af9.size] = inventoryitem;
                }
            }
            remaining = consumeditem.endtime - gettime();
            consumeditem.endtime -= remaining / var_ee0e9af9.size;
            for (index = 0; index < var_ee0e9af9.size; index++) {
                inventoryitem = var_ee0e9af9[index];
                inventoryitem.starttime = consumeditem.starttime;
                inventoryitem.endtime = consumeditem.endtime;
            }
        }
    }
    hasdefault = 0;
    if (item_world_util::function_a57773a4(item.var_a6762160)) {
        slotid = item_world_util::function_808be9a3(networkid);
        foreach (var_204192a2 in array(14, 15, 16)) {
            if (slotid == var_204192a2) {
                hasdefault = 1;
                break;
            }
        }
        if (hasdefault) {
            point = function_4ba8fde(#"hash_383a1390efa15e8a");
            var_6fd9b15e = point.id;
            var_904ed6d7 = point.id;
        }
    } else if (item.var_a6762160.itemtype == #"scorestreak") {
        slotid = item_world_util::function_808be9a3(networkid);
        if (slotid == 17) {
            hasdefault = 1;
            point = function_4ba8fde(#"scorestreak_item_t9");
            var_6fd9b15e = point.id;
            var_904ed6d7 = point.id;
        }
    }
    if (hasdefault) {
        function_1a99656a(localclientnum, item, var_6fd9b15e, var_904ed6d7, 0, 0, 0, 1, 0, 0);
    } else {
        function_1a99656a(localclientnum, item, 32767, 32767, 0, 0, 0, 1, 0, 0);
    }
    player = function_27673a7(localclientnum);
    if (player.weapon.name == #"none" || player.weapon.name == #"bare_hands") {
        var_a4250c2b = player function_d768ea30(localclientnum);
        if (isdefined(var_a4250c2b) && var_a4250c2b == index) {
            primaryweapons = player getweaponslistprimaries();
            nextweapon = level.weaponbasemeleeheld;
            foreach (weapon in primaryweapons) {
                if (weapon !== weapons::function_251ec78c(player.currentweapon)) {
                    nextweapon = weapon;
                    break;
                }
            }
            var_a3eec6f2 = spawnstruct();
            var_a3eec6f2.localclientnum = localclientnum;
            var_a3eec6f2.weapon = nextweapon;
            player function_6231c19(var_a3eec6f2);
        }
    }
    if (index == 8) {
        take_backpack(localclientnum, networkid);
    }
    if (isweapon) {
        function_c9764f6d(localclientnum);
        function_ce628f27(localclientnum);
        return;
    }
    if (var_53aa3063) {
        function_9f5d2dc8(localclientnum);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xcc874677, Offset: 0xf6d0
// Size: 0x10c
function function_8063170(inventoryitem, equipped) {
    if (!isdefined(inventoryitem) || !isdefined(inventoryitem.var_a6762160)) {
        return;
    }
    if (inventoryitem.var_a6762160.itemtype === #"armor_shard") {
        return;
    }
    if (inventoryitem.var_a6762160.itemtype === #"attachment" || inventoryitem.var_a6762160.itemtype === #"weapon") {
        availableaction = inventoryitem.availableaction;
    } else {
        availableaction = inventoryitem.availableaction && !equipped;
    }
    setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "availableAction"), availableaction);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0xe24b4f2d, Offset: 0xf7e8
// Size: 0x314
function function_26c87da8(localclientnum, var_c9293a27, var_8f194e5a) {
    assert(isdefined(var_c9293a27) && isdefined(var_8f194e5a));
    if (var_c9293a27 == var_8f194e5a) {
        return;
    }
    data = item_world::function_a7e98a1a(localclientnum);
    fromitem = data.inventory.items[var_c9293a27];
    toitem = data.inventory.items[var_8f194e5a];
    var_23501832 = fromitem.networkid;
    var_a2dd129a = fromitem.id;
    var_b208c7e1 = fromitem.var_a6762160;
    var_3907299e = fromitem.count;
    var_57b0c2f = fromitem.availableaction;
    var_9269cd0a = toitem.networkid;
    var_d3a45360 = toitem.id;
    var_ec763bb2 = toitem.var_a6762160;
    var_532f304 = toitem.count;
    var_ad138826 = toitem.availableaction;
    player = function_27673a7(localclientnum);
    if (var_3907299e == 0) {
        var_23501832 = 32767;
    }
    player function_1a99656a(localclientnum, toitem, var_23501832 != 32767 ? item_world_util::function_970b8d86(var_8f194e5a) : 32767, var_a2dd129a, var_3907299e, function_bba770de(localclientnum, var_b208c7e1), var_57b0c2f, undefined, 1);
    if (var_532f304 == 0) {
        var_9269cd0a = 32767;
    }
    player function_1a99656a(localclientnum, fromitem, var_9269cd0a != 32767 ? item_world_util::function_970b8d86(var_c9293a27) : 32767, var_d3a45360, var_532f304, function_bba770de(localclientnum, var_ec763bb2), var_ad138826, undefined, 1);
    function_442857e2(localclientnum, var_ec763bb2);
    function_442857e2(localclientnum, var_b208c7e1);
    function_ce628f27(localclientnum);
    var_a4250c2b = player function_d768ea30(localclientnum);
    function_deddbdf0(localclientnum, var_a4250c2b);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xccde65d2, Offset: 0xfb08
// Size: 0x15c
function take_backpack(localclientnum, *networkid) {
    data = item_world::function_a7e98a1a(networkid);
    data.inventory.var_7658cbec = 0;
    if (data.inventory.var_c212de25 == 5) {
        for (index = 3; index < 5; index++) {
            inventoryitem = data.inventory.items[index];
            setuimodelvalue(createuimodel(inventoryitem.itemuimodel, "disabled"), 1);
        }
        data.inventory.var_c212de25 = 3;
        inventoryuimodel = function_1df4c3b0(networkid, #"hash_159966ba825013a2");
        setuimodelvalue(createuimodel(inventoryuimodel, "count"), data.inventory.var_c212de25);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x4a19f2ac, Offset: 0xfc70
// Size: 0xdc
function function_fa372100(localclientnum, networkid) {
    data = item_world::function_a7e98a1a(localclientnum);
    foreach (inventoryitem in data.inventory.items) {
        if (inventoryitem.networkid === networkid) {
            function_8063170(inventoryitem, 0);
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0xabaa8bc8, Offset: 0xfd58
// Size: 0x1bc
function update_inventory_item(localclientnum, networkid, count) {
    data = item_world::function_a7e98a1a(localclientnum);
    player = function_27673a7(localclientnum);
    foreach (inventoryslot, inventoryitem in data.inventory.items) {
        if (inventoryitem.networkid === networkid) {
            var_338e8597 = isdefined(inventoryitem.count) ? inventoryitem.count : 0;
            totalcount = function_bba770de(localclientnum, inventoryitem.var_a6762160);
            totalcount += max(0, count - var_338e8597);
            function_1a99656a(localclientnum, inventoryitem, inventoryitem.networkid, inventoryitem.id, count, totalcount, inventoryitem.availableaction);
            function_8063170(inventoryitem, function_6d9d9cd7(inventoryslot));
            break;
        }
    }
}

