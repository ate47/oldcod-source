#namespace item_world_util;

// Namespace item_world_util/item_world_util
// Params 0, eflags: 0x2
// Checksum 0xbf839dc8, Offset: 0x68
// Size: 0x156
function autoexec __init__() {
    level.var_1009d80e = function_6d8c00fb();
    level.var_6133c885 = function_85c13b79();
    level.var_2e7718a9 = function_a6df0c16();
    level.var_fda5b4e9 = 100 * (14 + 1 + 6 + 1 + 6 + 1);
    level.var_3db62ec = level.var_1009d80e - 2;
    assert(level.var_3db62ec + 1 == 32767);
    level.var_2bddb774 = level.var_3db62ec;
    level.var_e93fa9c6 = level.var_2bddb774 - level.var_fda5b4e9;
    level.var_5c693cc6 = level.var_e93fa9c6 - 1;
    level.var_426f3ab8 = level.var_6133c885;
    level.var_5604329f = level.var_426f3ab8 - 1;
    level.var_b5759be5 = 0;
}

// Namespace item_world_util/item_world_util
// Params 2, eflags: 0x0
// Checksum 0x3fe7fa42, Offset: 0x1c8
// Size: 0x148
function function_5b57f1f9(player, networkid) {
    assert(player isplayer());
    assert(networkid >= level.var_e93fa9c6 && networkid <= level.var_2bddb774);
    entnum = player getentitynumber();
    assert(entnum < 100);
    slotid = networkid - level.var_e93fa9c6 - entnum * (14 + 1 + 6 + 1 + 6 + 1);
    assert(slotid >= 0 && slotid < 14 + 1 + 6 + 1 + 6 + 1);
    return slotid;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x2fc2b180, Offset: 0x318
// Size: 0x130
function function_4dec3654(item) {
    assert(isdefined(item));
    if (!isdefined(item)) {
        return 32767;
    }
    if (isstruct(item)) {
        assert(isdefined(item.id));
        assert(item.id >= level.var_b5759be5 && item.id <= level.var_5604329f);
        return item.id;
    }
    entnum = item getentitynumber();
    networkid = entnum + level.var_426f3ab8;
    assert(networkid >= level.var_426f3ab8 && networkid <= level.var_5c693cc6);
    return networkid;
}

// Namespace item_world_util/item_world_util
// Params 3, eflags: 0x0
// Checksum 0x7f689c98, Offset: 0x450
// Size: 0x1a8
function function_5a578f3(player, slotid, attachmentoffset = undefined) {
    assert(player isplayer());
    if (isdefined(attachmentoffset)) {
        assert(attachmentoffset <= 6);
        slotid += attachmentoffset;
    }
    assert(slotid >= 0 && slotid < 14 + 1 + 6 + 1 + 6 + 1);
    entnum = player getentitynumber();
    assert(entnum < 100);
    numoffset = entnum * (14 + 1 + 6 + 1 + 6 + 1) + slotid;
    networkid = numoffset + level.var_e93fa9c6;
    assert(networkid >= level.var_e93fa9c6 && networkid <= level.var_2bddb774);
    return networkid;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x62fd413, Offset: 0x600
// Size: 0x36
function function_94aad908(item) {
    return isdefined(item.networkid) ? item.networkid : item.id;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x89024b89, Offset: 0x640
// Size: 0x3e
function get_itemtype(itementry) {
    return isdefined(itementry.var_a8dd3e4b) ? itementry.var_a8dd3e4b.name : itementry.name;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0xc272aac4, Offset: 0x688
// Size: 0x32
function function_2dd7d7a4(id) {
    return id >= level.var_426f3ab8 && id <= level.var_5c693cc6;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x1fb0c489, Offset: 0x6c8
// Size: 0x32
function function_486a6ba1(id) {
    return id >= level.var_e93fa9c6 && id <= level.var_2bddb774;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0xdbc56f66, Offset: 0x708
// Size: 0xba
function function_4b1b9689(point) {
    maxx = 65536;
    maxy = 65536;
    maxz = 65536;
    return abs(point[0]) < maxx || abs(point[1]) < maxy || abs(point[2]) < maxz;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0xd93798dc, Offset: 0x7d0
// Size: 0x32
function function_a04a2a1f(id) {
    return id >= level.var_b5759be5 && id <= level.var_5604329f;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x1e777782, Offset: 0x810
// Size: 0x2c
function function_9628594b(id) {
    return id >= level.var_b5759be5 && id <= 32767;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0xcaced0aa, Offset: 0x848
// Size: 0x11e
function function_fe2abb62(itementry) {
    if (isdefined(itementry.weapon) && isarray(itementry.attachments)) {
        attachments = [];
        foreach (attachment in itementry.attachments) {
            attachments[attachments.size] = attachment.attachment_type;
        }
        weapon = getweapon(itementry.weapon.name, attachments);
        return function_814b27f0(weapon);
    } else {
        return itementry.weapon;
    }
    return undefined;
}

// Namespace item_world_util/item_world_util
// Params 1, eflags: 0x0
// Checksum 0x73d0fa5a, Offset: 0x970
// Size: 0x72
function function_4f1a8d4a(itemid) {
    assert(function_a04a2a1f(itemid));
    itementry = function_9c3c6ff2(itemid).itementry;
    return function_fe2abb62(itementry);
}

