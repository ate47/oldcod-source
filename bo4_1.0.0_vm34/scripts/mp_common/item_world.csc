#using script_68c78107b4aa059c;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\mp_common\item_inventory;
#using scripts\mp_common\item_spawn_groups;
#using scripts\mp_common\item_world_util;

#namespace item_world;

// Namespace item_world/item_world
// Params 0, eflags: 0x2
// Checksum 0xaf09823b, Offset: 0x1b0
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"item_world", &__init__, undefined, undefined);
}

// Namespace item_world/item_world
// Params 0, eflags: 0x4
// Checksum 0xfc908545, Offset: 0x1f8
// Size: 0x1d4
function private __init__() {
    if (getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    callback::on_localclient_connect(&_on_localclient_connect);
    callback::on_localplayer_spawned(&_on_localplayer_spawned);
    callback::function_948e38c4(&function_491c7ccd);
    clientfield::register("world", "item_world_seed", 1, 31, "int", &function_d9e13e7f, 1, 0);
    clientfield::register("world", "item_world_disable", 1, 1, "int", &function_121cb104, 0, 0);
    level.var_d7458be9 = &function_a7baa168;
    level.var_7419c002 = &function_1b3f7eb5;
    level.var_b0afee79 = [];
    level.var_d90a0af8 = 0;
    if (!isdefined(level.item_spawn_stashes)) {
        level.item_spawn_stashes = [];
    }
    if (!isdefined(level.item_spawn_drops)) {
        level.item_spawn_drops = [];
    }
    if (!isdefined(level.var_1b022657)) {
        level.var_1b022657 = [];
    }
    level thread namespace_f68e9756::init_spawn_system();
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x93b01632, Offset: 0x3d8
// Size: 0xf8
function private function_e13ba1ec(localclientnum, poolsize) {
    modellist = [];
    for (i = 1; i <= poolsize; i++) {
        model = spawn(localclientnum, (0, 0, -10000), "script_model");
        model function_22e78dc6(undefined, #"tag_origin", 1);
        model hide();
        model notsolid();
        modellist[i * -1] = model;
    }
    return modellist;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x410630b5, Offset: 0x4d8
// Size: 0x140
function private function_22620095(var_61348f58) {
    level endon(#"game_ended");
    level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
    if (var_61348f58[var_61348f58.size - 1] == 1) {
        level flagsys::wait_till(#"item_world_reset");
    }
    level flagsys::wait_till(#"item_world_initialized");
    for (wordindex = 0; wordindex < var_61348f58.size - 1; wordindex++) {
        for (bitindex = 0; bitindex < 32; bitindex++) {
            if (var_61348f58[wordindex] & 1 << bitindex) {
                itemindex = wordindex * 32 + bitindex;
                hide_item(itemindex);
            }
        }
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0x54f43ad7, Offset: 0x620
// Size: 0xa6
function private function_8202fa7e(localclientnum, item) {
    assert(self isplayer());
    if (item.hidetime > 0 && item.hidetime != -1) {
        return false;
    }
    if (!isstruct(item) && item getitemindex() == 32767) {
        return false;
    }
    return true;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xd543ec13, Offset: 0x6d0
// Size: 0x296
function private function_5395716e(localclientnum) {
    data = spawnstruct();
    data.modellist = function_e13ba1ec(localclientnum, 200);
    data.var_aefcb2a4 = 0;
    data.var_52e1940d = -1;
    data.var_f61e3fa1 = 0;
    level.var_b0afee79[localclientnum] = data;
    item_inventory::inventory_init(localclientnum);
    level.var_6bdbba09 = util::getnextobjid(localclientnum);
    objective_add(localclientnum, level.var_6bdbba09, "invisible", #"weapon_pickup");
    level.var_5b010eb4 = util::getnextobjid(localclientnum);
    objective_add(localclientnum, level.var_5b010eb4, "invisible", #"multi_item_pickup");
    level.showpickuphintmodel = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.showPickupHint");
    level.var_e57e5f70 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.pickupHintText");
    level.var_31af6812 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.pickupHintImage");
    level.var_78c145a9 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.weapon3dHintState");
    level.var_f96a34a0 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.weapon3dForcedHintItem");
    level.var_99f8d100 = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.pickupHintImage");
}

/#

    // Namespace item_world/item_world
    // Params 0, eflags: 0x4
    // Checksum 0x283aaec3, Offset: 0x970
    // Size: 0x164
    function private function_8956d025() {
        self endon(#"shutdown", #"death");
        while (true) {
            waitframe(1);
            if (getdvarint(#"hash_3fdd3b60f349d462", 0)) {
                if (isdefined(self)) {
                    origin = self.origin;
                    var_2cd4142c = function_33d2057a(origin, undefined, 100, 2000);
                    foreach (item in var_2cd4142c) {
                        print3d(item.origin, "<dev string:x30>" + item.networkid + "<dev string:x33>" + item.itementry.name, (0, 0, 1), 1, 0.4);
                    }
                }
            }
        }
    }

#/

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xcd4cc832, Offset: 0xae0
// Size: 0x4e
function private function_dd876415(model) {
    if (!isdefined(model)) {
        return;
    }
    if (isdefined(model.var_f4acc9c0)) {
        model function_c20b6c81(model.var_f4acc9c0);
    }
    model.var_f4acc9c0 = undefined;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x6612be7a, Offset: 0xb38
// Size: 0x29a
function private function_f963238a(localclientnum, model, itementry) {
    if (!isdefined(model)) {
        return;
    }
    renderbundle = #"hash_29dbf9ddda64fc5a";
    if (isdefined(itementry)) {
        switch (itementry.rarity) {
        case #"none":
        case #"common":
            renderbundle = #"hash_29dbf9ddda64fc5a";
            break;
        case #"rare":
            renderbundle = #"hash_6e89d52c60dd7fc3";
            break;
        case #"epic":
            renderbundle = #"hash_4cf701d23a7301d2";
            break;
        case #"legendary":
            renderbundle = #"hash_4368c406e6a21060";
            break;
        }
    } else if (isdefined(model.var_5adbea02)) {
        if (model.var_5adbea02 == 2) {
            function_dd876415(model);
            return;
        }
    } else {
        state = function_7f51b166(model);
        if (state == 2) {
            function_dd876415(model);
            return;
        }
    }
    player = function_f97e7787(localclientnum);
    if (isdefined(player) && isdefined(renderbundle) && player hasperk(localclientnum, #"specialty_looter")) {
        renderbundle += "_looter";
    }
    if (isdefined(model.var_f4acc9c0) && model.var_f4acc9c0 !== renderbundle) {
        model function_c20b6c81(model.var_f4acc9c0);
    }
    if (isdefined(renderbundle)) {
        if (!model function_40a6c199(renderbundle)) {
            model playrenderoverridebundle(renderbundle);
        }
    }
    model.var_f4acc9c0 = renderbundle;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0xfc6be411, Offset: 0xde0
// Size: 0xaa6
function private _draw(localclientnum, draworigin) {
    clientdata = function_72b37ae5(localclientnum);
    servertime = getservertime(0);
    clientdata.var_52e1940d = level.var_d90a0af8;
    clientdata.var_f61e3fa1 = servertime;
    clientdata.drawing = 1;
    maxdist = getdvarfloat(#"hash_2cd1a08f81049564", 3500);
    var_2cd4142c = function_f89bdb99(draworigin, undefined, 200, maxdist, -1, 1, servertime);
    waitframe(1);
    var_908ee38b = clientdata.modellist;
    var_83c6cd1c = [];
    var_2f1af845 = [];
    index = 0;
    assert(var_908ee38b.size == 200);
    for (index = 0; index < var_2cd4142c.size; index++) {
        item = var_2cd4142c[index];
        id = item.id;
        if (isdefined(var_908ee38b[id])) {
            model = var_908ee38b[id];
            var_83c6cd1c[id] = model;
            var_908ee38b[id] = undefined;
        } else {
            var_2f1af845[var_2f1af845.size] = item;
        }
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
    }
    waitframe(1);
    arrayremovevalue(var_908ee38b, undefined, 0);
    waitframe(1);
    assert(var_908ee38b.size + var_83c6cd1c.size == 200);
    for (index = 0; index < var_2f1af845.size; index++) {
        item = var_2f1af845[index];
        model = var_908ee38b[index];
        model.origin = item.origin;
        model.angles = item.angles;
        model function_22e78dc6(item, function_1b4c206c(item), item.itementry.modelscale);
        model show();
        var_83c6cd1c[item.id] = model;
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
    }
    waitframe(1);
    while (index < var_908ee38b.size) {
        model = var_908ee38b[index];
        model hide();
        function_dd876415(model);
        var_83c6cd1c[index * -1 - 1] = model;
        if ((index + 1) % 50 == 0) {
            waitframe(1);
        }
        index++;
    }
    waitframe(1);
    assert(var_83c6cd1c.size == 200);
    clientdata.modellist = var_83c6cd1c;
    if (getdvarint(#"hash_220f360a2cc8359a", 1)) {
        var_a2795dbd = arraysortclosest(level.item_spawn_drops, draworigin, undefined, maxdist);
        foreach (item in var_a2795dbd) {
            function_dd876415(item);
        }
        waitframe(1);
        var_4183f660 = arraysortclosest(level.item_spawn_stashes, draworigin, undefined, maxdist);
        foreach (supplystash in var_4183f660) {
            function_dd876415(supplystash);
        }
        waitframe(1);
        var_703bafd9 = arraysortclosest(level.var_1b022657, draworigin, undefined, maxdist);
        foreach (deathstash in var_703bafd9) {
            function_dd876415(deathstash);
        }
        waitframe(1);
        var_ec57a7a1 = arraysortclosest(level.item_spawn_drops, draworigin, 100, 0, maxdist);
        waitframe(1);
        var_e2fa8008 = arraysortclosest(level.item_spawn_stashes, draworigin, 100, 0, maxdist);
        waitframe(1);
        var_5fec5c25 = arraysortclosest(level.var_1b022657, draworigin, 100, 0, maxdist);
        waitframe(1);
        var_2cd4142c = arraycombine(var_2cd4142c, var_ec57a7a1, 1, 0);
        waitframe(1);
        var_2cd4142c = arraycombine(var_2cd4142c, var_e2fa8008, 1, 0);
        waitframe(1);
        var_2cd4142c = arraycombine(var_2cd4142c, var_5fec5c25, 1, 0);
        waitframe(1);
        var_2cd4142c = arraysortclosest(var_2cd4142c, draworigin, 200 + var_ec57a7a1.size, 0, maxdist);
        waitframe(1);
        if (isdefined(self.var_d3f13eb8) && self.var_d3f13eb8) {
            for (index = 0; index < var_2cd4142c.size; index++) {
                item = var_2cd4142c[index];
                if (!isdefined(item)) {
                    continue;
                }
                model = isdefined(item.id) ? clientdata.modellist[item.id] : undefined;
                if (isdefined(model)) {
                    function_dd876415(model);
                } else {
                    function_dd876415(item);
                }
                if ((index + 1) % 50 == 0) {
                    waitframe(1);
                }
            }
            self.var_d3f13eb8 = undefined;
        }
        waitframe(1);
        for (index = int(min(100, var_2cd4142c.size)); index < 200 && index < var_2cd4142c.size; index++) {
            item = var_2cd4142c[index];
            if (!isdefined(item)) {
                continue;
            }
            model = isdefined(item.id) ? clientdata.modellist[item.id] : undefined;
            if (isdefined(model)) {
                function_dd876415(model);
            } else {
                function_dd876415(item);
            }
            if ((index + 1) % 50 == 0) {
                waitframe(1);
            }
        }
        waitframe(1);
        for (index = 0; index < 100 && index < var_2cd4142c.size; index++) {
            item = var_2cd4142c[index];
            if (!isdefined(item)) {
                continue;
            }
            model = isdefined(item.id) ? clientdata.modellist[item.id] : undefined;
            if (!isdefined(model)) {
                function_f963238a(localclientnum, item, item.itementry);
            } else {
                function_f963238a(localclientnum, model, item.itementry);
            }
            if ((index + 1) % 50 == 0) {
                waitframe(1);
            }
        }
    }
    clientdata.var_99eb0475 = draworigin;
    clientdata.var_2cd4142c = var_2cd4142c;
    clientdata.var_aefcb2a4 = var_2cd4142c.size;
    clientdata.drawing = undefined;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x1bf9ecc8, Offset: 0x1890
// Size: 0x190
function private function_1b4c206c(point) {
    if (!isdefined(level.var_fa0a1c01)) {
        level.var_fa0a1c01 = [];
    }
    if (!isdefined(level.var_fa0a1c01[point.itementry.name])) {
        if (isdefined(point.itementry.model) && point.itementry.model != "") {
            level.var_fa0a1c01[point.itementry.name] = point.itementry.model;
        } else if (isdefined(point.itementry.weapon) && point.itementry.weapon !== level.weaponnone) {
            level.var_fa0a1c01[point.itementry.name] = point.itementry.weapon.worldmodel;
        } else {
            level.var_fa0a1c01[point.itementry.name] = "tag_origin";
        }
    }
    return level.var_fa0a1c01[point.itementry.name];
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x867a61ca, Offset: 0x1a28
// Size: 0x22
function private function_116962ae(localclientnum) {
    return getcamposbylocalclientnum(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x69ec7415, Offset: 0x1a58
// Size: 0x24
function private function_1b3f7eb5(var_61348f58) {
    level thread function_22620095(var_61348f58);
}

// Namespace item_world/item_world
// Params 5, eflags: 0x4
// Checksum 0x2662ddc7, Offset: 0x1a88
// Size: 0x5da
function private function_a7baa168(localclientnum, eventtype, eventdata, var_d4bc02d7, var_aeb9886e) {
    reset = isdefined(level flagsys::get(#"item_world_reset"));
    level flagsys::wait_till(#"item_world_initialized");
    if (reset != isdefined(level flagsys::get(#"item_world_reset"))) {
        return;
    }
    if (!isdefined(level.var_b0afee79[localclientnum])) {
        return;
    }
    switch (eventtype) {
    case 1:
        if (level flagsys::get(#"item_world_reset")) {
            return;
        }
        networkid = eventdata;
        hide_item(networkid);
        function_2cfb602b(localclientnum);
        item = function_9c3c6ff2(networkid);
        item_inventory::function_f5a659d4(localclientnum, item);
        break;
    case 9:
        level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
        level flagsys::wait_till(#"item_world_reset");
        level flagsys::wait_till(#"item_world_initialized");
        networkid = eventdata;
        hide_item(networkid);
        function_2cfb602b(localclientnum);
        item = function_9c3c6ff2(networkid);
        item_inventory::function_f5a659d4(localclientnum, item);
        break;
    case 2:
        itemid = eventdata;
        count = var_d4bc02d7;
        slotid = var_aeb9886e ? var_aeb9886e - 1 : undefined;
        item_inventory::function_834a9503(localclientnum, itemid, count, slotid);
        function_2cfb602b(localclientnum);
        break;
    case 10:
        networkid = eventdata;
        item_inventory::consume_item(localclientnum, networkid);
        break;
    case 3:
        networkid = eventdata;
        item_inventory::function_7800f1d1(localclientnum, networkid);
        function_2cfb602b(localclientnum);
        break;
    case 4:
        networkid = eventdata;
        item_inventory::function_637c4d2f(localclientnum, networkid);
        function_2cfb602b(localclientnum);
        break;
    case 11:
        var_69bdab26 = eventdata;
        var_631e6a29 = var_d4bc02d7;
        item_inventory::function_8882634(localclientnum, var_69bdab26, var_631e6a29);
        break;
    case 5:
        networkid = eventdata;
        item_inventory::function_a6b76462(localclientnum, networkid);
        break;
    case 6:
        networkid = eventdata;
        if (item_world_util::function_a04a2a1f(networkid)) {
            itemid = networkid;
            point = function_9c3c6ff2(itemid);
            item_inventory::function_b01e420f(localclientnum, point.itementry);
            if (point.itementry.itemtype == #"ammo") {
                item_inventory::function_f4f08c1c(localclientnum, itemid);
            }
        }
        function_2cfb602b(localclientnum);
        break;
    case 7:
        networkid = eventdata;
        count = var_d4bc02d7;
        item_inventory::update_inventory_item(localclientnum, networkid, count);
        function_2cfb602b(localclientnum);
        break;
    case 8:
        item_inventory::inventory_init(localclientnum);
        break;
    default:
        assertmsg("<dev string:x35>" + eventtype);
        break;
    }
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xd0e6e7c8, Offset: 0x2070
// Size: 0xd8
function private function_121cb104(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level flagsys::wait_till(#"item_world_initialized");
    foreach (supply_stash in level.item_spawn_stashes) {
        setdynentenabled(supply_stash, !newval);
    }
}

// Namespace item_world/item_world
// Params 7, eflags: 0x4
// Checksum 0xb70d0c7, Offset: 0x2150
// Size: 0x2e4
function private function_d9e13e7f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level flagsys::wait_till_clear(#"hash_2d3b2a4d082ba5ee");
        level flagsys::set(#"hash_2d3b2a4d082ba5ee");
        if (level flagsys::get(#"item_world_reset")) {
            return;
        }
        seed = newval >> 1;
        reset = newval & 1;
        if (reset) {
            level flagsys::set(#"item_world_reset");
        }
        setdvar(#"hash_21e070fbb56cf0f", 0);
        level.var_d90a0af8 = 0;
        level flagsys::clear(#"item_world_initialized");
        level item_inventory::inventory_init(localclientnum);
        clientdata = function_72b37ae5(localclientnum);
        if (isdefined(clientdata) && isdefined(clientdata.modellist)) {
            models = [];
            foreach (model in clientdata.modellist) {
                model notsolid();
                model hide();
                function_dd876415(model);
                models[models.size * -1 - 1] = model;
            }
            clientdata.modellist = models;
        }
        level item_spawn_group::setup(localclientnum, seed, reset);
        level flagsys::set(#"item_world_initialized");
        level flagsys::clear(#"hash_2d3b2a4d082ba5ee");
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x62ef6ff5, Offset: 0x2440
// Size: 0x24
function private _on_localclient_connect(localclientnum) {
    function_5395716e(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xa71b5485, Offset: 0x2470
// Size: 0xe4
function private _on_localplayer_spawned(localclientnum) {
    /#
        self thread function_8956d025();
    #/
    if (self function_60dbc438()) {
        characterindex = self getselectedcharacterindex();
        clientdata = function_72b37ae5(localclientnum);
        clientdata.specialist = function_4a9245b(characterindex, currentsessionmode());
        self thread _update_loop(localclientnum);
        level callback::function_c2d859ed(&item_inventory::function_c2d859ed);
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xc4f86b0, Offset: 0x2560
// Size: 0x92
function private function_491c7ccd(localclientnum) {
    if (self function_40efd9db()) {
        var_3c7e3100 = self hasperk(localclientnum, #"specialty_looter");
        var_ae5f668e = self.var_3c7e3100 !== var_3c7e3100;
        if (var_ae5f668e) {
            self.var_d3f13eb8 = 1;
        }
        self.var_3c7e3100 = var_3c7e3100;
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xd191c3b8, Offset: 0x2600
// Size: 0x110
function private _set_weapon(item) {
    if (isdefined(item) && isdefined(item.itementry.weapon) && !isdefined(item.itementry.model) && isdefined(item.itementry.weapon.worldmodel)) {
        weapon = item_world_util::function_fe2abb62(item.itementry);
        self useweaponmodel(weapon);
        self useweaponhidetags(weapon);
        return 1;
    }
    self detachall();
    self useweaponmodel(level.weaponnone, "tag_origin");
    return 0;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x414b7898, Offset: 0x2718
// Size: 0xcc
function private function_22e78dc6(item, newmodel, scale) {
    if (newmodel === self.model) {
        if (!isdefined(item) && self.weapon == level.weaponnone) {
            return;
        }
    }
    function_dd876415(self);
    if (!self _set_weapon(item) || isdefined(item.itementry.model)) {
        self setmodel(newmodel);
    }
    self setscale(scale);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x1ec00afd, Offset: 0x27f0
// Size: 0x140
function private function_1e06f88a(localclientnum) {
    clientdata = function_72b37ae5(localclientnum);
    if (isdefined(clientdata.drawing) && clientdata.drawing) {
        return false;
    }
    if (!isdefined(clientdata.var_99eb0475)) {
        return true;
    }
    if (clientdata.var_52e1940d != level.var_d90a0af8) {
        return true;
    }
    servertime = getservertime(0);
    if (servertime < clientdata.var_f61e3fa1) {
        return true;
    }
    var_968ff9d5 = function_116962ae(localclientnum);
    var_17b4fd7f = distancesquared(clientdata.var_99eb0475, var_968ff9d5);
    if (var_17b4fd7f >= 72 * 72) {
        return true;
    }
    if (isdefined(self.var_d3f13eb8) && self.var_d3f13eb8) {
        return true;
    }
    return false;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x2c4d5311, Offset: 0x2938
// Size: 0x76
function private function_264944d9(localclientnum, eyepos, angles) {
    clientdata = function_72b37ae5(localclientnum);
    if (isdefined(clientdata.var_aba7ed44) && clientdata.var_aba7ed44) {
        clientdata.var_aba7ed44 = 0;
        return true;
    }
    return false;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0xbbff7ec5, Offset: 0x29b8
// Size: 0x830
function private function_a96cf359(items) {
    if (items.size <= 1) {
        return items;
    }
    sorted = [];
    itemtypes = [];
    for (index = 0; index < items.size; index++) {
        itementry = items[index].itementry;
        if (!isdefined(itemtypes[itementry.itemtype])) {
            itemtypes[itementry.itemtype] = [];
        }
        size = itemtypes[itementry.itemtype].size;
        itemtypes[itementry.itemtype][size] = items[index];
    }
    if (isdefined(itemtypes[#"quest"])) {
        foreach (entry in itemtypes[#"quest"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"backpack"])) {
        foreach (entry in itemtypes[#"backpack"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"weapon"])) {
        foreach (item in itemtypes[#"weapon"]) {
            if (item.itementry.rarity == #"epic") {
                sorted[sorted.size] = item;
            }
        }
    }
    if (isdefined(itemtypes[#"armor"])) {
        foreach (entry in itemtypes[#"armor"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"weapon"])) {
        foreach (item in itemtypes[#"weapon"]) {
            if (item.itementry.rarity != #"epic") {
                sorted[sorted.size] = item;
            }
        }
    }
    if (isdefined(itemtypes[#"health"])) {
        foreach (entry in itemtypes[#"health"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"killstreak"])) {
        foreach (entry in itemtypes[#"killstreak"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"attachment"])) {
        foreach (entry in itemtypes[#"attachment"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"equipment"])) {
        foreach (entry in itemtypes[#"equipment"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"generic"])) {
        foreach (entry in itemtypes[#"generic"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"ammo"])) {
        foreach (entry in itemtypes[#"ammo"]) {
            sorted[sorted.size] = entry;
        }
    }
    if (isdefined(itemtypes[#"resource"])) {
        foreach (entry in itemtypes[#"resource"]) {
            sorted[sorted.size] = entry;
        }
    }
    assert(sorted.size > 0);
    return sorted;
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0x54deedcb, Offset: 0x31f0
// Size: 0x84
function private function_9f9dfe25(localclientnum, objid, objorigin, objstate) {
    objective_setstate(localclientnum, objid, "active");
    objective_setposition(localclientnum, objid, objorigin);
    objective_setgamemodeflags(localclientnum, objid, objstate);
}

// Namespace item_world/item_world
// Params 2, eflags: 0x4
// Checksum 0xf216470a, Offset: 0x3280
// Size: 0x54
function private function_229b0d90(localclientnum, objid) {
    objective_setstate(localclientnum, objid, "invisible");
    objective_setgamemodeflags(localclientnum, objid, 0);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x4
// Checksum 0x6fd6bb0, Offset: 0x32e0
// Size: 0x5c6
function private _update_loop(localclientnum) {
    self endon(#"shutdown", #"death");
    self notify("5e6288cc40932e9");
    self endon("5e6288cc40932e9");
    var_40efd9db = self function_40efd9db();
    waitframe(1);
    while (true) {
        if (function_1e06f88a(localclientnum)) {
            draworigin = function_116962ae(localclientnum);
            self thread _draw(localclientnum, draworigin);
        }
        if (var_40efd9db) {
            eyepos = getlocalclienteyepos(localclientnum);
            angles = getlocalclientangles(localclientnum);
            self.var_4eb3acc5 = self.var_a582c9fe;
            self.var_a582c9fe = function_19ffc9c9(localclientnum, eyepos, angles);
            if (isdefined(self.var_a582c9fe) && isdefined(self.var_a582c9fe.itementry) && !isdefined(getplayervehicle(self))) {
                itementry = self.var_a582c9fe.itementry;
                var_e1af0d48 = 0;
                var_8ffc4b49 = undefined;
                if (itementry.itemtype == #"ammo" && !item_inventory::can_pickup_ammo(localclientnum, self.var_a582c9fe)) {
                    var_e1af0d48 = 4;
                } else if (item_inventory::function_62c0f1d9(localclientnum, itementry)) {
                    var_e1af0d48 = 1;
                    if (itementry.itemtype == #"attachment") {
                        var_e1af0d48 = 1;
                        if (item_inventory::function_ed433682(localclientnum, itementry)) {
                            var_e1af0d48 |= 32;
                        }
                    }
                } else if (itementry.itemtype == #"weapon") {
                    var_e1af0d48 = 2;
                } else {
                    var_8ffc4b49 = self item_inventory::function_2b4af13f(localclientnum, itementry);
                    if (isdefined(var_8ffc4b49)) {
                        var_e1af0d48 = 2;
                        if (itementry.itemtype == #"attachment") {
                            var_8ffc4b49 = undefined;
                            if (item_inventory::function_ed433682(localclientnum, itementry)) {
                                var_e1af0d48 |= 32;
                            }
                        }
                    } else if (!item_inventory::function_ed433682(localclientnum, itementry)) {
                        var_e1af0d48 = 4;
                    }
                }
                objstate = 0;
                if (isdefined(self.var_a582c9fe.isfar) && self.var_a582c9fe.isfar) {
                    objstate = 1;
                }
                pickupicon = isdefined(itementry.pickupicon) ? itementry.pickupicon : itementry.icon;
                setuimodelvalue(level.var_f96a34a0, isdefined(var_8ffc4b49) ? var_8ffc4b49 : -1);
                setuimodelvalue(level.var_78c145a9, var_e1af0d48);
                setuimodelvalue(level.var_99f8d100, isdefined(pickupicon) ? pickupicon : #"blacktransparent");
                if (self.var_a582c9fe.var_4d77b409) {
                    function_9f9dfe25(localclientnum, level.var_5b010eb4, self.var_a582c9fe.origin, objstate);
                    function_229b0d90(localclientnum, level.var_6bdbba09);
                } else {
                    function_9f9dfe25(localclientnum, level.var_6bdbba09, self.var_a582c9fe.origin, objstate);
                    function_229b0d90(localclientnum, level.var_5b010eb4);
                }
            } else {
                setuimodelvalue(level.var_99f8d100, #"blacktransparent");
                function_229b0d90(localclientnum, level.var_6bdbba09);
                function_229b0d90(localclientnum, level.var_5b010eb4);
            }
            if (self function_264944d9(localclientnum, eyepos, angles)) {
                self function_57f66d3a(localclientnum, eyepos, angles);
            }
        }
        waitframe(1);
    }
}

// Namespace item_world/item_world
// Params 4, eflags: 0x4
// Checksum 0x369e621c, Offset: 0x38b0
// Size: 0x356
function private function_19ffc9c9(localclientnum, origin, angles, maxdist = undefined) {
    assert(self isplayer());
    clientdata = function_72b37ae5(localclientnum);
    forward = vectornormalize(anglestoforward(angles));
    if (!isdefined(maxdist)) {
        maxdist = util::function_1a1c8e97();
    }
    var_2cd4142c = function_33d2057a(origin, forward, 100, maxdist, 0.57);
    var_a582c9fe = undefined;
    bestdot = undefined;
    traceoffset = (0, 0, 6);
    for (itemindex = 0; itemindex < var_2cd4142c.size; itemindex++) {
        itemdef = var_2cd4142c[itemindex];
        if (!self function_8202fa7e(localclientnum, itemdef)) {
            continue;
        }
        toitem = vectornormalize(itemdef.origin - origin);
        dot = vectordot(forward, toitem);
        if (dot < 0.57) {
            continue;
        }
        if (!isdefined(var_a582c9fe) || dot > bestdot) {
            var_4d77b409 = itemdef.hidetime === -1;
            if (!var_4d77b409 && itemdef.hidetime <= 0) {
                var_472f4c86 = bullettrace(origin, itemdef.origin + traceoffset, 0, self, 0);
                if (var_472f4c86[#"fraction"] < 1 && var_472f4c86[#"entity"] !== itemdef) {
                    continue;
                }
            }
            var_a582c9fe = itemdef;
            var_a582c9fe.var_4d77b409 = var_4d77b409;
            bestdot = dot;
        }
    }
    if (isdefined(var_a582c9fe)) {
        neardist = util::function_d27ced7f();
        if (neardist < maxdist && distancesquared(origin, var_a582c9fe.origin) > neardist * neardist) {
            var_a582c9fe.isfar = 1;
        }
    }
    return var_a582c9fe;
}

// Namespace item_world/item_world
// Params 3, eflags: 0x4
// Checksum 0x53d54410, Offset: 0x3c10
// Size: 0x174
function private function_57f66d3a(localclientnum, origin, angles) {
    assert(self isplayer());
    clientdata = function_72b37ae5(localclientnum);
    if (isdefined(self.var_a582c9fe)) {
        var_683a6fbe = 14;
        groupitems = function_33d2057a(self.var_a582c9fe.origin, undefined, 100, var_683a6fbe, undefined, 1);
        groupitems = function_a96cf359(groupitems);
        clientdata.groupitems = [];
        for (index = 0; index < groupitems.size; index++) {
            if (!self function_8202fa7e(localclientnum, groupitems[index])) {
                continue;
            }
            clientdata.groupitems[clientdata.groupitems.size] = groupitems[index];
        }
    } else {
        clientdata.groupitems = undefined;
    }
    self item_inventory::function_7a1ec24e(localclientnum);
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x92c652b8, Offset: 0x3d90
// Size: 0x1c
function function_72b37ae5(localclientnum) {
    return level.var_b0afee79[localclientnum];
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x6500fc0d, Offset: 0x3db8
// Size: 0xc8
function function_d6c5d0a2(itemgroup, networkid) {
    assert(isarray(itemgroup));
    assert(isint(networkid));
    for (index = 0; index < itemgroup.size; index++) {
        item = itemgroup[index];
        if (isdefined(item) && item.networkid === networkid) {
            return index;
        }
    }
    return undefined;
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0xc6d73c04, Offset: 0x3e88
// Size: 0xcc
function function_c6594b00(localclientnum, model) {
    assert(isdefined(model));
    draworigin = function_116962ae(localclientnum);
    maxdist = getdvarfloat(#"hash_2cd1a08f81049564", 3500);
    if (distancesquared(draworigin, model.origin) <= maxdist * maxdist) {
        function_f963238a(localclientnum, model, model.itementry);
    }
}

// Namespace item_world/item_world
// Params 2, eflags: 0x0
// Checksum 0x5aa5a9df, Offset: 0x3f60
// Size: 0xb0
function function_3f8df821(localclientnum, networkid) {
    if (item_world_util::function_9628594b(networkid)) {
        if (item_world_util::function_a04a2a1f(networkid)) {
            return networkid;
        } else if (item_world_util::function_2dd7d7a4(networkid)) {
            if (isdefined(level.item_spawn_drops[networkid])) {
                return level.item_spawn_drops[networkid].id;
            }
        } else {
            return item_inventory::function_2f6c4f55(localclientnum, networkid);
        }
    }
    return 32767;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0xce3f4630, Offset: 0x4018
// Size: 0x82
function get_item_name(item) {
    if (isdefined(item.weapon)) {
        if (item.weapon.displayname != #"") {
            return item.weapon.displayname;
        }
    }
    return isdefined(item.displayname) ? item.displayname : #"";
}

// Namespace item_world/item_world
// Params 6, eflags: 0x0
// Checksum 0xe6c28da2, Offset: 0x40a8
// Size: 0x17a
function function_33d2057a(origin, dir, maxitems, maxdistance, dot, var_e8ce772e = 0) {
    var_2cd4142c = function_f89bdb99(origin, dir, maxitems, maxdistance, dot, 1, -2147483647);
    var_ec57a7a1 = arraysortclosest(level.item_spawn_drops, origin, maxitems, 0, maxdistance);
    var_2cd4142c = arraycombine(var_2cd4142c, var_ec57a7a1, 1, 0);
    var_2cd4142c = arraysortclosest(var_2cd4142c, origin, maxitems, 0, maxdistance);
    if (var_e8ce772e) {
        stashitems = [];
        for (index = 0; index < var_2cd4142c.size; index++) {
            if (var_2cd4142c[index].hidetime === -1) {
                stashitems[stashitems.size] = var_2cd4142c[index];
            }
        }
        var_2cd4142c = stashitems;
    }
    return var_2cd4142c;
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x88404952, Offset: 0x4230
// Size: 0x60
function hide_item(networkid) {
    if (item_world_util::function_a04a2a1f(networkid)) {
        function_98497bc7(networkid, getservertime(0, 1));
        level.var_d90a0af8++;
    }
}

// Namespace item_world/item_world
// Params 1, eflags: 0x0
// Checksum 0x14469125, Offset: 0x4298
// Size: 0x3e
function function_2cfb602b(localclientnum) {
    clientdata = function_72b37ae5(localclientnum);
    clientdata.var_aba7ed44 = 1;
}

// Namespace item_world/item_world
// Params 0, eflags: 0x0
// Checksum 0xf94e9a97, Offset: 0x42e0
// Size: 0x8a
function function_61cbd38b() {
    reset = isdefined(level flagsys::get(#"item_world_reset"));
    level flagsys::wait_till(#"item_world_initialized");
    if (reset != isdefined(level flagsys::get(#"item_world_reset"))) {
        return false;
    }
    return true;
}

