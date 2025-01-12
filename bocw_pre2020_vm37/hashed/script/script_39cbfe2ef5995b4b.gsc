#using script_1caf36ff04a85ff6;
#using script_471b31bd963b388e;
#using scripts\core_common\aat_shared;
#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;

#namespace namespace_efff98ec;

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 0, eflags: 0x6
// Checksum 0x9196f003, Offset: 0xb0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_fd2ea50703c7073", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 0, eflags: 0x5 linked
// Checksum 0x9e6a7100, Offset: 0x100
// Size: 0x2c
function private function_70a657d8() {
    if (item_inventory::function_7d5553ac()) {
        return;
    }
    function_116fd9a7();
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 0, eflags: 0x5 linked
// Checksum 0x53275f68, Offset: 0x138
// Size: 0x3f4
function private function_116fd9a7() {
    item_world::function_861f348d(#"hash_9ed0c30684ca35a", &function_d045e83b);
    item_world::function_861f348d(#"hash_76a324a4d6073913", &function_2e5b5858);
    item_world::function_861f348d(#"hash_3bfb97e39d67e5f9", &function_cb9b4dd7);
    item_world::function_861f348d(#"hash_788c59214ead02af", &function_14b2eddf);
    item_world::function_861f348d(#"hash_6247ea34d3b1ddb6", &function_42ffe9b2);
    item_world::function_861f348d(#"hash_2cbf15cbb314c93e", &function_2eebeff5);
    item_world::function_861f348d(#"hash_51b30f6e7331e136", &function_349d4c26);
    item_world::function_861f348d(#"hash_2b4dff2e0db72d06", &function_670cce3f);
    item_world::function_861f348d(#"generic_pickup", &function_41a52251);
    item_world::function_861f348d(#"hash_5c844f5c1207159c", &function_2b2e9302);
    item_world::function_861f348d(#"hash_57df81951e3bc37c", &function_7de52ecc);
    item_world::function_861f348d(#"hash_1f0d729dc6dd1202", &function_898628ef);
    item_world::function_861f348d(#"hash_31380667bf69d3a0", &function_a240798a);
    item_world::function_861f348d(#"hash_29f7ad396d214a52", &function_d46c2559);
    item_world::function_861f348d(#"hash_50375e5de228e9fc", &function_a712496a);
    item_world::function_861f348d(#"hash_ff2bc61e2c18f43", &function_80ef3ea5);
    item_world::function_861f348d(#"hash_4213c4725d9f115", &function_753fb11f);
    item_world::function_861f348d(#"hash_68c089ceb01f806b", &function_2650d5c6);
    item_world::function_861f348d(#"hash_3115e37ace8310b1", &function_c3f4d281);
    item_world::function_861f348d(#"hash_292f5be0001274a4", &function_24dc1d12);
    item_world::function_861f348d(#"hash_1002a9af0882010e", &function_88803841);
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x919f9dbc, Offset: 0x538
// Size: 0x122
function private function_d045e83b(item, player, *networkid, itemid, *itemcount, var_aec6fa7f, *slot) {
    if (itemid.var_a6762160.itemtype !== #"ammo") {
        assertmsg("<dev string:x38>" + itemid.name + "<dev string:x42>");
        return 0;
    }
    if (!self item_inventory::can_pickup_ammo(itemid)) {
        return (isdefined(itemid.var_a6762160.amount) ? itemid.var_a6762160.amount : isdefined(slot) ? slot : 1);
    }
    itemcount function_b00db06(8, var_aec6fa7f);
    return itemcount item_inventory::equip_ammo(itemid, slot);
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xb090d2e8, Offset: 0x668
// Size: 0x3f8
function private function_2e5b5858(item, player, *networkid, *itemid, itemcount, var_aec6fa7f, slotid) {
    droppeditem = undefined;
    var_3d1f9df4 = 0;
    var_b0938bd7 = undefined;
    var_381f3b39 = 0;
    var_77e61fc6 = 0;
    if (networkid.var_a6762160.var_4a1a4613 === #"armor_swap") {
        if (itemid armor::has_armor()) {
            inventoryitem = itemid.inventory.items[6];
            if (inventoryitem.networkid != 32767) {
                droppeditem = inventoryitem.var_a6762160;
                var_3d1f9df4 = droppeditem.amount;
            }
        }
        itemid item_inventory::drop_armor();
        var_77e61fc6 = itemid item_inventory::give_inventory_item(networkid, 1, var_aec6fa7f, slotid);
        if (var_77e61fc6 < itemcount) {
            if (isdefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
                networkid = item_inventory::get_inventory_item(networkid.networkid);
            }
            if (itemid item_inventory::function_fba4a353(networkid)) {
                itemid item_inventory::equip_armor(networkid);
                var_b0938bd7 = networkid.var_a6762160;
                var_381f3b39 = networkid.var_a6762160.amount;
            }
        }
    } else if (networkid.var_a6762160.var_4a1a4613 === #"armor_heal") {
        noarmor = 1;
        if (itemid.armortier > 0) {
            if (networkid.var_a6762160.armortier > itemid.armortier) {
                inventoryitem = itemid.inventory.items[6];
                var_4d7e11d8 = itemid item_inventory::drop_inventory_item(inventoryitem.networkid);
                var_4d7e11d8 delete();
                noarmor = 1;
            } else {
                noarmor = 0;
                if (isdefined(itemid.armor) && isdefined(itemid.maxarmor)) {
                    inventoryitem = itemid.inventory.items[6];
                    inventoryitem.amount = itemid.maxarmor;
                    itemid.armor = itemid.maxarmor;
                }
            }
        }
        if (noarmor) {
            itemid item_inventory::give_inventory_item(networkid, 1, var_aec6fa7f, slotid);
            if (isdefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
                networkid = item_inventory::get_inventory_item(networkid.networkid);
            }
            if (itemid item_inventory::function_fba4a353(networkid)) {
                itemid item_inventory::equip_armor(networkid);
                var_b0938bd7 = networkid.var_a6762160;
                var_381f3b39 = networkid.var_a6762160.amount;
            }
        }
    }
    item_world::function_1a46c8ae(itemid, droppeditem, var_3d1f9df4, var_b0938bd7, var_381f3b39);
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x92133186, Offset: 0xa68
// Size: 0x80
function private function_cb9b4dd7(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    itemcount item_inventory::function_3d113bfb();
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xd72ad875, Offset: 0xaf0
// Size: 0x168
function private function_14b2eddf(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_f0dc4e93 = itemcount item_inventory::function_ec087745();
    var_4838b749 = undefined;
    if (isdefined(var_f0dc4e93) && var_f0dc4e93 != 32767) {
        var_4838b749 = itemcount item_inventory::function_b246c573(var_f0dc4e93);
    }
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    if (isdefined(var_4838b749) && isdefined(slotid) && namespace_a0d533d1::function_398b9770(var_4838b749, slotid)) {
        if (isdefined(itemid.networkid) && item_world_util::function_db35e94f(itemid.networkid)) {
            itemid = item_inventory::get_inventory_item(itemid.networkid);
        }
        itemcount item_inventory::equip_attachment(itemid, var_f0dc4e93, undefined, 0);
    }
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x33a9d05c, Offset: 0xc60
// Size: 0x108
function private function_42ffe9b2(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    if (itemcount item_inventory::function_fba4a353(itemid)) {
        slotid = 8;
    }
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    if (var_77e61fc6 < var_aec6fa7f && slotid === 8) {
        if (isdefined(itemid.networkid) && item_world_util::function_db35e94f(itemid.networkid)) {
            itemid = item_inventory::get_inventory_item(itemid.networkid);
        }
        itemcount item_inventory::equip_backpack(itemid);
    }
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xd2c95290, Offset: 0xd70
// Size: 0xe8
function private function_2eebeff5(item, player, *networkid, *itemid, itemcount, var_aec6fa7f, slotid) {
    var_77e61fc6 = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);
    if (var_77e61fc6 < itemcount) {
        if (isdefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
            networkid = item_inventory::get_inventory_item(networkid.networkid);
        }
        if (itemid item_inventory::function_fba4a353(networkid)) {
            itemid thread item_inventory::equip_equipment(networkid);
        }
    }
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x75fb8a94, Offset: 0xe60
// Size: 0xe8
function private function_349d4c26(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    if (var_77e61fc6 < var_aec6fa7f) {
        if (isdefined(itemid.networkid) && item_world_util::function_db35e94f(itemid.networkid)) {
            itemid = item_inventory::get_inventory_item(itemid.networkid);
        }
        if (itemcount item_inventory::function_fba4a353(itemid)) {
            itemcount thread item_inventory::equip_health(itemid);
        }
    }
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x844fff58, Offset: 0xf50
// Size: 0x6a
function private function_670cce3f(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x4b8c83e6, Offset: 0xfc8
// Size: 0x6a
function private function_41a52251(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xea4b3dae, Offset: 0x1040
// Size: 0x90
function private function_2b2e9302(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    itemcount callback::callback(#"hash_3b891b6daa75c782", itemid);
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x97614db3, Offset: 0x10d8
// Size: 0xe8
function private function_7de52ecc(item, player, *networkid, *itemid, itemcount, var_aec6fa7f, slotid) {
    var_77e61fc6 = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);
    if (var_77e61fc6 < itemcount) {
        if (isdefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
            networkid = item_inventory::get_inventory_item(networkid.networkid);
        }
        if (itemid item_inventory::function_fba4a353(networkid)) {
            itemid thread item_inventory::function_854cf2c3(networkid);
        }
    }
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xc52bb94a, Offset: 0x11c8
// Size: 0x100
function private function_898628ef(item, player, *networkid, *itemid, itemcount, var_aec6fa7f, slotid) {
    var_77e61fc6 = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);
    stockammo = networkid.stockammo;
    if (var_77e61fc6 < itemcount) {
        if (isdefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
            networkid = item_inventory::get_inventory_item(networkid.networkid);
        }
        if (itemid item_inventory::function_fba4a353(networkid)) {
            itemid thread item_inventory::function_1ac37022(networkid, stockammo);
        }
    }
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xd94e484d, Offset: 0x12d0
// Size: 0x6a
function private function_a240798a(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, slotid) {
    var_77e61fc6 = itemcount item_inventory::give_inventory_item(itemid, var_aec6fa7f, undefined, slotid);
    return var_77e61fc6;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x23183bf, Offset: 0x1348
// Size: 0x3e
function private function_24dc1d12(*item, *player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x825fcc66, Offset: 0x1390
// Size: 0x306
function private function_c3f4d281(item, *player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    nullweapon = getweapon(#"none");
    var_f945fa92 = getweapon(#"bare_hands");
    primaryweapon = self namespace_a0d533d1::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1));
    if (isdefined(primaryweapon) && primaryweapon != nullweapon && primaryweapon != var_f945fa92) {
        var_1326fcc7 = isdefined(slotid.var_a6762160.amount) ? slotid.var_a6762160.amount : 20;
        maxammo = primaryweapon.maxammo;
        var_e6527384 = maxammo * var_1326fcc7 / 100;
        currentammostock = self getweaponammostock(primaryweapon);
        var_e6527384 = currentammostock + var_e6527384;
        if (var_e6527384 < 0) {
            var_e6527384 = 0;
        } else if (var_e6527384 > maxammo) {
            var_e6527384 = maxammo;
        }
        self setweaponammostock(primaryweapon, int(var_e6527384));
    }
    var_824ff7c7 = self namespace_a0d533d1::function_2b83d3ff(self item_inventory::function_2e711614(17 + 1 + 8 + 1));
    if (isdefined(var_824ff7c7) && var_824ff7c7 != nullweapon && var_824ff7c7 != var_f945fa92) {
        var_1326fcc7 = isdefined(slotid.var_a6762160.amount) ? slotid.var_a6762160.amount : 20;
        maxammo = var_824ff7c7.maxammo;
        var_e6527384 = maxammo * var_1326fcc7 / 100;
        var_22baab7c = self getweaponammostock(var_824ff7c7);
        var_e6527384 = var_22baab7c + var_e6527384;
        if (var_e6527384 < 0) {
            var_e6527384 = 0;
        } else if (var_e6527384 > maxammo) {
            var_e6527384 = maxammo;
        }
        self setweaponammostock(var_824ff7c7, int(var_e6527384));
    }
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xdc04fcdc, Offset: 0x16a0
// Size: 0x3e
function private function_80ef3ea5(*item, *player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xbf3c80bd, Offset: 0x16e8
// Size: 0x3e
function private function_753fb11f(*item, *player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x42ad90dd, Offset: 0x1730
// Size: 0x3e
function private function_88803841(*item, *player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xa51e89d0, Offset: 0x1778
// Size: 0x56
function private function_d46c2559(item, *player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    item_drop::function_d8342646(slotid.var_25b21f27);
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0x5ba8e2ae, Offset: 0x17d8
// Size: 0x130
function private function_2650d5c6(*item, player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slotid) {
    var_2cacdde7 = 50;
    inventoryitem = slotid.inventory.items[6];
    if (isdefined(inventoryitem)) {
        var_2cacdde7 = isdefined(inventoryitem.var_a6762160.var_a3aa1ca2) ? inventoryitem.var_a6762160.var_a3aa1ca2 : 50;
        if (isdefined(level.var_8cc294a7)) {
            var_2cacdde7 = [[ level.var_8cc294a7 ]](var_2cacdde7);
        }
        if (var_2cacdde7 == 0) {
            var_2cacdde7 = 50;
        }
    }
    var_2cacdde7 = int(var_2cacdde7);
    self.armor += math::clamp(var_2cacdde7, 0, self.maxarmor);
    return false;
}

// Namespace namespace_efff98ec/namespace_efff98ec
// Params 7, eflags: 0x5 linked
// Checksum 0xaa70d00d, Offset: 0x1910
// Size: 0x3a0
function private function_a712496a(item, player, *networkid, *itemid, itemcount, var_aec6fa7f, slotid) {
    assert(isplayer(self));
    stockammo = networkid.stockammo;
    if (isdefined(networkid.weaponoverride)) {
        foreach (attachment in networkid.weaponoverride.attachments) {
            attachmentname = item_world_util::function_6a0ee21a(attachment);
            if (!isdefined(attachmentname)) {
                continue;
            }
            attachmentitem = item_world_util::function_49ce7663(attachmentname);
            if (!isdefined(attachmentitem)) {
                continue;
            }
            namespace_a0d533d1::function_9e9c82a6(networkid, attachmentitem);
        }
    }
    if (item_inventory::get_weapon_count() == 2) {
        stashitem = item_world_util::function_83c20f83(networkid);
        stashitem &= ~(isdefined(networkid.deathstash) ? networkid.deathstash : 0);
        weaponitem = item_inventory::function_230ceec4(itemid.currentweapon);
        if (!isdefined(weaponitem)) {
            itemid takeweapon(itemid.currentweapon);
        } else {
            itemid thread item_inventory::drop_inventory_item(weaponitem.networkid, stashitem, itemid.origin, isdefined(networkid.targetnamehash) ? networkid.targetnamehash : networkid.targetname);
        }
    }
    var_77e61fc6 = itemid item_inventory::give_inventory_item(networkid, itemcount, var_aec6fa7f, slotid);
    if (var_77e61fc6 < itemcount) {
        if (isdefined(networkid.networkid) && item_world_util::function_db35e94f(networkid.networkid)) {
            networkid = item_inventory::get_inventory_item(networkid.networkid);
        }
        if (isdefined(networkid.var_a6762160.var_b079a6e6)) {
            itemid item_inventory::function_b579540e(networkid, networkid.var_a6762160.var_b079a6e6);
            weapon = namespace_a0d533d1::function_2b83d3ff(networkid);
            itemid aat::acquire(weapon, networkid.var_a6762160.var_b079a6e6);
        }
        itemid item_inventory::equip_weapon(networkid, 1, 1, 0, 1, stockammo);
    }
    return var_77e61fc6;
}

