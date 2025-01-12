#using scripts\mp_common\item_world_util;

#namespace item_inventory_util;

// Namespace item_inventory_util/item_inventory_util
// Params 2, eflags: 0x4
// Checksum 0x7d5e7aed, Offset: 0xe0
// Size: 0x8a
function private function_a14b4446(attachmentitem, attachmentname) {
    attachment = spawnstruct();
    attachment.id = attachmentitem.id;
    attachment.networkid = attachmentitem.networkid;
    attachment.itementry = attachmentitem.itementry;
    attachment.var_ed1b5a38 = attachmentname;
    return attachment;
}

// Namespace item_inventory_util/item_inventory_util
// Params 3, eflags: 0x0
// Checksum 0x986fb23e, Offset: 0x178
// Size: 0x298
function function_6bed1918(item, attachmentitem, var_a3a14ef4 = 1) {
    assert(isstruct(item));
    assert(isstruct(attachmentitem));
    if (!isdefined(item) || !isdefined(item.itementry) || item.itementry.itemtype != #"weapon") {
        return false;
    }
    if (!isdefined(attachmentitem) || !isdefined(attachmentitem.itementry) || attachmentitem.itementry.itemtype != #"attachment") {
        return false;
    }
    if (isdefined(item.attachments)) {
        foreach (attachment in item.attachments) {
            if (attachment.networkid == attachmentitem.networkid) {
                return false;
            }
        }
    }
    attachmentname = function_580900d1(item, attachmentitem.itementry);
    if (!isdefined(attachmentname)) {
        return false;
    }
    attachmentitem.var_ed1b5a38 = attachmentname;
    if (!isdefined(item.attachments)) {
        item.attachments = [];
    } else if (!isarray(item.attachments)) {
        item.attachments = array(item.attachments);
    }
    item.attachments[item.attachments.size] = attachmentitem;
    if (var_a3a14ef4) {
        function_70701256(item);
    }
    return true;
}

// Namespace item_inventory_util/item_inventory_util
// Params 3, eflags: 0x0
// Checksum 0xb114cee9, Offset: 0x418
// Size: 0x4ac
function function_580900d1(item, var_e40f00dd, allowdupes = 0) {
    assert(isstruct(item));
    assert(isdefined(var_e40f00dd));
    if (item.itementry.itemtype != #"weapon") {
        assert(0, "<dev string:x30>");
        return;
    }
    if (var_e40f00dd.itemtype != #"attachment") {
        assert(0, "<dev string:x5d>");
        return;
    }
    if (!isdefined(var_e40f00dd.attachments) || var_e40f00dd.attachments.size <= 0) {
        return;
    }
    weapon = item_world_util::function_fe2abb62(item.itementry);
    if (isdefined(weapon.statname) && weapon.statname != #"") {
        weapon = getweapon(weapon.statname);
    }
    if (!isdefined(weapon.supportedattachments) || weapon.supportedattachments.size <= 0) {
        return;
    }
    supportedattachments = weapon.supportedattachments;
    var_297c0464 = undefined;
    foreach (attachment in var_e40f00dd.attachments) {
        attachmenttype = attachment.attachment_type;
        if (!isdefined(attachmenttype) || attachmenttype == "") {
            continue;
        }
        foreach (var_fd079d02 in weapon.supportedattachments) {
            if (attachmenttype == var_fd079d02) {
                var_297c0464 = attachmenttype;
                break;
            }
        }
        if (isdefined(var_297c0464)) {
            break;
        }
    }
    if (!isdefined(var_297c0464)) {
        return;
    }
    if (isdefined(item.attachments) && !allowdupes) {
        foreach (attachment in item.attachments) {
            if (attachment.var_ed1b5a38 === var_297c0464) {
                return;
            }
        }
    }
    foreach (slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock")) {
        if (!isdefined(var_e40f00dd.(slot))) {
            continue;
        }
        if (var_e40f00dd.(slot) && !(isdefined(item.itementry.(slot)) && item.itementry.(slot))) {
            return;
        }
    }
    return var_297c0464;
}

// Namespace item_inventory_util/item_inventory_util
// Params 2, eflags: 0x0
// Checksum 0xfe63a435, Offset: 0x8d0
// Size: 0x1e
function function_e7a671d8(weaponid, attachmentoffset) {
    return weaponid + attachmentoffset;
}

