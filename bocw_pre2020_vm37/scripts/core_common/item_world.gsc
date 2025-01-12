#using script_1caf36ff04a85ff6;
#using script_1cd491b1807da8f7;
#using script_340a2e805e35f7a2;
#using script_39cbfe2ef5995b4b;
#using script_471b31bd963b388e;
#using script_5a84f213cefea5de;
#using script_5faf53425d584a24;
#using script_d5e47f3a0e95613;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\match_record;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace item_world;

// Namespace item_world/item_world
// Params 0, eflags: 0x6
// Checksum 0x35a3715b, Offset: 0x408
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"item_world", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0xe8a2d89d, Offset: 0x450
// Size: 0x51c
function private function_70a657d8() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    function_2777823f();
    level.var_d89ef54a = getgametypesetting(#"hash_2f0beae14bf17810");
    level.var_9cddbf4e = [];
    level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_01_mod"] = {#open_sound:#"hash_3462cfb200a2367", #var_b9492c6:#"hash_32f9ba3b1da75ed5"};
    level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_04_mod"] = {#open_sound:#"hash_3462cfb200a2367", #var_b9492c6:#"hash_32f9ba3b1da75ed5"};
    level.var_9cddbf4e[#"p8_fxanim_wz_death_stash_mod"] = {#open_sound:#"hash_5e8b0f6cade25ff6", #var_b9492c6:#"hash_70fb2ee1b706a28a"};
    level.var_9cddbf4e[#"hash_1dcbe8021fb16344"] = {#open_sound:#"hash_56b5b65c141f4629", #var_b9492c6:#"hash_6fcb29cae6678d93"};
    level.var_9cddbf4e[#"p8_fxanim_wz_supply_stash_ammo_mod"] = {#open_sound:#"hash_f743d336f8b7764", #var_b9492c6:#"hash_3e62bcbd6460ff44"};
    level.var_9cddbf4e[#"hash_574076754776e003"] = {#open_sound:#"hash_36e23ce3e5f7e4c0", #var_b9492c6:#"hash_22f426a8593609e8"};
    level.var_9cddbf4e[#"wpn_t7_drop_box_wz"] = {#open_sound:#"hash_613f8a1669f8b231", #var_b9492c6:#"hash_2b751d50426093db"};
    callback::on_connect(&_on_player_connect);
    callback::on_disconnect(&_on_player_disconnect);
    callback::add_callback(#"hash_41781454d98b676a", &function_9aefb438);
    if (!is_true(level.var_dcf5a517)) {
        level thread function_f7fb8a17(0);
    }
    level thread function_e1965ae1();
    level.var_703d32de = 0;
    level.var_17c7288a = &function_23b313bd;
    level.nullprimaryoffhand = getweapon(#"null_offhand_primary");
    level.nullsecondaryoffhand = getweapon(#"null_offhand_secondary");
    level.var_3488e988 = getweapon(#"hash_5a7fd1af4a1d5c9");
    level.var_3a0bbaea = 0;
    level thread namespace_65181344::init_spawn_system();
    if (!isdefined(level.var_227b9e91)) {
        level.var_227b9e91 = new throttle();
        [[ level.var_227b9e91 ]]->initialize(4, 0.05);
    }
    level.var_3dfbaf65 = &function_8e0d14c1;
    if (!is_true(getgametypesetting(#"hash_36c2645732ad1c3b")) || !item_inventory::function_7d5553ac()) {
        level thread function_df1098a();
    }
    level thread function_248022d9();
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0xe55133e9, Offset: 0x978
// Size: 0x14c
function private function_2777823f() {
    clientfield::register("world", "item_world_seed", 1, 31, "int");
    clientfield::register("world", "item_world_sanity_random", 1, 16, "int");
    clientfield::register("world", "item_world_disable", 1, 1, "int");
    clientfield::register("scriptmover", "item_world_attachments", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.pickupHintGold", 1, 1, "int", 1);
    clientfield::register("toplayer", "disableItemPickup", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.multiItemPickup.status", 1, 3, "int");
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0x4007af8c, Offset: 0xad0
// Size: 0x70
function private function_e6ea1ee0() {
    [[ level.var_227b9e91 ]]->waitinqueue(self);
    var_fee74908 = function_784b5aa6();
    var_fee74908[var_fee74908.size] = level flag::get(#"item_world_reset") ? 1 : 0;
    return var_fee74908;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x845e478c, Offset: 0xb48
// Size: 0x21c
function private function_f3b6e182(player) {
    assert(isplayer(player));
    usetrigger = spawn("trigger_radius_use", (0, 0, -10000), 0, 128, 72);
    usetrigger.targetname = "item_world";
    usetrigger triggerignoreteam();
    usetrigger setinvisibletoall();
    usetrigger setvisibletoplayer(self);
    usetrigger setteamfortrigger(#"none");
    usetrigger setcursorhint("HINT_NOICON");
    usetrigger triggerenable(0);
    usetrigger function_89fca53b(0);
    usetrigger function_49462027(1, 1 | 16 | 2097152 | 65536 | 1048576);
    player.var_207c9892 = getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000;
    function_dae4ab9b(usetrigger, player.var_207c9892);
    player clientclaimtrigger(usetrigger);
    player.var_19caeeea = usetrigger;
    usetrigger callback::on_trigger(&function_ad7ad6ce);
}

// Namespace item_world/item_world
// Params 3, eflags: 0x5 linked
// Checksum 0x82a0045c, Offset: 0xd70
// Size: 0x230
function private function_b516210b(var_889058cc, origin, activator) {
    if (!isplayer(activator)) {
        return;
    }
    var_cde95668 = isdefined(activator) && activator hasperk(#"specialty_quieter");
    if (isdefined(level.var_9cddbf4e[var_889058cc])) {
        mapping = level.var_9cddbf4e[var_889058cc];
        open_sound = playsoundatposition(mapping.open_sound, origin + (0, 0, 50));
        if (isdefined(open_sound)) {
            open_sound hide();
        }
        var_b9492c6 = playsoundatposition(mapping.var_b9492c6, origin + (0, 0, 50));
        if (isdefined(var_b9492c6)) {
            var_b9492c6 hide();
        }
        foreach (player in getplayers()) {
            if (var_cde95668 && !player hasperk(#"specialty_loudenemies")) {
                if (isdefined(var_b9492c6)) {
                    var_b9492c6 showtoplayer(player);
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
// Params 0, eflags: 0x5 linked
// Checksum 0x824f6eca, Offset: 0xfa8
// Size: 0x3c8
function private function_e1965ae1() {
    level endon(#"game_ended");
    waitframe(1);
    if (!is_true(level.var_dcf5a517)) {
        level flag::wait_till(#"hash_507a4486c4a79f1d");
    }
    util::wait_network_frame(1);
    level flag::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    if (isdefined(level.item_spawn_stashes)) {
        foreach (supply_stash in level.item_spawn_stashes) {
            setdynentenabled(supply_stash, 1);
        }
    }
    foreach (player in getplayers()) {
        if (isplayer(player)) {
            player weaponobjects::function_ac7c2bf9();
        }
    }
    var_f997302a = getentarraybytype(4);
    for (index = 0; index < var_f997302a.size; index++) {
        if (isdefined(var_f997302a[index])) {
            var_f997302a[index] delete();
        }
    }
    reset_item_world();
    if (isdefined(getgametypesetting(#"hash_7d8c969e384dd1c9")) ? getgametypesetting(#"hash_7d8c969e384dd1c9") : 0) {
        if (isdefined(level.var_5c14d2e6)) {
            foreach (player in getplayers()) {
                player thread [[ level.var_5c14d2e6 ]]();
            }
        }
    }
    if (!item_inventory::function_7d5553ac()) {
        foreach (player in getplayers()) {
            player thread item_inventory::function_44f1ab43();
        }
    }
}

// Namespace item_world/freefall
// Params 1, eflags: 0x40
// Checksum 0x83ecd15d, Offset: 0x1378
// Size: 0x6c
function event_handler[freefall] function_5019e563(eventstruct) {
    if (!isdefined(self.var_554ec2e2)) {
        return;
    }
    if (!is_true(eventstruct.freefall) && !is_true(eventstruct.var_695a7111)) {
        self thread [[ self.var_554ec2e2 ]]();
    }
}

// Namespace item_world/parachute
// Params 1, eflags: 0x40
// Checksum 0x6aa35430, Offset: 0x13f0
// Size: 0x48
function event_handler[parachute] function_87b05fa3(eventstruct) {
    if (!isdefined(self.var_554ec2e2)) {
        return;
    }
    if (!is_true(eventstruct.parachute)) {
        self thread [[ self.var_554ec2e2 ]]();
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x281f88ac, Offset: 0x1440
// Size: 0x21c
function private function_f7fb8a17(reset = 1) {
    level endon(#"game_ended");
    level flag::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    level flag::set(#"hash_2d3b2a4d082ba5ee");
    if (level flag::get(#"item_world_reset")) {
        return;
    }
    level flag::clear(#"item_world_initialized");
    var_47f2f5fa = (1 << 29) - 1;
    seedvalue = randomintrange(0, var_47f2f5fa) + 1;
    /#
        seedvalue = getdvarint(#"hash_46870e6b25b988eb", seedvalue);
    #/
    level.item_spawn_seed = seedvalue;
    match_record::set_stat(#"item_spawn_seed", seedvalue);
    var_6937495e = seedvalue << 1;
    var_6937495e |= reset ? 1 : 0;
    function_4c0953c4(var_6937495e);
    level namespace_f0884ae5::setup(seedvalue, reset);
    level flag::set(#"item_world_initialized");
    if (reset) {
        level flag::set(#"item_world_reset");
    }
    level flag::clear(#"hash_2d3b2a4d082ba5ee");
}

// Namespace item_world/item_world
// Params 1, eflags: 0x1 linked
// Checksum 0x8c2c120a, Offset: 0x1668
// Size: 0x34
function function_4c0953c4(var_6937495e) {
    waitframe(1);
    level clientfield::set("item_world_seed", var_6937495e);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x1 linked
// Checksum 0x8c70a764, Offset: 0x16a8
// Size: 0x34
function function_5d4b134e(var_88ee50db) {
    waitframe(1);
    level clientfield::set("item_world_sanity_random", var_88ee50db);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x5 linked
// Checksum 0xf4547929, Offset: 0x16e8
// Size: 0x80
function private function_8bac489c(supplystash, player) {
    assert(isdefined(supplystash));
    assert(isplayer(player));
    if (supplystash.var_193b3626 === player getentitynumber()) {
        return true;
    }
    return false;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x56f1b99c, Offset: 0x1770
// Size: 0x258
function private function_35c26e09(supplystash) {
    supplystash.var_193b3626 = undefined;
    supplystash.var_80089988 = undefined;
    targetname = isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target;
    var_76c7cb8a = function_91b29d2a(targetname);
    var_3c32093e = 0;
    var_3ba9a53f = [];
    foreach (item in var_76c7cb8a) {
        if (distancesquared(item.origin, supplystash.origin) > 36) {
            continue;
        }
        if (!isdefined(item.var_a6762160)) {
            continue;
        }
        if (item_world_util::can_pick_up(item)) {
            var_3c32093e = 1;
            break;
        }
        var_3ba9a53f[var_3ba9a53f.size] = item;
    }
    if (!var_3c32093e) {
        foreach (item in var_3ba9a53f) {
            function_54ca5536(item.id, -1);
            resetitem = level flag::get(#"item_world_reset");
            function_bfc28859(3, item.id, resetitem);
            break;
        }
    }
    function_e2a06860(supplystash, 0);
    return true;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x5 linked
// Checksum 0xab8bf148, Offset: 0x19d0
// Size: 0x92
function private function_cc1aec8(player, slotid) {
    assert(isplayer(player));
    assert(isint(slotid));
    if (!item_inventory::function_7d5553ac()) {
        return;
    }
    return player item_inventory::function_2e711614(slotid);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x5 linked
// Checksum 0xc5507ae4, Offset: 0x1a70
// Size: 0x400
function private function_199c092d(supplystash, player = undefined) {
    assert(!isdefined(supplystash.var_193b3626));
    if (isdefined(supplystash.var_193b3626)) {
        return false;
    }
    supplystash.var_193b3626 = player getentitynumber();
    item = function_cc1aec8(player, 10);
    if (!isdefined(item) || item.var_a6762160.name !== #"resource_item_loot_locker_key") {
        return false;
    }
    lootweapons = player namespace_a0d533d1::get_loot_weapons();
    assert(lootweapons.size > 0);
    if (lootweapons.size <= 0) {
        return false;
    }
    var_cf23afee = [];
    foreach (weaponname in lootweapons) {
        var_cf23afee[weaponname] = 1;
    }
    targetname = isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target;
    var_76c7cb8a = function_91b29d2a(targetname);
    foreach (item in var_76c7cb8a) {
        if (distancesquared(item.origin, supplystash.origin) > 36) {
            continue;
        }
        if (!isdefined(item.var_a6762160) || !isdefined(item.var_a6762160.weapon)) {
            continue;
        }
        if (item_world_util::can_pick_up(item) && !isdefined(var_cf23afee[item.var_a6762160.weapon.name])) {
            consume_item(item);
            continue;
        }
        if (isdefined(player.var_fbcc86d3) && isdefined(player.var_fbcc86d3[item.var_a6762160.weapon.name])) {
            consume_item(item);
            continue;
        }
        if (isdefined(var_cf23afee[item.var_a6762160.weapon.name])) {
            function_54ca5536(item.id, -1);
            resetitem = level flag::get(#"item_world_reset");
            function_bfc28859(3, item.id, resetitem);
        }
    }
    return true;
}

// Namespace item_world/item_world
// Params 4, eflags: 0x5 linked
// Checksum 0xcd0a50b5, Offset: 0x1e78
// Size: 0x74
function private function_23b313bd(player, eventtype, eventdata, var_c5a66313) {
    if (is_true(level.var_ab396c31)) {
        return;
    }
    if (!isdefined(player)) {
        return;
    }
    if (isdefined(level.var_e8af489f)) {
        [[ level.var_e8af489f ]](player, eventtype, eventdata, var_c5a66313);
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0xde4c4bb0, Offset: 0x1ef8
// Size: 0x8c
function private _on_player_connect() {
    function_f3b6e182(self);
    self.var_d7a70ae4 = undefined;
    if (function_76915220() && (!self issplitscreen() || !self function_f27ff71f())) {
        self thread function_ba96cdf(self);
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0x93719b42, Offset: 0x1f90
// Size: 0x2c
function private _on_player_disconnect() {
    if (isdefined(self.var_19caeeea)) {
        self.var_19caeeea delete();
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0xa02aa94f, Offset: 0x1fc8
// Size: 0x2a8
function private function_9aefb438(params) {
    if (isdefined(params) && params.message == #"hash_52e9e8e985489587") {
        if (!isdefined(self) || !isplayer(self) || !isalive(self)) {
            params.player = undefined;
            return;
        }
        msgtype = 13;
        networkid = undefined;
        if (!isdefined(self.var_bf3cabc9)) {
            var_9b882d22 = self.var_d5673d87;
            if (!isdefined(var_9b882d22) || !isdefined(var_9b882d22.networkid)) {
                params.player = undefined;
                return;
            }
            if (!is_true(var_9b882d22.var_5d97fed1) && distance2dsquared(var_9b882d22.origin, self.origin) > function_a3f6cdac(128)) {
                params.player = undefined;
                return;
            }
            if (!is_true(var_9b882d22.var_5d97fed1) && var_9b882d22.var_a6762160.rarity == #"epic") {
                params.message = #"hash_433c75db9fd3177e";
            }
            networkid = var_9b882d22.networkid;
        } else {
            msgtype = 14;
            networkid = self.var_bf3cabc9 getentitynumber();
        }
        members = getplayers(self.team);
        foreach (member in members) {
            member function_b00db06(msgtype, networkid, self getentitynumber());
        }
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0xe5b685d2, Offset: 0x2278
// Size: 0xd2
function private function_f27ff71f() {
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
        if (is_true(player.var_d7a70ae4)) {
            return true;
        }
    }
    return false;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0xd55e6955, Offset: 0x2358
// Size: 0xfc
function private function_df1098a() {
    self notify("29ab4d2ab0188efc");
    self endon("29ab4d2ab0188efc");
    level endon(#"game_ended");
    while (true) {
        players = getplayers();
        for (index = 0; index < players.size; index++) {
            player = players[index];
            if (isalive(player)) {
                player function_7c84312d(player getplayercamerapos(), player getplayerangles());
            }
            if ((index + 1) % 15 == 0) {
                waitframe(1);
            }
        }
        waitframe(1);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x394ae851, Offset: 0x2460
// Size: 0x504
function private function_ad7ad6ce(trigger_struct) {
    level endon(#"game_ended");
    self endon(#"death");
    usetrigger = self;
    activator = trigger_struct.activator;
    if (!isdefined(activator) || !isplayer(activator) || !isalive(activator) || activator inlaststand()) {
        return;
    }
    if (!activator function_8e0d14c1()) {
        return;
    }
    if (activator function_4a8572c4()) {
        return;
    }
    if (is_true(level.var_ab396c31)) {
        return;
    }
    var_91d3170d = activator clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
    if (var_91d3170d == 4) {
        return;
    }
    if (var_91d3170d == 3) {
        stash = item_world_util::function_31f5aa51(usetrigger.itemstruct);
        if (!isdefined(stash)) {
            return;
        }
        if (function_199c092d(stash, activator)) {
            var_91d3170d = 1;
        } else {
            return;
        }
    }
    if (var_91d3170d == 1 || var_91d3170d == 0 && item_world_util::function_83c20f83(usetrigger.itemstruct)) {
        usetrigger sethintstring(#"");
        stashes = level.var_93d08989[usetrigger.itemstruct.targetname];
        if (!isdefined(stashes) && isdefined(usetrigger.itemstruct.targetnamehash)) {
            stashes = getentarray(usetrigger.itemstruct.targetnamehash, "targetname");
        }
        stash = undefined;
        if (isdefined(stashes) && stashes.size > 0) {
            stashes = arraysortclosest(stashes, usetrigger.itemstruct.origin, 1, 0, 12);
            if (stashes.size > 0) {
                stash = stashes[0];
            }
        }
        if (isdefined(stash) && isdefined(stash.var_b91441dd) && is_true(stash.var_b91441dd.var_4f220d03)) {
            stash thread consume_item(usetrigger.itemstruct);
            stash thread namespace_65181344::function_fd87c780(stash.var_b91441dd.name, stash.available, 3);
        } else {
            activator clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 2);
            activator thread function_eb900758(item_world_util::function_31f5aa51(usetrigger.itemstruct));
        }
        function_a54d07e6(usetrigger.itemstruct, activator);
        return;
    }
    if (var_91d3170d == 2) {
        usetrigger sethintstring(#"");
        return;
    }
    item = usetrigger.itemstruct;
    if (isdefined(item) && !isentity(item) && isdefined(item.id)) {
        item = function_b1702735(item.id);
    }
    var_28ace73 = 1;
    if (isdefined(level.var_f365bb30)) {
        var_28ace73 = activator [[ level.var_f365bb30 ]](item);
    }
    if (activator item_world_util::can_pick_up(item) && var_28ace73) {
        activator pickup_item(item);
        activator function_58b29f4f();
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x6af23a5e, Offset: 0x2970
// Size: 0xb2
function private function_eb900758(stash) {
    self endon(#"disconnect");
    self childthread function_d87c50ae(stash);
    self childthread function_6266f448();
    self waittill(#"death", #"entering_last_stand", #"hash_2781407e327b42ee");
    self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
    self.var_c4462112 = 1;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0xc7be06e8, Offset: 0x2a30
// Size: 0xc6
function private function_6266f448() {
    self notify("3419b6bfe3c3eb23");
    self endon("3419b6bfe3c3eb23");
    self endon(#"death", #"entering_last_stand", #"hash_2781407e327b42ee");
    while (true) {
        waitresult = self waittill(#"menuresponse");
        if (waitresult.menu == "MultiItemPickup" && waitresult.response == "multi_item_menu_closed") {
            break;
        }
    }
    self notify(#"hash_2781407e327b42ee");
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0xb3be3ae3, Offset: 0x2b00
// Size: 0x236
function private function_d87c50ae(stash) {
    self notify("4f76a394315d76c5");
    self endon("4f76a394315d76c5");
    self endon(#"death", #"entering_last_stand", #"hash_2781407e327b42ee");
    while (true) {
        waitframe(1);
        if (!isdefined(self.groupitems)) {
            break;
        }
        if (self.groupitems.size == 0) {
            break;
        }
        var_9f69a4d3 = 0;
        foreach (item in self.groupitems) {
            if (isdefined(item) && self item_world_util::can_pick_up(item)) {
                var_9f69a4d3 = 1;
                break;
            }
        }
        if (!var_9f69a4d3) {
            break;
        }
        if (self isfiring() || self playerads() > 0.3 || self ismeleeing()) {
            break;
        }
        if (isdefined(stash) && is_true(stash.lootlocker) && !function_8bac489c(stash, self)) {
            break;
        }
    }
    if (isdefined(stash) && is_true(stash.lootlocker)) {
        function_35c26e09(stash);
    }
    self notify(#"hash_2781407e327b42ee");
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x179d0fd1, Offset: 0x2d40
// Size: 0x1e
function function_f9da222a(identifier) {
    return isdefined(level.var_66383953[identifier]);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x1 linked
// Checksum 0xdd2c1c34, Offset: 0x2d68
// Size: 0x78
function function_861f348d(identifier, handler) {
    assert(!function_f9da222a(identifier), "<dev string:x38>" + identifier);
    if (!isdefined(level.var_66383953)) {
        level.var_66383953 = [];
    }
    level.var_66383953[identifier] = handler;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0xf76695c1, Offset: 0x2de8
// Size: 0xa2
function private function_ba96cdf(player) {
    if (is_true(level.var_ab396c31)) {
        return;
    }
    function_1b11e73c();
    if (isplayer(player)) {
        var_fee74908 = player function_e6ea1ee0();
        if (isdefined(player)) {
            player function_45ecbbc5(var_fee74908);
            player.var_d7a70ae4 = 1;
        }
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x5 linked
// Checksum 0x43fcae17, Offset: 0x2e98
// Size: 0x12
function private function_76915220() {
    return level.var_703d32de > 0;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x1 linked
// Checksum 0x24f1176a, Offset: 0x2eb8
// Size: 0x1ae
function function_248022d9() {
    level.var_37a4536d = [];
    if (!isdefined(level.var_75dc9c49)) {
        level.var_75dc9c49 = 0;
    }
    resetflag = level flag::get(#"item_world_reset");
    while (true) {
        var_5610ded4 = level flag::get(#"item_world_reset");
        if (var_5610ded4 != resetflag) {
            level.var_37a4536d = [];
        }
        if (level.var_75dc9c49 > 0) {
            time = gettime();
            for (index = 0; index < level.var_37a4536d.size; index++) {
                respawnitem = level.var_37a4536d[index];
                if (time - respawnitem.hidetime >= level.var_75dc9c49) {
                    function_54ca5536(respawnitem.id, 0);
                    function_bfc28859(3, respawnitem.id, var_5610ded4, 1);
                    level.var_37a4536d[index] = undefined;
                    continue;
                }
                break;
            }
            arrayremovevalue(level.var_37a4536d, undefined, 0);
        }
        resetflag = var_5610ded4;
        waitframe(1);
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x1 linked
// Checksum 0xfce91ec, Offset: 0x3070
// Size: 0x9ac
function function_a54d07e6(item, activator) {
    assert(isdefined(item));
    if (isdefined(item) && (isdefined(item.targetname) || isdefined(item.targetnamehash))) {
        targetname = isdefined(item.targetname) ? item.targetname : item.targetnamehash;
        stashes = level.var_93d08989[targetname];
        if (isdefined(stashes) && stashes.size > 0) {
            stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
            if (stashes.size <= 0) {
                return;
            }
            stash = stashes[0];
            state = function_ffdbe8c2(stash);
            if (state == 0) {
                function_b516210b(isdefined(stash.var_15d44120) ? stash.var_15d44120 : stash.model, stash.origin, activator);
                function_e2a06860(stash, 1);
                params = {#activator:activator, #state:state};
                stash callback::callback(#"on_stash_open", params);
                if (isdefined(stash.onuse)) {
                    succeeded = stash [[ stash.onuse ]](activator, state, 1);
                }
            } else if (state == 1) {
                stashitems = function_91b29d2a(targetname);
                stashitems = arraysortclosest(stashitems, stash.origin, stashitems.size, 0, 12);
                foreach (stashitem in stashitems) {
                    if (isdefined(stashitem.var_a6762160) && item_world_util::function_83c20f83(stashitem)) {
                        return;
                    }
                }
                dynamicitems = [];
                foreach (itemspawndrop in level.item_spawn_drops) {
                    if (isdefined(itemspawndrop) && itemspawndrop.targetnamehash === targetname) {
                        dynamicitems[dynamicitems.size] = itemspawndrop;
                    }
                }
                dynamicitems = arraysortclosest(dynamicitems, stash.origin, dynamicitems.size, 0, 12);
                foreach (dynamicitem in dynamicitems) {
                    if (item_world_util::function_83c20f83(dynamicitem)) {
                        return;
                    }
                }
                if (is_true(stash.lootlocker) && activator !== level) {
                    function_35c26e09(stash);
                    function_e2a06860(stash, 0);
                    if (isdefined(stash.onuse)) {
                        succeeded = stash [[ stash.onuse ]](activator, state, 0);
                    }
                    return;
                }
                function_e2a06860(stash, 2);
                if (isdefined(stash.onuse)) {
                    succeeded = stash [[ stash.onuse ]](activator, state, 2);
                }
                stash notify(#"hash_4c78fc894646853d");
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
            if (stash.var_bad13452 == 0) {
                function_b516210b(stash.model, stash.origin, activator);
                params = {#activator:activator, #state:state};
                stash function_ad255265(params);
                stash callback::callback(#"on_stash_open", params);
                if (is_true(stash.var_a76e4941)) {
                    stash animscripted("death_stash_open", stash.origin, stash.angles, "p8_fxanim_wz_death_stash_used_anim", "normal", "root", 1, 0);
                } else if (is_true(stash.var_a64ed253)) {
                }
                stash.var_bad13452 = 1;
                return;
            }
            if (stash.var_bad13452 == 1) {
                dynamicitems = [];
                foreach (itemspawndrop in level.item_spawn_drops) {
                    if (isdefined(itemspawndrop) && itemspawndrop.targetnamehash === targetname) {
                        dynamicitems[dynamicitems.size] = itemspawndrop;
                    }
                }
                dynamicitems = arraysortclosest(dynamicitems, stashes[0].origin, dynamicitems.size, 0, 12);
                foreach (dynamicitem in dynamicitems) {
                    if (item_world_util::function_83c20f83(dynamicitem)) {
                        return;
                    }
                }
                if (is_true(stash.var_a76e4941)) {
                    stash animscripted("death_stash_empty", stash.origin, stash.angles, "p8_fxanim_wz_death_stash_empty_anim", "normal", "root", 1, 0);
                } else if (is_true(stash.var_a64ed253)) {
                    stash animscripted("supply_drop_empty", stash.origin, stash.angles, "p9_fxanim_mp_care_package_open_anim", "normal", "root", 1, 0);
                    stash thread function_ee32337(stash);
                }
                stash.var_bad13452 = 2;
                stash clientfield::set("dynamic_stash", 2);
                stash clientfield::set("supply_drop_fx", 0);
            }
        }
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x1 linked
// Checksum 0x96ce047f, Offset: 0x3a28
// Size: 0x7a
function loop_sound(alias, interval) {
    self endon(#"death");
    while (true) {
        playsoundatposition(alias, self.origin);
        wait interval;
        interval /= 1.2;
        if (interval < 0.08) {
            break;
        }
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x1 linked
// Checksum 0xc2513029, Offset: 0x3ab0
// Size: 0x134
function function_ee32337(stash) {
    stash endon(#"death");
    assert(isentity(stash));
    stash thread loop_sound("wpn_semtex_alert", 0.84);
    wait 5;
    playfx(#"hash_54ccf5af7123ba27", stash.origin);
    playsoundatposition(#"hash_2f1ae087d02ed33f", stash.origin);
    stash radiusdamage(stash.origin, 128, 50, 10, undefined, "MOD_EXPLOSIVE", getweapon(#"supplydrop"));
    stash delete();
}

// Namespace item_world/item_world
// Params 1, eflags: 0x1 linked
// Checksum 0x3226ba26, Offset: 0x3bf0
// Size: 0x104
function function_ad255265(params) {
    activator = params.activator;
    if (!isplayer(activator) || is_true(self.var_32ed1056)) {
        return;
    }
    if (self.stash_type === 0) {
        drop_type = #"hash_24f0444fc5e083ea";
    } else if (self.stash_type === 1) {
        drop_type = #"hash_4fbb9339305f16f2";
    } else if (self.stash_type === 2) {
        drop_type = #"hash_5a5b9e642747c4ab";
    }
    if (isdefined(drop_type)) {
        self.var_32ed1056 = 1;
        scoreevents::processscoreevent(drop_type, activator);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x922bf379, Offset: 0x3d00
// Size: 0x3a
function private function_c199bcc6(item) {
    if (item_inventory::function_7d5553ac()) {
        return 0;
    }
    return self item_inventory::can_pickup_ammo(item);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x76ca2d88, Offset: 0x3d48
// Size: 0x3a
function private function_6105623a(item) {
    if (item_inventory::function_7d5553ac()) {
        return 0;
    }
    return self item_inventory::function_550fcb41(item);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0xbdc7abac, Offset: 0x3d90
// Size: 0x18c
function private function_3f63e44f(itemdef) {
    if (!isdefined(itemdef) || !isdefined(self)) {
        return false;
    }
    if (!is_true(itemdef.var_a6762160.var_b362e309) || is_true(itemdef.var_5d97fed1)) {
        return false;
    }
    if (is_true(itemdef.var_eeb03183)) {
        return false;
    }
    if (isdefined(itemdef.var_afda6972) && gettime() < itemdef.var_afda6972) {
        return false;
    }
    usedir = itemdef.origin - self.origin;
    if (lengthsquared(usedir) >= function_a3f6cdac(64)) {
        return false;
    }
    if (!self item_world_util::can_pick_up(itemdef)) {
        return false;
    }
    if (isentity(itemdef)) {
        var_ba207c19 = itemdef function_3d33610f();
        if (var_ba207c19.moving && gettime() - var_ba207c19.time < 1000) {
            return false;
        }
    }
    return true;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x5 linked
// Checksum 0x859137, Offset: 0x3f28
// Size: 0xe2
function private function_b0443f69(var_f4b807cb) {
    pickups = 0;
    for (itemindex = 0; itemindex < var_f4b807cb.size; itemindex++) {
        itemdef = var_f4b807cb[itemindex];
        if (!isdefined(itemdef.var_a6762160)) {
            continue;
        }
        if (!self function_3f63e44f(itemdef)) {
            continue;
        }
        if (isdefined(level.var_d539e0dd) && ![[ level.var_d539e0dd ]](itemdef)) {
            continue;
        }
        self thread pickup_item(itemdef, 1, 1, 1);
        pickups++;
        if (pickups >= 5) {
            break;
        }
    }
}

// Namespace item_world/item_world
// Params 6, eflags: 0x5 linked
// Checksum 0xb4c2f144, Offset: 0x4018
// Size: 0x2a2
function private function_b30c15ae(origin, angles, forward, var_f4b807cb, var_512ddf16, maxdist) {
    assert(isplayer(self));
    if (self inlaststand()) {
        return;
    }
    if (isdefined(level.var_b290ca72)) {
        var_b290ca72 = [[ level.var_b290ca72 ]](self);
        assert(var_b290ca72 == 1 || var_b290ca72 == 0);
        if (!var_b290ca72) {
            return;
        }
    }
    var_9b882d22 = undefined;
    if (var_512ddf16 && isdefined(self.var_d7abc784)) {
        var_75f6d739 = anglestoforward((0, angles[1], 0));
        for (itemindex = 0; itemindex < var_f4b807cb.size; itemindex++) {
            itemdef = var_f4b807cb[itemindex];
            toitem = itemdef.origin - origin;
            if (!item_world_util::function_83c20f83(itemdef)) {
                continue;
            }
            var_1777205e = vectordot(var_75f6d739, vectornormalize((toitem[0], toitem[1], 0)));
            if (var_1777205e >= 0.5 && distancesquared(itemdef.origin, self.var_d7abc784) <= function_a3f6cdac(12)) {
                if (item_world_util::function_2eb2c17c(origin, itemdef)) {
                    var_9b882d22 = itemdef;
                    break;
                }
                break;
            }
        }
    }
    if (!isdefined(var_9b882d22)) {
        var_4bd72bfe = self.var_c1ea9cae;
        var_9b882d22 = item_world_util::function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe);
    }
    return var_9b882d22;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x5 linked
// Checksum 0xfc9ea59, Offset: 0x42c8
// Size: 0xe7e
function private function_7c84312d(origin, angles) {
    assert(isplayer(self));
    if (!isdefined(self.inventory) && !item_inventory::function_7d5553ac()) {
        return;
    }
    usetrigger = self.var_19caeeea;
    if (!isdefined(usetrigger)) {
        return;
    }
    if (is_true(self.disableitempickup)) {
        return;
    }
    forward = vectornormalize(anglestoforward(angles));
    var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
    maxdist = util::function_16fb0a3b();
    if (var_512ddf16) {
        maxdist = 128;
    }
    var_f4b807cb = function_2e3efdda(origin, forward, 128, maxdist, 0);
    if (isalive(self) && !self inlaststand()) {
        function_b0443f69(var_f4b807cb);
    }
    var_9b882d22 = function_b30c15ae(origin, angles, forward, var_f4b807cb, var_512ddf16, maxdist);
    var_caafaa25 = #"";
    if (isdefined(var_9b882d22) && !self isinvehicle()) {
        self.groupitems = [];
        hasbackpack = self item_inventory::has_backpack();
        stashitem = item_world_util::function_83c20f83(var_9b882d22);
        var_52bfa6e5 = !stashitem && function_6105623a(var_9b882d22);
        var_f4b42fba = self item_inventory::has_armor() && var_9b882d22.var_a6762160.itemtype == #"armor";
        isammo = var_9b882d22.var_a6762160.itemtype == #"ammo";
        var_de41d336 = !hasbackpack && var_9b882d22.var_a6762160.itemtype == #"backpack";
        if (stashitem || !isammo && !var_de41d336 && !var_52bfa6e5 && !var_f4b42fba) {
            var_433d429 = 14;
            self.groupitems = function_2e3efdda(var_9b882d22.origin, undefined, 128, var_433d429);
            self.groupitems = self array::filter(self.groupitems, 0, &item_world_util::can_pick_up);
        }
        if (self.groupitems.size == 1) {
            stashitem = item_world_util::function_83c20f83(self.groupitems[0]);
        }
        var_b46724f6 = 0;
        if (isdefined(self.var_d5673d87) && (isdefined(var_9b882d22.targetname) || isdefined(var_9b882d22.targetnamehash))) {
            if (isdefined(self.var_d5673d87.targetname) || isdefined(self.var_d5673d87.targetnamehash)) {
                var_45602f41 = isdefined(var_9b882d22.targetname) ? var_9b882d22.targetname : var_9b882d22.targetnamehash;
                var_d2daaa1a = isdefined(self.var_d5673d87.targetname) ? self.var_d5673d87.targetname : self.var_d5673d87.targetnamehash;
                var_b46724f6 = var_45602f41 != var_d2daaa1a;
            }
        }
        if (stashitem) {
            usetrigger setcursorhint("HINT_NOICON");
            usetrigger sethintstring(#"");
            usetrigger function_89fca53b(1);
            usetrigger function_49462027(0);
            stash = item_world_util::function_31f5aa51(var_9b882d22);
            var_e30063d2 = isdefined(stash) && is_true(stash.lootlocker);
            currentstate = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status");
            if (currentstate != 2 || currentstate == 2 && var_b46724f6) {
                if (distancesquared(origin, var_9b882d22.origin) > function_a3f6cdac(128)) {
                    self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
                } else if (var_e30063d2 && !function_8bac489c(stash, self)) {
                    if (self item_inventory::function_471897e2()) {
                        self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 3);
                    } else {
                        self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 4);
                    }
                } else {
                    self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 1);
                }
            }
        } else {
            usetrigger function_89fca53b(0);
            usetrigger function_49462027(1, 1 | 16 | 2097152 | 65536 | 1048576);
            self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
            var_a6762160 = var_9b882d22.var_a6762160;
            if (isdefined(var_a6762160.weapon) && var_a6762160.weapon != level.weaponnone) {
                if (var_a6762160.itemtype != #"ammo") {
                    usetrigger setcursorhint("HINT_WEAPON_3D", namespace_a0d533d1::function_2b83d3ff(var_9b882d22));
                    var_caafaa25 = #"";
                    if (isdefined(var_a6762160.hintstring)) {
                        var_caafaa25 = var_a6762160.hintstring;
                    } else if (isdefined(var_a6762160.weapon)) {
                        var_caafaa25 = var_a6762160.weapon.displayname;
                    } else {
                        var_caafaa25 = isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"weapon/pickupnewweapon";
                    }
                    usetrigger sethintstring(var_caafaa25);
                } else {
                    usetrigger setcursorhint("HINT_3D");
                    var_caafaa25 = isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"";
                    usetrigger sethintstring(var_caafaa25);
                }
            } else {
                usetrigger setcursorhint("HINT_3D");
                var_caafaa25 = isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"";
                usetrigger sethintstring(var_caafaa25);
            }
        }
        usetrigger.itemstruct = var_9b882d22;
        usetrigger.origin = var_9b882d22.origin + (0, 0, 4);
        usetrigger.angles = (0, 0, 0);
        usetrigger triggerenable(1);
        function_dae4ab9b(usetrigger, self.var_207c9892);
        if (!is_true(var_9b882d22.var_5d97fed1)) {
            self clientfield::set_player_uimodel("hudItems.pickupHintGold", var_9b882d22.var_a6762160.rarity == #"epic");
        }
        var_512ddf16 = self clientfield::get_player_uimodel("hudItems.multiItemPickup.status") == 2;
        if (!is_true(var_9b882d22.var_5d97fed1) && !var_512ddf16) {
            if (var_9b882d22.var_a6762160.itemtype == #"ammo") {
                if (!function_c199bcc6(var_9b882d22)) {
                    function_dae4ab9b(usetrigger, getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000);
                }
            } else if (!isdefined(function_a4e63191(var_9b882d22))) {
                function_dae4ab9b(usetrigger, getdvarint(#"hash_3ec4f617fad5b87c", 150) / 1000);
            }
        }
        self.var_d5673d87 = var_9b882d22;
        if (isdefined(self.var_d5673d87)) {
            self.var_d7abc784 = self.var_d5673d87.origin;
        } else {
            self.var_d7abc784 = undefined;
        }
    } else {
        self clientfield::set_player_uimodel("hudItems.multiItemPickup.status", 0);
        self clientfield::set_player_uimodel("hudItems.pickupHintGold", 0);
        usetrigger.itemstruct = undefined;
        usetrigger triggerenable(0);
        self.groupitems = undefined;
    }
    self.var_cc586562 = undefined;
    self.var_bf3cabc9 = undefined;
    eyepos = self getplayercamerapos();
    if (isdefined(var_9b882d22) && is_true(var_9b882d22.var_5d97fed1)) {
        var_caafaa25 = #"wz/supply_stash";
        var_1ba7b9c8 = arraysortclosest(level.var_5ce07338, var_9b882d22.origin, 1, 0, 12);
        if (var_1ba7b9c8.size > 0 && isdefined(var_1ba7b9c8[0].displayname)) {
            var_caafaa25 = var_1ba7b9c8[0].displayname;
        }
        var_c36bd68a = arraysortclosest(level.var_ace9fb52, var_9b882d22.origin, 1, 0, 12);
        if (var_c36bd68a.size > 0) {
            var_caafaa25 = #"wz/death_stash";
        } else {
            var_6594679a = arraysortclosest(level.item_supply_drops, var_9b882d22.origin, 1, 0, 12);
            if (var_6594679a.size > 0) {
                var_caafaa25 = #"wz/supply_drop";
            }
        }
    } else if (!isdefined(var_9b882d22) || distance2dsquared(var_9b882d22.origin, eyepos) > function_a3f6cdac(128)) {
        angles = self getplayerangles();
        self.var_bf3cabc9 = item_world_util::function_6af455de(0, eyepos, angles);
        hintstring = item_world_util::function_c62ad9a7(self.var_bf3cabc9);
        if (hintstring != #"") {
            var_caafaa25 = hintstring;
        }
    }
    self.var_cc586562 = var_caafaa25;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x1 linked
// Checksum 0xe8bd6c73, Offset: 0x5150
// Size: 0x17a
function function_c8ab2022(item, var_cdf8c0d1 = 0) {
    if (!isdefined(item)) {
        return 0;
    }
    var_a6762160 = item.var_a6762160;
    itemcount = item.count;
    if (var_a6762160.itemtype == #"cash") {
        if (var_cdf8c0d1 && !is_true(var_a6762160.stackable)) {
            return 1;
        }
        return (isdefined(item.count) ? item.count : 1);
    }
    if (!isdefined(itemcount)) {
        itemcount = isdefined(var_a6762160.amount) ? var_a6762160.amount : 1;
        if (var_a6762160.itemtype == #"weapon") {
            itemcount = 1;
        }
    }
    if (var_cdf8c0d1 && !is_true(var_a6762160.stackable) && (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1) == 1) {
        itemcount = 1;
    }
    return itemcount;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x1 linked
// Checksum 0xea4bc830, Offset: 0x52d8
// Size: 0x3a4
function consume_item(item, timeout = 0) {
    if (is_true(level.var_ab396c31)) {
        return;
    }
    if (isentity(item)) {
        item.hidetime = gettime();
        if (isdefined(item.var_d783088e)) {
            foreach (sensordart in item.var_d783088e) {
                if (!isdefined(sensordart)) {
                    continue;
                }
                if (isdefined(level.var_9911d36f)) {
                    sensordart thread [[ level.var_9911d36f ]]();
                }
            }
            item.var_d783088e = undefined;
        }
    } else {
        if (isdefined(item)) {
            function_54ca5536(item.id, gettime());
            if (isdefined(item.var_a6762160) && is_true(item.var_a6762160.var_47f145b4)) {
                respawnitem = spawnstruct();
                respawnitem.id = item.id;
                respawnitem.hidetime = gettime();
                level.var_37a4536d[level.var_37a4536d.size] = respawnitem;
            }
            if (level flag::get(#"item_world_reset")) {
                function_bfc28859(2, item.id);
            } else {
                function_bfc28859(1, item.id);
            }
        }
        level.var_703d32de++;
    }
    if (isdefined(item)) {
        function_a54d07e6(item, self);
    }
    if (isentity(item)) {
        if (timeout) {
            item clientfield::set("dynamic_item_drop", 3);
        } else {
            item clientfield::set("dynamic_item_drop", 2);
        }
        item function_46d7f921(32767);
        item ghost();
        util::wait_network_frame(2);
        if (!isdefined(item)) {
            return;
        }
        if (isdefined(item.var_38af96b9)) {
            var_38af96b9 = item.var_38af96b9;
            var_38af96b9 stopsounds();
            util::wait_network_frame(1);
            if (isdefined(var_38af96b9)) {
                var_38af96b9 delete();
            }
        }
        if (!isdefined(item)) {
            return;
        }
        item delete();
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0x815433ff, Offset: 0x5688
// Size: 0x94
function function_df82b00c() {
    if (!isplayer(self)) {
        assert(0);
        return;
    }
    if (isdefined(self.var_19caeeea)) {
        self.var_19caeeea triggerenable(0);
    }
    self.disableitempickup = 1;
    self.var_d5673d87 = undefined;
    self clientfield::set_to_player("disableItemPickup", 1);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x1 linked
// Checksum 0x8d335967, Offset: 0x5728
// Size: 0xb4
function function_528ca826(networkid) {
    if (item_world_util::function_d9648161(networkid)) {
        if (item_world_util::function_2c7fc531(networkid)) {
            return function_b1702735(networkid);
        }
        if (item_world_util::function_da09de95(networkid)) {
            if (isdefined(level.item_spawn_drops[networkid])) {
                return level.item_spawn_drops[networkid];
            }
            return;
        }
        assert(0, "<dev string:x74>");
    }
}

// Namespace item_world/item_world
// Params 6, eflags: 0x1 linked
// Checksum 0x39c7b8a, Offset: 0x57e8
// Size: 0x132
function function_2e3efdda(origin, dir, maxitems, maxdistance, dot, var_bc1582aa = 1) {
    maxitems = isdefined(maxitems) ? int(min(maxitems, 4000)) : maxitems;
    var_f4b807cb = function_abaeb170(origin, dir, maxitems, maxdistance, dot, var_bc1582aa, -2147483647);
    var_6665e24 = arraysortclosest(level.item_spawn_drops, origin, maxitems, 0, maxdistance);
    var_f4b807cb = arraycombine(var_f4b807cb, var_6665e24, 1, 0);
    var_f4b807cb = arraysortclosest(var_f4b807cb, origin, maxitems, 0, maxdistance);
    return var_f4b807cb;
}

// Namespace item_world/item_world
// Params 4, eflags: 0x1 linked
// Checksum 0x854c3f68, Offset: 0x5928
// Size: 0x4fc
function function_de2018e3(item, player, slotid = undefined, playgesture = 1) {
    if (!isdefined(item)) {
        return 0;
    }
    var_a6762160 = item.var_a6762160;
    if (!isdefined(item.var_1181c08b)) {
        item.var_1181c08b = var_a6762160.var_1181c08b;
    }
    if (isdefined(var_a6762160.handler)) {
        handlerfunc = level.var_66383953[var_a6762160.handler];
        if (isdefined(handlerfunc)) {
            var_aec6fa7f = item.amount;
            if (!isdefined(var_aec6fa7f) || item.amount == 0) {
                if (var_a6762160.itemtype == #"ammo") {
                    if (!isdefined(var_aec6fa7f)) {
                        var_aec6fa7f = var_a6762160.amount;
                    }
                } else if (var_a6762160.itemtype == #"weapon") {
                    if (!isdefined(item.amount)) {
                        weapon = namespace_a0d533d1::function_2b83d3ff(item);
                        var_aec6fa7f = var_a6762160.amount;
                        if (isdefined(weapon)) {
                            var_aec6fa7f = var_a6762160.amount * weapon.clipsize;
                        }
                    }
                } else if (var_a6762160.itemtype == #"armor") {
                    if (!is_true(var_a6762160.var_b5b2485b)) {
                        armoramount = isdefined(item.amount) ? item.amount : var_a6762160.amount;
                        var_aec6fa7f = armoramount;
                    } else {
                        var_aec6fa7f = var_a6762160.amount;
                    }
                } else if (namespace_a0d533d1::function_1507e6f0(var_a6762160)) {
                    if (isentity(item)) {
                        var_aec6fa7f = item.ammo;
                    }
                    if (!isdefined(var_aec6fa7f)) {
                        var_aec6fa7f = 0;
                    }
                } else {
                    var_aec6fa7f = 0;
                }
            }
            var_d72b1a4b = function_c8ab2022(item, 0);
            var_8cd447d8 = function_c8ab2022(item, 1);
            profilestart();
            var_c5781c22 = player [[ handlerfunc ]](item, player, item.networkid, item.id, var_8cd447d8, var_aec6fa7f, slotid);
            profilestop();
            var_c5781c22 += var_d72b1a4b - var_8cd447d8;
            assert(isint(var_c5781c22) && var_c5781c22 >= 0);
            if (var_a6762160.itemtype == #"ammo" && var_d72b1a4b === var_c5781c22) {
            } else if (var_c5781c22 == var_d72b1a4b) {
            } else {
                if (is_true(playgesture)) {
                    player gestures::function_56e00fbf("gestable_grab", undefined, 0);
                }
                if (isdefined(item)) {
                    if (var_a6762160.itemtype == #"ammo") {
                        item.amount = var_c5781c22;
                    } else {
                        item.count = var_c5781c22;
                    }
                    if (isentity(item)) {
                        item clientfield::set("dynamic_item_drop_count", int(max(item.count, item.amount)));
                    }
                }
            }
            if (var_c5781c22 != var_d72b1a4b) {
                var_fceba0ce = {#item:item, #count:var_8cd447d8, #player:player};
                self callback::callback(#"on_item_pickup", var_fceba0ce);
            }
            return var_c5781c22;
        }
    }
    assertmsg("<dev string:xa6>" + var_a6762160.name + "<dev string:xd4>");
}

// Namespace item_world/item_world
// Params 2, eflags: 0x5 linked
// Checksum 0x26291a03, Offset: 0x5e30
// Size: 0x6a
function private function_a4e63191(item, var_26a492bc) {
    assert(isplayer(self));
    if (item_inventory::function_7d5553ac()) {
        return;
    }
    return self item_inventory::function_e66dcff5(item, var_26a492bc);
}

// Namespace item_world/item_world
// Params 4, eflags: 0x1 linked
// Checksum 0xb1d17040, Offset: 0x5ea8
// Size: 0x4a4
function pickup_item(item, var_22be503 = 1, var_26a492bc = 0, var_b362e309 = 0) {
    assert(isplayer(self));
    if (!isdefined(self.inventory) && !item_inventory::function_7d5553ac()) {
        return 0;
    }
    if (!item_world_util::can_pick_up(item)) {
        return 0;
    }
    if (is_true(self.is_reviving_any) || is_true(self.var_5c574004)) {
        return 0;
    }
    if (isdefined(item.hidefromteam) && item.hidefromteam == self.team) {
        if (!isdefined(item.var_6e788302) || item.var_6e788302 !== self getentitynumber()) {
            self playsoundtoplayer(#"uin_default_action_denied", self);
            return 0;
        }
    }
    self dynent_use::function_7f2040e8();
    if (var_22be503) {
        var_fa3df96 = self function_a4e63191(item, var_26a492bc);
    }
    if (isdefined(var_fa3df96)) {
        success = self function_83ddce0f(item, var_fa3df96);
        return success;
    } else if (item.var_a6762160.itemtype != #"weapon") {
        var_d72b1a4b = function_c8ab2022(item, 0);
        var_8cd447d8 = function_c8ab2022(item, 1);
        var_77e61fc6 = function_de2018e3(item, self, undefined, !var_b362e309);
        var_77e61fc6 += var_d72b1a4b - var_8cd447d8;
        if (var_77e61fc6 == 0) {
            if (item.var_a6762160.itemtype != #"armor") {
                if (isdefined(item) && isdefined(item.var_a6762160)) {
                    function_1a46c8ae(self, undefined, undefined, item.var_a6762160, item.var_a6762160.amount);
                }
            }
            consume_item(item);
            return 1;
        } else if (var_77e61fc6 < var_8cd447d8 && !isentity(item) && item.var_a6762160.itemtype != #"ammo") {
            stashitem = item_world_util::function_83c20f83(item);
            stashitem &= ~(isdefined(item.deathstash) ? item.deathstash : 0);
            dropitem = self item_drop::function_fd9026e4(0, item.var_a6762160.weapon, var_77e61fc6, item.amount, item.id, item.origin, item.angles, 0, stashitem, undefined, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname, undefined, undefined, 0);
            if (isdefined(dropitem)) {
                dropitem.origin = item.origin;
                dropitem.angles = item.angles;
                consume_item(item);
            }
            return 1;
        }
    }
    return 0;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x1 linked
// Checksum 0x91f52213, Offset: 0x6358
// Size: 0x146
function function_8e0d14c1(var_4b0875ec = 0) {
    assert(isplayer(self));
    usetrigger = self.var_19caeeea;
    if (!isdefined(usetrigger)) {
        return false;
    }
    if (!isdefined(usetrigger.itemstruct)) {
        return false;
    }
    if (var_4b0875ec && item_world_util::function_83c20f83(usetrigger.itemstruct)) {
        return false;
    }
    origin = self getplayercamerapos();
    if (distance2dsquared(usetrigger.itemstruct.origin, origin) > function_a3f6cdac(128)) {
        return false;
    }
    if (abs(usetrigger.itemstruct.origin[2] - origin[2]) > 128) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 5, eflags: 0x1 linked
// Checksum 0xe1555523, Offset: 0x64a8
// Size: 0x22c
function function_1a46c8ae(player, var_a1ca235e, var_3d1f9df4, var_7089b458, var_381f3b39) {
    if (game.state == "pregame" || !isdefined(var_a1ca235e) && !isdefined(var_7089b458)) {
        return;
    }
    data = {#game_time:function_f8d53445(), #player_xuid:isdefined(player) ? int(player getxuid(1)) : 0, #dropped_item:isdefined(var_a1ca235e) ? hash(var_a1ca235e.name) : 0, #var_5b8ff5e9:isdefined(var_3d1f9df4) ? var_3d1f9df4 : 0, #var_6789038:isdefined(var_7089b458) ? hash(var_7089b458.name) : 0, #var_d1f97c0f:isdefined(var_381f3b39) ? var_381f3b39 : 0};
    /#
        if (isdefined(var_a1ca235e)) {
            println("<dev string:xd9>" + var_a1ca235e.name + "<dev string:xe6>" + (isdefined(var_3d1f9df4) ? var_3d1f9df4 : 0));
        }
        if (isdefined(var_7089b458)) {
            println("<dev string:xeb>" + var_7089b458.name + "<dev string:xe6>" + (isdefined(var_381f3b39) ? var_381f3b39 : 0));
        }
    #/
    function_92d1707f(#"hash_1ed3b4af49015043", data);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x1 linked
// Checksum 0xdc6b484c, Offset: 0x66e0
// Size: 0x4d8
function function_83ddce0f(item, inventoryslot) {
    var_a1ca235e = undefined;
    var_3d1f9df4 = 0;
    var_8acbe1d0 = self function_6105623a(item) || item.var_a6762160.itemtype == #"armor_shard" || item.var_a6762160.itemtype == #"resource" || item.var_a6762160.itemtype == #"ammo" || item.var_a6762160.itemtype == #"backpack" && !self item_inventory::has_backpack() || item.var_a6762160.var_4a1a4613 == #"armor_heal";
    stashitem = item_world_util::function_83c20f83(item);
    deathstashitem = isdefined(item.deathstash) ? item.deathstash : 0;
    stashitem &= ~deathstashitem;
    dropitem = undefined;
    if (!var_8acbe1d0 && self item_inventory::has_inventory_item(inventoryslot)) {
        var_69944179 = self.inventory.items[inventoryslot];
        var_a1ca235e = var_69944179.var_a6762160;
        var_3d1f9df4 = var_a1ca235e.amount;
        dropitem = self item_inventory::drop_inventory_item(var_69944179.networkid, 0, item.origin, undefined, 0);
        if (!isdefined(dropitem)) {
            return false;
        }
        waitframe(1);
    }
    if (isdefined(item) && !isentity(item) && isdefined(item.id)) {
        item = function_b1702735(item.id);
    }
    if (!isdefined(item) || !item_world_util::can_pick_up(item)) {
        if (isdefined(dropitem) && isdefined(item) && isdefined(item.var_a6762160) && item.var_a6762160.itemtype == #"backpack") {
            item_inventory::function_ec238da8();
        }
        return false;
    }
    var_77e61fc6 = function_de2018e3(item, self, inventoryslot);
    if (var_77e61fc6 == 0) {
        if (isdefined(item) && isdefined(item.var_a6762160)) {
            function_1a46c8ae(self, var_a1ca235e, var_3d1f9df4, item.var_a6762160, item.var_a6762160.amount);
            if (item.var_a6762160.itemtype == #"backpack") {
                item_inventory::function_ec238da8();
            }
        }
        consume_item(item);
    } else if (!isentity(item) && item.var_a6762160.itemtype != #"ammo") {
        dropitem = self item_drop::function_fd9026e4(0, item.var_a6762160.weapon, item.count, item.amount, item.id, item.origin, item.angles, 2, 0, undefined, isdefined(item.targetnamehash) ? item.targetnamehash : item.targetname, undefined, undefined, 0);
        if (isdefined(dropitem)) {
            dropitem.origin = item.origin;
            dropitem.angles = item.angles;
            consume_item(item);
        }
    }
    return true;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x57d4b8c0, Offset: 0x6bc0
// Size: 0x1ec
function function_8eee98dd(supplystash) {
    level flag::wait_till(#"hash_507a4486c4a79f1d");
    function_4de3ca98();
    assert(isdefined(supplystash));
    if (!isdefined(supplystash) || !isdefined(supplystash.targetname)) {
        return;
    }
    targetname = isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target;
    var_76c7cb8a = function_91b29d2a(targetname);
    foreach (item in var_76c7cb8a) {
        if (!isdefined(item.var_a6762160)) {
            continue;
        }
        if (distancesquared(item.origin, supplystash.origin) > 36) {
            continue;
        }
        function_54ca5536(item.id, -1);
        resetitem = level flag::get(#"item_world_reset");
        function_bfc28859(3, item.id, resetitem);
    }
    function_e2a06860(supplystash, 0);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x1fddbcaa, Offset: 0x6db8
// Size: 0x314
function function_160294c7(supplystash) {
    level flag::wait_till(#"hash_507a4486c4a79f1d");
    function_4de3ca98();
    assert(isdefined(supplystash));
    if (!isdefined(supplystash) || !isdefined(supplystash.targetname)) {
        return;
    }
    targetname = isdefined(supplystash.targetname) ? supplystash.targetname : supplystash.target;
    var_76c7cb8a = function_91b29d2a(targetname);
    foreach (item in var_76c7cb8a) {
        if (distancesquared(item.origin, supplystash.origin) > 36) {
            continue;
        }
        if (item_world_util::can_pick_up(item)) {
            consume_item(item);
        }
    }
    consumeitems = [];
    foreach (item in level.item_spawn_drops) {
        if (!isdefined(item)) {
            continue;
        }
        var_45602f41 = isdefined(item.targetname) ? item.targetname : item.targetnamehash;
        if (!isdefined(var_45602f41)) {
            continue;
        }
        if (var_45602f41 == targetname) {
            if (item_world_util::can_pick_up(item)) {
                consumeitems[consumeitems.size] = item;
            }
        }
    }
    foreach (item in consumeitems) {
        if (isdefined(item)) {
            consume_item(item);
        }
    }
    function_e2a06860(supplystash, 3);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x1 linked
// Checksum 0xb059649, Offset: 0x70d8
// Size: 0xee
function reset_item_world() {
    level.var_703d32de = 0;
    level.var_ab396c31 = 1;
    util::wait_network_frame(1);
    assert(level.var_703d32de == 0);
    if (isdefined(level.var_b398b662)) {
        [[ level.var_b398b662 ]]();
    }
    assert(level.var_703d32de == 0);
    function_f7fb8a17(1);
    util::wait_network_frame(1);
    assert(level.var_703d32de == 0);
    level.var_ab396c31 = undefined;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x5b79daba, Offset: 0x71d0
// Size: 0x5c
function function_cbc32e1b(milliseconds) {
    assert(isint(milliseconds));
    if (isint(milliseconds)) {
        level.var_75dc9c49 = milliseconds;
    }
}

// Namespace item_world/item_world
// Params 0, eflags: 0x1 linked
// Checksum 0xb82d5885, Offset: 0x7238
// Size: 0x8a
function function_1b11e73c() {
    reset = isdefined(level flag::get(#"item_world_reset"));
    level flag::wait_till(#"item_world_initialized");
    if (reset != isdefined(level flag::get(#"item_world_reset"))) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x1 linked
// Checksum 0x29ce654f, Offset: 0x72d0
// Size: 0x7c
function function_4de3ca98() {
    level flag::wait_till(#"item_world_initialized");
    level flag::wait_till(#"item_world_reset");
    while (is_true(level.var_ab396c31)) {
        waitframe(1);
    }
    util::wait_network_frame(1);
}

