#using script_cb32d07c95e5628;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\match_record;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\armor;
#using scripts\mp_common\dynent_world;
#using scripts\mp_common\item_drop;
#using scripts\mp_common\item_inventory;
#using scripts\mp_common\item_inventory_util;
#using scripts\mp_common\item_spawn_groups;
#using scripts\mp_common\item_world_util;
#using scripts\weapons\weaponobjects;

#namespace item_world;

// Namespace item_world/item_world
// Params 0, eflags: 0x2
// Checksum 0xcd9637bb, Offset: 0x258
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"item_world", &__init__, undefined, undefined);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x9b4c291f, Offset: 0x2a0
// Size: 0x4cc
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    level.var_6a5820b2 = [];
    level.var_6a5820b2[#"p8_fxanim_wz_supply_stash_01_mod"] = {#open_sound:#"hash_3462cfb200a2367", #var_a1c90e83:#"hash_32f9ba3b1da75ed5"};
    level.var_6a5820b2[#"p8_fxanim_wz_death_stash_mod"] = {#open_sound:#"hash_5e8b0f6cade25ff6", #var_a1c90e83:#"hash_70fb2ee1b706a28a"};
    level.var_6a5820b2[#"hash_1dcbe8021fb16344"] = {#open_sound:#"hash_56b5b65c141f4629", #var_a1c90e83:#"hash_6fcb29cae6678d93"};
    level.var_6a5820b2[#"p8_fxanim_wz_supply_stash_ammo_mod"] = {#open_sound:#"hash_f743d336f8b7764", #var_a1c90e83:#"hash_3e62bcbd6460ff44"};
    level.var_6a5820b2[#"hash_574076754776e003"] = {#open_sound:#"hash_36e23ce3e5f7e4c0", #var_a1c90e83:#"hash_22f426a8593609e8"};
    level.var_6a5820b2[#"wpn_t7_drop_box_wz"] = {#open_sound:#"hash_613f8a1669f8b231", #var_a1c90e83:#"hash_2b751d50426093db"};
    if (!isdefined(level.var_479415e8)) {
        level.var_479415e8 = new throttle();
        [[ level.var_479415e8 ]]->initialize(10, float(function_f9f48566()) / 1000);
    }
    callback::on_connect(&_on_player_connect);
    callback::on_spawned(&_on_player_spawned);
    clientfield::register("world", "item_world_seed", 1, 31, "int");
    clientfield::register("world", "item_world_disable", 1, 1, "int");
    function_5b71dbfc();
    level thread function_38df727e(0);
    level thread function_a7d77ac3();
    level.var_d90a0af8 = 0;
    level.var_8ff021da = &function_42f03a03;
    level.nullprimaryoffhand = getweapon(#"null_offhand_primary");
    level.nullsecondaryoffhand = getweapon(#"null_offhand_secondary");
    level thread namespace_f68e9756::init_spawn_system();
    if (!isdefined(level.var_59df7582)) {
        level.var_59df7582 = new throttle();
        [[ level.var_59df7582 ]]->initialize(1, 0.05);
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0xca73a8bc, Offset: 0x778
// Size: 0x192
function private function_5a6b2bca() {
    [[ level.var_59df7582 ]]->waitinqueue(self);
    var_61348f58 = [];
    for (itemindex = 0; itemindex < function_6a1c8e6f(); itemindex++) {
        wordindex = int(itemindex / 32);
        if (!isdefined(var_61348f58[wordindex])) {
            var_61348f58[wordindex] = 0;
        }
        item = function_9c3c6ff2(itemindex);
        if (!isdefined(item.itementry)) {
            continue;
        }
        if (item.hidetime > 0 && item.hidetime != -1) {
            bitindex = itemindex % 32;
            var_61348f58[wordindex] = var_61348f58[wordindex] | 1 << bitindex;
        }
        if ((itemindex + 1) % 1000 == 0) {
            waitframe(1);
        }
    }
    var_61348f58[var_61348f58.size] = level flagsys::get(#"item_world_reset") ? 1 : 0;
    return var_61348f58;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x7b316cf5, Offset: 0x918
// Size: 0x15c
function private function_4ebf8179(player) {
    assert(isplayer(player));
    usetrigger = spawn("trigger_radius_use", (0, 0, -10000), 0, 128, 64);
    usetrigger triggerignoreteam();
    usetrigger setinvisibletoall();
    usetrigger setvisibletoplayer(self);
    usetrigger setteamfortrigger(#"none");
    usetrigger setcursorhint("HINT_NOICON");
    usetrigger triggerenable(0);
    player clientclaimtrigger(usetrigger);
    player.var_96721adb = usetrigger;
    usetrigger callback::on_trigger(&function_fbdf71a0);
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x7eaca5e6, Offset: 0xa80
// Size: 0x210
function private function_cf8a335c(var_be02f16e, origin, activator) {
    if (!isplayer(activator)) {
        return;
    }
    var_5544f88f = isdefined(activator) && activator hasperk(#"specialty_quieter");
    if (isdefined(level.var_6a5820b2[var_be02f16e])) {
        mapping = level.var_6a5820b2[var_be02f16e];
        open_sound = playsoundatposition(mapping.open_sound, origin);
        if (isdefined(open_sound)) {
            open_sound hide();
        }
        var_a1c90e83 = playsoundatposition(mapping.var_a1c90e83, origin);
        if (isdefined(var_a1c90e83)) {
            var_a1c90e83 hide();
        }
        foreach (player in getplayers()) {
            if (var_5544f88f && !player hasperk(#"specialty_loudenemies")) {
                if (isdefined(var_a1c90e83)) {
                    var_a1c90e83 showtoplayer(player);
                }
                continue;
            }
            if (isdefined(open_sound)) {
                open_sound showtoplayer(player);
            }
        }
    }
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xdf2912dd, Offset: 0xc98
// Size: 0x132
function private function_532ccf2(item, player, networkid, itemid, itemcount, var_a2bce25c, slot) {
    if (item.itementry.itemtype !== #"ammo") {
        assertmsg("<dev string:x30>" + item.name + "<dev string:x37>");
        return 0;
    }
    if (!self item_inventory::can_pickup_ammo(item)) {
        return (isdefined(item.itementry.amount) ? item.itementry.amount : isdefined(var_a2bce25c) ? var_a2bce25c : 1);
    }
    player function_2aa9e8ea(6, itemid);
    return player item_inventory::equip_ammo(item, var_a2bce25c);
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x5c69af14, Offset: 0xdd8
// Size: 0x200
function private function_c254c2cb(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    droppeditem = undefined;
    var_9dcce0f8 = 0;
    var_7269704d = undefined;
    var_9d2fa451 = 0;
    if (player armor::has_armor()) {
        inventoryitem = player.inventory.items[11];
        if (inventoryitem.networkid != 32767) {
            droppeditem = inventoryitem.itementry;
            var_9dcce0f8 = droppeditem.amount;
        }
    }
    player item_inventory::drop_armor();
    remainingitems = player item_inventory::give_inventory_item(item, 1, var_a2bce25c, slotid);
    if (remainingitems < itemcount) {
        if (isdefined(item.networkid) && item_world_util::function_486a6ba1(item.networkid)) {
            item = item_inventory::get_inventory_item(item.networkid);
        }
        if (player item_inventory::function_21ef56e3(item)) {
            player item_inventory::equip_armor(item);
            var_7269704d = item.itementry;
            var_9d2fa451 = item.itementry.amount;
        }
    }
    function_7ee4eede(player, droppeditem, var_9dcce0f8, var_7269704d, var_9d2fa451);
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x12f4f104, Offset: 0xfe0
// Size: 0x170
function private function_ab60b919(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    var_5317ff5e = player item_inventory::function_55297349();
    weaponslotid = undefined;
    if (isdefined(var_5317ff5e) && var_5317ff5e != 32767) {
        weaponslotid = player item_inventory::function_bb5fc9d5(var_5317ff5e);
    }
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    if (isdefined(weaponslotid) && isdefined(slotid) && item_inventory_util::function_c32bed23(weaponslotid, slotid)) {
        if (isdefined(item.networkid) && item_world_util::function_486a6ba1(item.networkid)) {
            item = item_inventory::get_inventory_item(item.networkid);
        }
        player item_inventory::equip_attachment(item, var_5317ff5e, 0);
    }
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x7120aea8, Offset: 0x1158
// Size: 0x110
function private function_b40cc7a2(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    if (player item_inventory::function_21ef56e3(item)) {
        slotid = 13;
    }
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    if (remainingitems < itemcount && slotid === 13) {
        if (isdefined(item.networkid) && item_world_util::function_486a6ba1(item.networkid)) {
            item = item_inventory::get_inventory_item(item.networkid);
        }
        player item_inventory::equip_backpack(item);
    }
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x4d42e7ec, Offset: 0x1270
// Size: 0xf0
function private function_17c4edd0(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    if (remainingitems < itemcount) {
        if (isdefined(item.networkid) && item_world_util::function_486a6ba1(item.networkid)) {
            item = item_inventory::get_inventory_item(item.networkid);
        }
        if (player item_inventory::function_21ef56e3(item)) {
            player thread item_inventory::equip_equipment(item);
        }
    }
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x33bb7f2a, Offset: 0x1368
// Size: 0xf0
function private function_69c7a5ee(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    if (remainingitems < itemcount) {
        if (isdefined(item.networkid) && item_world_util::function_486a6ba1(item.networkid)) {
            item = item_inventory::get_inventory_item(item.networkid);
        }
        if (player item_inventory::function_21ef56e3(item)) {
            player thread item_inventory::equip_health(item);
        }
    }
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xfbcc6a26, Offset: 0x1460
// Size: 0x6a
function private function_877fed72(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xc264e8a5, Offset: 0x14d8
// Size: 0x6a
function private function_b7985fe3(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x5ffefdb6, Offset: 0x1550
// Size: 0x6a
function private function_530d9b02(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0x6b8b1d9c, Offset: 0x15c8
// Size: 0x6a
function private function_e391ae90(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, undefined, slotid);
    return remainingitems;
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xcf97a53d, Offset: 0x1640
// Size: 0x200
function private function_74313e18(item, player, networkid, itemid, itemcount, var_a2bce25c, slotid) {
    if (item_inventory::get_weapon_count() == 2) {
        stashitem = item.hidetime === -1 || isentity(item) && item ishidden();
        stashitem &= ~(isdefined(item.deathstash) ? item.deathstash : 0);
        weaponitem = item_inventory::function_2037faaa(player.currentweapon);
        item_inventory::drop_inventory_item(weaponitem.networkid, stashitem, item.origin, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname);
    }
    remainingitems = player item_inventory::give_inventory_item(item, itemcount, var_a2bce25c, slotid);
    if (remainingitems < itemcount) {
        if (isdefined(item.networkid) && item_world_util::function_486a6ba1(item.networkid)) {
            item = item_inventory::get_inventory_item(item.networkid);
        }
        player item_inventory::equip_weapon(item, 1, 1, 0, 1);
    }
    return remainingitems;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x6250264f, Offset: 0x1848
// Size: 0x1d4
function private function_a7d77ac3() {
    level endon(#"game_ended");
    waitframe(1);
    level flagsys::wait_till(#"hash_507a4486c4a79f1d");
    util::wait_network_frame(1);
    level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    setdvar(#"hash_21e070fbb56cf0f", 0);
    if (isdefined(level.item_spawn_stashes)) {
        foreach (supply_stash in level.item_spawn_stashes) {
            setdynentenabled(supply_stash, 1);
        }
    }
    foreach (player in getplayers()) {
        if (isplayer(player)) {
            player weaponobjects::function_465e8e68();
        }
    }
    reset_item_world();
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xeab1e8a5, Offset: 0x1a28
// Size: 0x24c
function private function_38df727e(reset = 1) {
    level endon(#"game_ended");
    level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    level flagsys::set(#"hash_2d3b2a4d082ba5ee");
    if (level flagsys::get(#"item_world_reset")) {
        return;
    }
    waitframe(1);
    level flagsys::clear(#"item_world_initialized");
    var_ff7f962c = (1 << 29) - 1;
    seedvalue = randomintrange(0, var_ff7f962c) + 1;
    /#
        seedvalue = getdvarint(#"hash_46870e6b25b988eb", seedvalue);
    #/
    level.item_spawn_seed = seedvalue;
    match_record::set_stat(#"item_spawn_seed", seedvalue);
    setdvar(#"hash_21e070fbb56cf0f", 0);
    level item_spawn_group::setup(seedvalue, reset);
    seedvalue <<= 1;
    seedvalue |= reset ? 1 : 0;
    level clientfield::set("item_world_seed", seedvalue);
    level flagsys::set(#"item_world_initialized");
    if (reset) {
        level flagsys::set(#"item_world_reset");
    }
    level flagsys::clear(#"hash_2d3b2a4d082ba5ee");
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0x81e043be, Offset: 0x1c80
// Size: 0x5da
function private function_42f03a03(player, eventtype, eventdata, var_d4bc02d7) {
    if (isdefined(level.var_aaa508f5) && level.var_aaa508f5) {
        return;
    }
    if (!function_61cbd38b()) {
        return;
    }
    if (!isdefined(player)) {
        return;
    }
    switch (eventtype) {
    case 1:
        networkid = eventdata;
        if (player clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2) {
            item = function_b555314b(networkid);
            if (isdefined(item) && player can_pick_up(item)) {
                player pickup_item(item);
            }
        }
        break;
    case 2:
        networkid = eventdata;
        player item_inventory::equip_item(networkid);
        if (!isdefined(player)) {
            return;
        }
        itemid = player item_inventory::function_2f6c4f55(networkid);
        if (itemid != 32767) {
            item = function_9c3c6ff2(itemid);
            if (isdefined(item) && isdefined(item.itementry)) {
                function_7ee4eede(player, undefined, undefined, item.itementry, item.itementry.amount);
            }
        }
        break;
    case 3:
        networkid = eventdata;
        count = var_d4bc02d7;
        var_e185d918 = undefined;
        var_9dcce0f8 = undefined;
        if (item_world_util::function_a04a2a1f(networkid)) {
            itemid = networkid;
            item = function_9c3c6ff2(itemid);
            assert(item.itementry.itemtype == #"ammo");
            if (item.itementry.itemtype == #"ammo") {
                var_e185d918 = item.itementry;
                var_9dcce0f8 = count;
                player item_inventory::function_39129ea8(itemid, count);
            }
        } else {
            inventory_item = player item_inventory::get_inventory_item(networkid);
            if (!isdefined(inventory_item)) {
                break;
            }
            if (!isdefined(count) || count === inventory_item.count) {
                var_9dcce0f8 = isdefined(count) ? count : inventory_item.itementry.amount;
                player item_inventory::drop_inventory_item(networkid);
            } else {
                var_9dcce0f8 = count;
                player item_inventory::function_dfbf4920(networkid, count);
            }
        }
        function_7ee4eede(player, var_e185d918, var_9dcce0f8, undefined, undefined);
        break;
    case 4:
        networkid = eventdata;
        freeslot = player item_inventory::function_e4e86e53();
        if (isdefined(freeslot)) {
            player item_inventory::function_522c0741(networkid);
            attachmentslot = player item_inventory::function_bb5fc9d5(networkid);
            player item_inventory::function_8882634(attachmentslot, freeslot);
        }
        break;
    case 5:
        networkid = eventdata;
        item = function_b555314b(networkid);
        if (distance2dsquared(player.origin, item.origin) > 128 * 128 || abs(player.origin[2] - item.origin[2]) > 64) {
            return;
        }
        if (isdefined(item) && isdefined(item.itementry)) {
            var_e0a8efc1 = item.itementry.itemtype != #"attachment";
            player pickup_item(item, var_e0a8efc1);
        }
        break;
    case 6:
        networkid = eventdata;
        player item_inventory::function_518a1d93(networkid);
        break;
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x8a9a951, Offset: 0x2268
// Size: 0x94
function private _on_player_connect() {
    function_4ebf8179(self);
    self item_inventory::init_inventory();
    if (function_fe3db5a8() && (!self issplitscreen() || !self function_f1e93fc3())) {
        function_4f63128(self);
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x25640a59, Offset: 0x2308
// Size: 0x3c
function private _on_player_spawned() {
    if (!isdefined(self.inventory)) {
        self item_inventory::init_inventory();
    }
    self thread function_cc526d52();
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x6b7f5c32, Offset: 0x2350
// Size: 0xc8
function private function_f1e93fc3() {
    foreach (player in level.players) {
        if (!isdefined(player)) {
            continue;
        }
        if (player == self) {
            continue;
        }
        if (!self isplayeronsamemachine(player)) {
            continue;
        }
        if (isdefined(player.var_f0d7a237) && player.var_f0d7a237) {
            return true;
        }
    }
    return false;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x4219ab8f, Offset: 0x2420
// Size: 0xb6
function private function_cc526d52() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self notify("6085a051d4512d35");
    self endon("6085a051d4512d35");
    while (true) {
        [[ level.var_479415e8 ]]->waitinqueue();
        function_57f66d3a(self geteye(), self getplayerangles());
        waitframe(1);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x69bc339f, Offset: 0x24e0
// Size: 0x28a
function private function_fbdf71a0(trigger_struct) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    usetrigger = self;
    activator = trigger_struct.activator;
    if (!activator function_9ecda51c()) {
        return;
    }
    if (isdefined(level.var_aaa508f5) && level.var_aaa508f5) {
        return;
    }
    var_50d9c330 = activator clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
    if (var_50d9c330 == 1) {
        usetrigger sethintstring(#"");
        activator clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 2);
        activator thread function_a324bc71();
        if (usetrigger.itemstruct.hidetime === -1) {
            function_91697c35(usetrigger.itemstruct, activator);
        }
        return;
    }
    if (var_50d9c330 == 2) {
        usetrigger sethintstring(#"");
        activator luinotifyevent(#"hash_415ef5e7734c15f5", 0);
        return;
    }
    item = usetrigger.itemstruct;
    if (isdefined(item) && !isentity(item) && isdefined(item.id)) {
        item = function_9c3c6ff2(item.id);
    }
    if (activator can_pick_up(item)) {
        activator pickup_item(item);
        while (isdefined(activator) && activator usebuttonpressed()) {
            waitframe(1);
        }
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x201796f6, Offset: 0x2778
// Size: 0x92
function private function_a324bc71() {
    self endon(#"disconnect");
    self function_7037e01();
    self waittill(#"death", #"entering_last_stand", #"hash_2781407e327b42ee");
    self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
    self.var_1ab48eb8 = 1;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x1534525, Offset: 0x2818
// Size: 0x156
function private function_7037e01() {
    self notify("5a8b17fb65ac8d93");
    self endon("5a8b17fb65ac8d93");
    self endon(#"death", #"entering_last_stand");
    while (true) {
        waitframe(1);
        if (self stancebuttonpressed()) {
            break;
        }
        if (!isdefined(self.groupitems)) {
            break;
        }
        if (self.groupitems.size == 0) {
            break;
        }
        var_2b727bfe = 0;
        foreach (item in self.groupitems) {
            if (isdefined(item) && self can_pick_up(item)) {
                var_2b727bfe = 1;
                break;
            }
        }
        if (!var_2b727bfe) {
            break;
        }
    }
    self notify(#"hash_2781407e327b42ee");
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x5d5f8a3f, Offset: 0x2978
// Size: 0x8a
function private function_fe368037(identifier, handler) {
    assert(isdefined(level.var_948b8ff7), "<dev string:x6b>");
    assert(!isdefined(level.var_948b8ff7[identifier]), "<dev string:xbf>" + identifier);
    level.var_948b8ff7[identifier] = handler;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x61a7dccf, Offset: 0x2a10
// Size: 0x8a
function private function_4f63128(player) {
    if (isdefined(level.var_aaa508f5) && level.var_aaa508f5) {
        return;
    }
    function_61cbd38b();
    var_61348f58 = function_5a6b2bca();
    if (isdefined(player)) {
        player function_e7b8182b(var_61348f58);
        player.var_f0d7a237 = 1;
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x391bd773, Offset: 0x2aa8
// Size: 0x224
function private function_5b71dbfc() {
    level.var_948b8ff7 = [];
    function_fe368037(#"hash_9ed0c30684ca35a", &function_532ccf2);
    function_fe368037(#"hash_76a324a4d6073913", &function_c254c2cb);
    function_fe368037(#"hash_788c59214ead02af", &function_ab60b919);
    function_fe368037(#"hash_6247ea34d3b1ddb6", &function_b40cc7a2);
    function_fe368037(#"hash_2cbf15cbb314c93e", &function_17c4edd0);
    function_fe368037(#"hash_51b30f6e7331e136", &function_69c7a5ee);
    function_fe368037(#"hash_2b4dff2e0db72d06", &function_877fed72);
    function_fe368037(#"generic_pickup", &function_b7985fe3);
    function_fe368037(#"hash_5c844f5c1207159c", &function_530d9b02);
    function_fe368037(#"hash_31380667bf69d3a0", &function_e391ae90);
    function_fe368037(#"hash_50375e5de228e9fc", &function_74313e18);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0x66ba80b, Offset: 0x2cd8
// Size: 0x12
function private function_fe3db5a8() {
    return level.var_d90a0af8 > 0;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x239314ba, Offset: 0x2cf8
// Size: 0x70c
function private function_91697c35(item, activator) {
    assert(isdefined(item));
    if (isdefined(item) && (isdefined(item.targetname) || isdefined(item.targetnamehash))) {
        targetname = isdefined(item.targetname) ? item.targetname : item.targetnamehash;
        stashes = getdynentarray(targetname);
        if (stashes.size > 0) {
            stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
            if (stashes.size <= 0) {
                return;
            }
            state = function_7f51b166(stashes[0]);
            if (state == 0) {
                function_cf8a335c(stashes[0].var_fc7680e1, stashes[0].origin, activator);
                function_9e7b6692(stashes[0], 1);
            } else if (state == 1) {
                stashitems = function_60374d7d(targetname);
                stashitems = arraysortclosest(stashitems, stashes[0].origin, stashitems.size, 0, 12);
                foreach (stashitem in stashitems) {
                    if (stashitem.hidetime === -1) {
                        return;
                    }
                }
                dynamicitems = [];
                foreach (itemspawndrop in level.item_spawn_drops) {
                    if (isdefined(itemspawndrop) && itemspawndrop.targetnamehash === targetname) {
                        dynamicitems[dynamicitems.size] = itemspawndrop;
                    }
                }
                dynamicitems = arraysortclosest(dynamicitems, stashes[0].origin, dynamicitems.size, 0, 12);
                foreach (dynamicitem in dynamicitems) {
                    if (dynamicitem.hidetime === -1) {
                        return;
                    }
                }
                function_9e7b6692(stashes[0], 2);
            }
        }
        if (!isstring(targetname)) {
            return;
        }
        stashes = getentarray(targetname, "targetname");
        if (stashes.size > 0) {
            stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
            if (stashes.size <= 0) {
                return;
            }
            stash = stashes[0];
            if (stash.var_5adbea02 == 0) {
                function_cf8a335c(stash.model, stash.origin, activator);
                if (!isdefined(stash.var_1597e770) || stash.var_1597e770) {
                    stash animscripted("death_stash_open", stash.origin, stash.angles, "p8_fxanim_wz_death_stash_used_anim", "normal", "root", 1, 0);
                }
                stash.var_5adbea02 = 1;
                return;
            }
            if (stash.var_5adbea02 == 1) {
                dynamicitems = [];
                foreach (itemspawndrop in level.item_spawn_drops) {
                    if (isdefined(itemspawndrop) && itemspawndrop.targetnamehash === targetname) {
                        dynamicitems[dynamicitems.size] = itemspawndrop;
                    }
                }
                dynamicitems = arraysortclosest(dynamicitems, stashes[0].origin, dynamicitems.size, 0, 12);
                foreach (dynamicitem in dynamicitems) {
                    if (dynamicitem.hidetime === -1) {
                        return;
                    }
                }
                if (!isdefined(stash.var_1597e770) || stash.var_1597e770) {
                    stash animscripted("death_stash_empty", stash.origin, stash.angles, "p8_fxanim_wz_death_stash_empty_anim", "normal", "root", 1, 0);
                }
                stash.var_5adbea02 = 2;
                stash clientfield::set("dynamic_stash", 2);
            }
        }
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0xb2c0f40a, Offset: 0x3410
// Size: 0x876
function private function_57f66d3a(origin, angles) {
    assert(isplayer(self));
    usetrigger = self.var_96721adb;
    var_a2212abb = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
    forward = vectornormalize(anglestoforward(angles));
    maxdist = util::function_1a1c8e97();
    if (var_a2212abb) {
        maxdist = 128;
    }
    var_2cd4142c = function_33d2057a(origin, forward, 100, maxdist, 0.57);
    var_a582c9fe = undefined;
    bestdot = undefined;
    traceoffset = (0, 0, 6);
    for (itemindex = 0; itemindex < var_2cd4142c.size; itemindex++) {
        itemdef = var_2cd4142c[itemindex];
        if (!self can_pick_up(itemdef)) {
            continue;
        }
        toitem = vectornormalize(itemdef.origin - origin);
        dot = vectordot(forward, toitem);
        if (dot < 0.57) {
            continue;
        }
        if (!isdefined(var_a582c9fe) || dot > bestdot) {
            if (itemdef.hidetime !== -1 && itemdef.hidetime <= 0) {
                var_472f4c86 = bullettrace(origin, itemdef.origin + traceoffset, 0, self, 0, 0);
                if (var_472f4c86[#"fraction"] < 1 && var_472f4c86[#"entity"] !== itemdef) {
                    continue;
                }
            }
            var_a582c9fe = itemdef;
            bestdot = dot;
        }
    }
    if (isdefined(var_a582c9fe) && !self isinvehicle()) {
        self.groupitems = [];
        hasbackpack = self item_inventory::has_backpack();
        stashitem = var_a582c9fe.hidetime === -1;
        canstack = !stashitem && item_inventory::function_7a32fa96(var_a582c9fe);
        var_44091419 = self item_inventory::has_armor() && var_a582c9fe.itementry.itemtype == #"armor";
        isammo = var_a582c9fe.itementry.itemtype == #"ammo";
        var_de1e6d90 = !hasbackpack && var_a582c9fe.itementry.itemtype == #"backpack";
        if (stashitem || !isammo && !var_de1e6d90 && !canstack && !var_44091419) {
            var_683a6fbe = 14;
            self.groupitems = function_33d2057a(var_a582c9fe.origin, undefined, 100, var_683a6fbe);
            self.groupitems = self array::filter(self.groupitems, 0, &can_pick_up);
        }
        if (self.groupitems.size == 1) {
            stashitem = self.groupitems[0].hidetime === -1;
        }
        if (stashitem) {
            usetrigger setcursorhint("HINT_NOICON");
            usetrigger sethintstring(#"");
            currentstate = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
            if (currentstate == 0 || currentstate == 1) {
                if (distancesquared(origin, var_a582c9fe.origin) > 128 * 128) {
                    self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
                } else {
                    self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 1);
                }
            }
        } else {
            self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
            itementry = var_a582c9fe.itementry;
            if (isdefined(itementry.weapon) && itementry.weapon != level.weaponnone) {
                if (itementry.itemtype != #"ammo") {
                    usetrigger setcursorhint("HINT_WEAPON_3D", item_inventory_util::function_370ccb8a(var_a582c9fe));
                    usetrigger sethintstring(isdefined(itementry.hintstring) ? itementry.hintstring : #"weapon/pickupnewweapon");
                } else {
                    usetrigger setcursorhint("HINT_3D");
                    usetrigger sethintstring(isdefined(itementry.hintstring) ? itementry.hintstring : #"");
                }
            } else {
                usetrigger setcursorhint("HINT_3D");
                usetrigger sethintstring(isdefined(itementry.hintstring) ? itementry.hintstring : #"");
            }
        }
        usetrigger.itemstruct = var_a582c9fe;
        usetrigger.origin = var_a582c9fe.origin + (0, 0, 4);
        usetrigger.angles = (0, 0, 0);
        usetrigger triggerenable(1);
    } else {
        self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
        usetrigger.itemstruct = undefined;
        usetrigger triggerenable(0);
        self.groupitems = undefined;
    }
    self.var_a1446423 = forward;
    self.var_dee9ba27 = origin;
    self.var_4e8df5e0 = level.var_d90a0af8;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x75592c33, Offset: 0x3c90
// Size: 0x94
function function_c05b1a0f(item) {
    itementry = item.itementry;
    itemcount = item.count;
    if (!isdefined(itemcount)) {
        itemcount = isdefined(itementry.amount) ? itementry.amount : 1;
        if (itementry.itemtype == #"weapon") {
            itemcount = 1;
        }
    }
    return itemcount;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xab8ccd8, Offset: 0x3d30
// Size: 0x4a
function can_pick_up(item) {
    if (!isdefined(item)) {
        return false;
    }
    if (item.hidetime > 0 && item.hidetime != -1) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xfcc38797, Offset: 0x3d88
// Size: 0x20c
function consume_item(item) {
    if (isdefined(level.var_aaa508f5) && level.var_aaa508f5) {
        return;
    }
    if (isentity(item)) {
        item.hidetime = gettime();
    } else {
        function_98497bc7(item.id, gettime());
        if (level flagsys::get(#"item_world_reset")) {
            function_52153ba9(9, item.id);
        } else {
            function_52153ba9(1, item.id);
        }
        level.var_d90a0af8++;
    }
    if (isdefined(item)) {
        function_91697c35(item, self);
    }
    if (isentity(item)) {
        item clientfield::set("dynamic_item_drop", 2);
        item function_5d3f60ae(32767);
        util::wait_network_frame(1);
        if (!isdefined(item)) {
            return;
        }
        if (isdefined(item.var_be5cf48d)) {
            var_be5cf48d = item.var_be5cf48d;
            var_be5cf48d stopsounds();
            util::wait_network_frame(1);
            if (isdefined(var_be5cf48d)) {
                var_be5cf48d delete();
            }
        }
        if (!isdefined(item)) {
            return;
        }
        item delete();
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x24ba7a5, Offset: 0x3fa0
// Size: 0xb4
function function_b555314b(networkid) {
    if (item_world_util::function_9628594b(networkid)) {
        if (item_world_util::function_a04a2a1f(networkid)) {
            return function_9c3c6ff2(networkid);
        }
        if (item_world_util::function_2dd7d7a4(networkid)) {
            if (isdefined(level.item_spawn_drops[networkid])) {
                return level.item_spawn_drops[networkid];
            }
            return;
        }
        assert(0, "<dev string:xf8>");
    }
}

// Namespace item_world/item_world
// Params 6, eflags: 0x0
// Checksum 0xc1f96a26, Offset: 0x4060
// Size: 0x142
function function_33d2057a(origin, dir, maxitems, maxdistance, dot, var_afe71f00 = 1) {
    maxitems = isdefined(maxitems) ? int(min(maxitems, 4000)) : maxitems;
    var_2cd4142c = function_f89bdb99(origin, dir, maxitems, maxdistance, dot, var_afe71f00, -2147483647);
    var_ec57a7a1 = arraysortclosest(level.item_spawn_drops, origin, maxitems, 0, maxdistance);
    var_2cd4142c = arraycombine(var_2cd4142c, var_ec57a7a1, 1, 0);
    var_2cd4142c = arraysortclosest(var_2cd4142c, origin, maxitems, 0, maxdistance);
    return var_2cd4142c;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x0
// Checksum 0xdb566752, Offset: 0x41b0
// Size: 0x284
function function_f4e80968(item, player, slotid = undefined) {
    itementry = item.itementry;
    if (isdefined(itementry.handler)) {
        handlerfunc = level.var_948b8ff7[itementry.handler];
        if (isdefined(handlerfunc)) {
            var_a2bce25c = item.amount;
            if (!isdefined(var_a2bce25c)) {
                if (itementry.itemtype == #"ammo") {
                } else if (itementry.itemtype == #"weapon") {
                    weapon = item_world_util::function_fe2abb62(itementry);
                    var_a2bce25c = itementry.amount;
                    if (isdefined(weapon)) {
                        var_a2bce25c = itementry.amount * weapon.clipsize;
                    }
                } else if (itementry.itemtype == #"armor") {
                    var_a2bce25c = itementry.amount;
                } else {
                    var_a2bce25c = 0;
                }
            }
            itemcount = function_c05b1a0f(item);
            profilestart();
            var_3af46aeb = player [[ handlerfunc ]](item, player, item.networkid, item.id, itemcount, var_a2bce25c, slotid);
            profilestop();
            assert(isint(var_3af46aeb) && var_3af46aeb >= 0);
            if (var_3af46aeb == itemcount) {
            } else {
                player gestures::function_42215dfa("gestable_grab", undefined, 0);
                if (isdefined(item)) {
                    item.count = var_3af46aeb;
                }
            }
            return var_3af46aeb;
        }
    }
    assertmsg("<dev string:x127>" + itementry.name + "<dev string:x152>");
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0xedc2d156, Offset: 0x4440
// Size: 0x364
function pickup_item(item, var_cba70edb = 1) {
    assert(isplayer(self));
    if (!can_pick_up(item)) {
        return;
    }
    self dynent_world::function_ec11d882();
    if (var_cba70edb) {
        var_8ffc4b49 = self item_inventory::function_e1536678(item);
    }
    if (isdefined(var_8ffc4b49)) {
        self function_4c52bc37(item, var_8ffc4b49);
        return;
    }
    itemcount = function_c05b1a0f(item);
    remainingitems = function_f4e80968(item, self);
    if (remainingitems == 0) {
        if (item.itementry.itemtype != #"armor") {
            if (isdefined(item) && isdefined(item.itementry)) {
                function_7ee4eede(self, undefined, undefined, item.itementry, item.itementry.amount);
            }
        }
        consume_item(item);
        return;
    }
    if (remainingitems < itemcount && !isentity(item) && item.itementry.itemtype != #"ammo") {
        stashitem = item.hidetime === -1 || isentity(item) && item ishidden();
        stashitem &= ~(isdefined(item.deathstash) ? item.deathstash : 0);
        dropitem = self item_drop::drop_item(item.itementry.weapon, remainingitems, item.amount, item.id, item.origin, item.angles, stashitem, undefined, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname);
        if (isdefined(dropitem)) {
            dropitem.origin = item.origin;
            dropitem.angles = item.angles;
            consume_item(item);
        }
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0x968033b1, Offset: 0x47b0
// Size: 0xe6
function function_9ecda51c() {
    assert(isplayer(self));
    usetrigger = self.var_96721adb;
    if (!isdefined(usetrigger.itemstruct)) {
        return false;
    }
    if (distance2dsquared(usetrigger.itemstruct.origin, self.origin) > 128 * 128) {
        return false;
    }
    if (abs(usetrigger.itemstruct.origin[2] - self.origin[2]) > 64) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 5, eflags: 0x0
// Checksum 0x70dd012d, Offset: 0x48a0
// Size: 0x234
function function_7ee4eede(player, var_e185d918, var_9dcce0f8, var_53d172eb, var_9d2fa451) {
    if (game.state == "pregame" || !isdefined(var_e185d918) && !isdefined(var_53d172eb)) {
        return;
    }
    data = {#game_time:function_25e96038(), #player_xuid:int(player getxuid(1)), #dropped_item:isdefined(var_e185d918) ? hash(var_e185d918.name) : 0, #var_a816788:isdefined(var_9dcce0f8) ? var_9dcce0f8 : 0, #var_c7fdb1a:isdefined(var_53d172eb) ? hash(var_53d172eb.name) : 0, #var_dbdcf743:isdefined(var_9d2fa451) ? var_9d2fa451 : 0};
    /#
        if (isdefined(var_e185d918)) {
            println("<dev string:x154>" + var_e185d918.name + "<dev string:x15e>" + (isdefined(var_9dcce0f8) ? var_9dcce0f8 : 0));
        }
        if (isdefined(var_53d172eb)) {
            println("<dev string:x160>" + var_53d172eb.name + "<dev string:x15e>" + (isdefined(var_9d2fa451) ? var_9d2fa451 : 0));
        }
    #/
    function_b1f6086c(#"hash_1ed3b4af49015043", data);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x89bea4e9, Offset: 0x4ae0
// Size: 0x4ec
function function_4c52bc37(item, inventoryslot) {
    var_e185d918 = undefined;
    var_9dcce0f8 = 0;
    var_75d3907f = self item_inventory::function_7a32fa96(item) || item.itementry.itemtype == #"resource" || item.itementry.itemtype == #"ammo" || item.itementry.itemtype == #"backpack" && !self item_inventory::has_backpack();
    stashitem = item.hidetime === -1 || isentity(item) && item ishidden();
    stashitem &= ~(isdefined(item.deathstash) ? item.deathstash : 0);
    var_44091419 = self item_inventory::has_armor() && item.itementry.itemtype == #"armor";
    if (var_44091419) {
        self item_inventory::drop_armor(stashitem, item.origin, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname);
        var_75d3907f = 1;
    }
    if (!var_75d3907f && self item_inventory::has_inventory_item(inventoryslot)) {
        var_e91c3cea = self.inventory.items[inventoryslot];
        var_e185d918 = var_e91c3cea.itementry;
        var_9dcce0f8 = var_e185d918.amount;
        dropitem = self item_inventory::drop_inventory_item(var_e91c3cea.networkid, stashitem, item.origin, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname);
        if (!isdefined(dropitem)) {
            return;
        }
        dropitem.origin = item.origin;
        waitframe(1);
    }
    if (!isdefined(item) || !can_pick_up(item)) {
        return;
    }
    remainingitems = function_f4e80968(item, self, inventoryslot);
    if (remainingitems == 0) {
        if (isdefined(item) && isdefined(item.itementry)) {
            function_7ee4eede(self, var_e185d918, var_9dcce0f8, item.itementry, item.itementry.amount);
        }
        consume_item(item);
        return;
    }
    if (!isentity(item) && item.itementry.itemtype != #"ammo") {
        dropitem = self item_drop::drop_item(item.itementry.weapon, item.count, item.amount, item.id, item.origin, item.angles, stashitem, undefined, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname);
        if (isdefined(dropitem)) {
            dropitem.origin = item.origin;
            dropitem.angles = item.angles;
            consume_item(item);
        }
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x133cb78b, Offset: 0x4fd8
// Size: 0x234
function function_c427552b(supplystash) {
    level flagsys::wait_till(#"hash_507a4486c4a79f1d");
    function_6df9665a();
    assert(isdefined(supplystash));
    if (!isdefined(supplystash) || !isdefined(supplystash.targetname)) {
        return;
    }
    var_949e1a9d = function_60374d7d(supplystash.targetname);
    foreach (item in var_949e1a9d) {
        if (can_pick_up(item)) {
            consume_item(item);
        }
    }
    consumeitems = [];
    foreach (item in level.item_spawn_drops) {
        if (isdefined(item) && item.targetname == supplystash.targetname) {
            if (can_pick_up(item)) {
                consumeitems[consumeitems.size] = item;
            }
        }
    }
    for (index = 0; index < consumeitems.size; index++) {
        consume_item(item);
    }
    function_9e7b6692(supplystash, 3);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0x89a5ae73, Offset: 0x5218
// Size: 0x176
function reset_item_world() {
    level.var_d90a0af8 = 0;
    level.var_aaa508f5 = 1;
    util::wait_network_frame(1);
    assert(level.var_d90a0af8 == 0);
    players = getplayers();
    foreach (player in players) {
        player item_inventory::reset_inventory();
    }
    util::wait_network_frame(1);
    assert(level.var_d90a0af8 == 0);
    function_38df727e(1);
    util::wait_network_frame(1);
    assert(level.var_d90a0af8 == 0);
    level.var_aaa508f5 = undefined;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0x8f5c8044, Offset: 0x5398
// Size: 0x8a
function function_61cbd38b() {
    reset = isdefined(level flagsys::get(#"item_world_reset"));
    level flagsys::wait_till(#"item_world_initialized");
    if (reset != isdefined(level flagsys::get(#"item_world_reset"))) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0xd0b380bf, Offset: 0x5430
// Size: 0x84
function function_6df9665a() {
    level flagsys::wait_till(#"item_world_initialized");
    level flagsys::wait_till(#"item_world_reset");
    while (isdefined(level.var_aaa508f5) && level.var_aaa508f5) {
        waitframe(1);
    }
    util::wait_network_frame(1);
}