// Namespace item_inventory_util/item_inventory_util
// Params 1, eflags: 0x0
// Checksum 0x4a526003, Offset: 0x8f8
// Size: 0x142
function function_82cb86b6(var_e40f00dd) {
    if (!isdefined(var_e40f00dd) || var_e40f00dd.itemtype != #"attachment") {
        return;
    }
    slots = array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock");
    offsets = array(1, 2, 3, 4, 5, 6);
    assert(slots.size == offsets.size);
    for (index = 0; index < offsets.size; index++) {
        slot = slots[index];
        if (!isdefined(var_e40f00dd.(slot))) {
            continue;
        }
        return offsets[index];
    }
}

// Namespace item_inventory_util/item_inventory_util
// Params 1, eflags: 0x0
// Checksum 0xd879fa69, Offset: 0xa48
// Size: 0x10a
function function_3b6b07b6(item) {
    assert(isstruct(item));
    foreach (slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock")) {
        if (isdefined(item.itementry.(slot)) && item.itementry.(slot)) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory_util/item_inventory_util
// Params 1, eflags: 0x0
// Checksum 0xfacd1319, Offset: 0xb60
// Size: 0x14c
function function_39d39caa(slotid) {
    assert(isdefined(slotid));
    foreach (weaponslot in array(14 + 1, 14 + 1 + 6 + 1)) {
        foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
            if (slotid == weaponslot + attachmentoffset) {
                return true;
            }
        }
    }
    return false;
}

// Namespace item_inventory_util/item_inventory_util
// Params 2, eflags: 0x0
// Checksum 0xb8e88a5, Offset: 0xcb8
// Size: 0xe0
function function_c32bed23(weaponslotid, var_7bae3009) {
    assert(isdefined(weaponslotid));
    assert(isdefined(var_7bae3009));
    foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6)) {
        if (var_7bae3009 == weaponslotid + attachmentoffset) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory_util/item_inventory_util
// Params 3, eflags: 0x0
// Checksum 0x5f3fd4f8, Offset: 0xda0
// Size: 0x210
function function_962387cc(item, attachmentitem, var_a3a14ef4 = 1) {
    assert(isstruct(item));
    assert(isstruct(attachmentitem));
    if (!isdefined(item) || !isdefined(item.attachments) || item.attachments.size <= 0 || !isdefined(item.itementry) || item.itementry.itemtype != #"weapon") {
        return 0;
    }
    if (!isdefined(attachmentitem) || !isdefined(attachmentitem.itementry) || attachmentitem.itementry.itemtype != #"attachment") {
        return 0;
    }
    var_77fe42a8 = 0;
    for (index = 0; index < item.attachments.size; index++) {
        attachment = item.attachments[index];
        if (attachment.networkid === attachmentitem.networkid) {
            var_77fe42a8 = 1;
            arrayremoveindex(item.attachments, index, 0);
            break;
        }
    }
    if (var_77fe42a8 && var_a3a14ef4) {
        function_70701256(item);
    }
    return var_77fe42a8;
}

// Namespace item_inventory_util/item_inventory_util
// Params 1, eflags: 0x0
// Checksum 0x8c85cebf, Offset: 0xfb8
// Size: 0x16e
function function_70701256(item) {
    assert(isdefined(item));
    weapon = item_world_util::function_fe2abb62(item.itementry);
    if (!isdefined(weapon)) {
        return;
    }
    attachments = weapon.attachments;
    if (isdefined(item.attachments)) {
        foreach (attachment in item.attachments) {
            attachments[attachments.size] = attachment.var_ed1b5a38;
        }
    }
    if (isdefined(item.var_1974e8e6) && item.var_1974e8e6) {
        attachments[attachments.size] = "null";
    }
    weapon = getweapon(weapon.name, attachments);
    weapon = function_814b27f0(weapon);
    item.var_3e4720d3 = weapon;
}

// Namespace item_inventory_util/item_inventory_util
// Params 1, eflags: 0x0
// Checksum 0x80a8756c, Offset: 0x1130
// Size: 0x5a
function function_370ccb8a(item) {
    assert(isdefined(item));
    if (isdefined(item.var_3e4720d3)) {
        return item.var_3e4720d3;
    }
    return item_world_util::function_fe2abb62(item.itementry);
}

