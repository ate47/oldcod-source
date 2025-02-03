#using script_1caf36ff04a85ff6;
#using script_1f41849126bfc83d;
#using script_471b31bd963b388e;
#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_world;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;

#namespace item_inventory;

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x6
// Checksum 0x5c6c3a9a, Offset: 0x5c0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"item_inventory", &preinit, undefined, undefined, #"item_world");
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x3353f195, Offset: 0x610
// Size: 0x27c
function private preinit() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    if (function_7d5553ac()) {
        return;
    }
    clientfield::register_clientuimodel("hudItems.healthItemstackCount", 1, 8, "int", 0);
    clientfield::register_clientuimodel("hudItems.equipmentStackCount", 1, 8, "int", 0);
    level.var_67f4fd41 = &function_38d1ea04;
    level.var_dea62998 = &function_bdc03d88;
    level.var_cf16ff75 = &function_a2162b3b;
    level.var_6ec46eeb = &function_d85c5382;
    level.sensor_darts = [];
    level.var_c3a003ad = &function_ce3288cf;
    ability_player::register_gadget_activation_callbacks(23, &_gadget_health_regen_on, &_gadget_health_regen_off);
    ability_player::register_gadget_primed_callbacks(23, &function_d116a346);
    level.var_d3b4a4db = &function_64d3e50;
    level thread function_d2f05352();
    level.var_b398b662 = &function_f58e80e2;
    if (!isdefined(level.var_5c14d2e6)) {
        level.var_5c14d2e6 = &function_3f7ef88;
    }
    if (!isdefined(level.var_317fb13c)) {
        level.var_317fb13c = &function_3f7ef88;
    }
    if (!isdefined(level.var_4cf92425)) {
        level.var_4cf92425 = [];
    }
    callback::on_connect(&_on_player_connect);
    callback::on_spawned(&_on_player_spawned);
    callback::add_callback(#"hash_4a1cdf56005f9fb3", &function_7b39c6f9);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xd36153c3, Offset: 0x898
// Size: 0x1c
function private _on_player_connect() {
    self init_inventory();
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xf70d8b1a, Offset: 0x8c0
// Size: 0x3c
function private _on_player_spawned() {
    if (!isdefined(self.inventory)) {
        self init_inventory();
    }
    /#
        self thread function_76eb9bd7();
    #/
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xe276ffc2, Offset: 0x908
// Size: 0x6a
function function_7d5553ac() {
    return currentsessionmode() == 4 || (isdefined(getgametypesetting(#"hash_1cc3f98086d6f5dd")) ? getgametypesetting(#"hash_1cc3f98086d6f5dd") : 0);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x40069bc3, Offset: 0x980
// Size: 0x124
function function_64d3e50(var_b4d5813c) {
    if (!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items) || !isdefined(self.inventory.items[5])) {
        return;
    }
    networkid = self.inventory.items[5].networkid;
    if (isdefined(networkid) && networkid != 32767) {
        item = get_inventory_item(networkid);
        if (item.itementry.name == #"hash_6d9b83e07c57fb35") {
            if (var_b4d5813c) {
                self thread use_inventory_item(networkid, 1, 0);
            }
            return;
        }
        self thread use_inventory_item(networkid, 1, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xa49b9d8b, Offset: 0xab0
// Size: 0x124
function function_299d2131(maxhealth, healthamount, var_4465ef1e) {
    self endon(#"death");
    while (self.heal.enabled) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    self.var_44d52546 = 1;
    self player::function_9080887a(maxhealth);
    self.heal.var_bc840360 = math::clamp(healthamount + self.health, 0, maxhealth);
    self.heal.rate = healthamount / var_4465ef1e;
    self gadget_health_regen::function_ddfdddb1();
    self gadget_health_regen::function_1e02d458();
    self callback::function_d8abfc3d(#"done_healing", &function_4a257174);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xe3380ac4, Offset: 0xbe0
// Size: 0x5c
function function_4a257174() {
    if (isdefined(self)) {
        self callback::function_52ac9652(#"done_healing", &function_4a257174);
        self.var_44d52546 = undefined;
        gadget_health_regen::function_7993d50e();
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x84c9581f, Offset: 0xc48
// Size: 0x24a
function function_fc04b237(weapon, weaponoptions) {
    assert(isplayer(self));
    assert(isdefined(weapon));
    if (!isdefined(weaponoptions)) {
        return;
    }
    if (!isdefined(self.pers) || !isdefined(self.pers[#"activecamo"])) {
        return weaponoptions;
    }
    camoindex = getcamoindex(weaponoptions);
    activecamoname = getactivecamo(camoindex);
    if (!isdefined(activecamoname) || !isdefined(self.pers[#"activecamo"][activecamoname])) {
        return weaponoptions;
    }
    activecamo = self.pers[#"activecamo"][activecamoname];
    if (!isdefined(activecamo) || !isdefined(activecamo.var_dd54a13b)) {
        return weaponoptions;
    }
    var_28c04c49 = activecamo::function_c14cb514(weapon);
    weaponstate = activecamo.var_dd54a13b[var_28c04c49];
    if (!isdefined(weaponstate)) {
        return weaponoptions;
    }
    stagenum = weaponstate.stagenum;
    if (!isdefined(stagenum)) {
        return weaponoptions;
    }
    stage = activecamo.stages[stagenum];
    var_7df02232 = stage.var_19b6044e;
    if (!isdefined(var_7df02232)) {
        return weaponoptions;
    }
    buildkitweapon = activecamo::function_b259f3e0(weapon);
    weaponoptions = self getbuildkitweaponoptions(buildkitweapon, var_7df02232, stagenum);
    return weaponoptions;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x856dbc25, Offset: 0xea0
// Size: 0xb2
function private function_a2162b3b(deployableweapon) {
    if (isplayer(self)) {
        if (deployableweapon === self.var_cc111ddc) {
            self.var_cc111ddc = undefined;
        }
        if (deployableweapon === self.var_8181d952) {
            self.var_8181d952 = undefined;
        }
        if (deployableweapon === self.var_cd3bc45b) {
            self.var_cd3bc45b = undefined;
        }
        if (deployableweapon === self.var_d0015cb3) {
            self.var_d0015cb3 = undefined;
        }
        if (deployableweapon === self.var_14c391cc) {
            self.var_14c391cc = undefined;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x7331e4ed, Offset: 0xf60
// Size: 0x2e
function private function_d62822d5() {
    self.var_cc111ddc = undefined;
    self.var_8181d952 = undefined;
    self.var_cd3bc45b = undefined;
    self.var_d0015cb3 = undefined;
    self.var_14c391cc = undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x58bd107c, Offset: 0xf98
// Size: 0xf6
function private function_76646dad(weapon) {
    if (weapon.name == #"basketball" || weapon.name == #"cymbal_monkey" || weapon.name == #"hash_364914e1708cb629") {
        return true;
    }
    if (weapon.gadget_type != 0) {
        slot = self gadgetgetslot(weapon);
        return (slot == 0);
    }
    return weapon.inventorytype === "offhand" || weapon.inventorytype === "offhand_primary" || weapon.inventorytype === "ability";
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x1376a68a, Offset: 0x1098
// Size: 0x11c
function private function_e72d56f9(weapon, usecount) {
    assert(isdefined(weapon));
    if (isplayer(self) && isalive(self)) {
        self function_d62822d5();
        networkid = self function_a33744de(weapon);
        if (networkid != 32767) {
            self use_inventory_item(networkid, usecount, 0);
            item = self get_inventory_item(networkid);
            if (isdefined(item) && item.count > 0) {
                self function_c6be9f7f(weapon, item.count);
            }
        }
    }
}

// Namespace item_inventory/event_1294e3a7
// Params 1, eflags: 0x44
// Checksum 0x71dcb64, Offset: 0x11c0
// Size: 0x82
function private event_handler[event_1294e3a7] function_9e4c68e2(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    if (isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon)) {
        self.var_cd3bc45b = eventstruct.weapon;
    }
}

// Namespace item_inventory/event_eb7e11e4
// Params 1, eflags: 0x40
// Checksum 0x69a23a82, Offset: 0x1250
// Size: 0x82
function event_handler[event_eb7e11e4] function_2f677e9d(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    if (isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon)) {
        self.var_d0015cb3 = eventstruct.weapon;
    }
}

// Namespace item_inventory/grenade_fire
// Params 1, eflags: 0x44
// Checksum 0x4ba80a44, Offset: 0x12e0
// Size: 0x5a8
function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    if (isplayer(self) && isalive(self) && self function_76646dad(eventstruct.weapon)) {
        self.var_8181d952 = eventstruct.weapon;
        var_994e5c9a = 0;
        equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"eq_grapple", #"dart", #"eq_hawk", #"ultimate_turret");
        arrayremovevalue(equipments, #"eq_concertina_wire", 0);
        foreach (equipmentname in equipments) {
            if (eventstruct.weapon.name == equipmentname) {
                var_994e5c9a = 1;
                break;
            }
        }
        var_aec6fa7f = undefined;
        if (!var_994e5c9a) {
            weapon = eventstruct.weapon;
            networkid = self function_a33744de(weapon);
            if (networkid != 32767) {
                item = self get_inventory_item(networkid);
                if (isdefined(item) && item.amount > 0) {
                    var_aec6fa7f = item.amount;
                }
            }
            self function_e72d56f9(weapon, 1);
        }
        weaponname = eventstruct.weapon.name;
        var_8efce1dc = 0;
        foreach (pickupname in array(#"trophy_system", #"hatchet", #"tomahawk_t8", #"basketball", #"gadget_jammer", #"satchel_charge")) {
            if (pickupname == weaponname) {
                var_8efce1dc = 1;
                break;
            }
        }
        if (var_8efce1dc) {
            if (isdefined(eventstruct.projectile)) {
                dropitem = eventstruct.projectile;
                dropitem endon(#"death");
                if (weaponname == #"basketball") {
                    dropitem setinvisibletoplayer(self);
                    wait 0.25;
                    if (isdefined(self)) {
                        dropitem setvisibletoplayer(self);
                    }
                }
                if (weaponname == #"trophy_system") {
                    if (isdefined(item)) {
                        self._trophy_system_ammo1 = var_aec6fa7f;
                    }
                }
                wait 0.5;
                if (!isdefined(dropitem)) {
                    return;
                }
                itemspawnpoint = function_d08934c6(weaponname);
                if (!isdefined(itemspawnpoint)) {
                    return;
                }
                assert(itemspawnpoint.id < 1024);
                dropitem.id = itemspawnpoint.id;
                dropitem.networkid = item_world_util::function_1f0def85(dropitem);
                dropitem.itementry = itemspawnpoint.itementry;
                dropitem.hidetime = 0;
                dropitem.amount = eventstruct.weapon.name == #"basketball" ? 1 : 0;
                dropitem.count = 1;
                dropitem clientfield::set("dynamic_item_drop", 1);
                dropitem function_46d7f921(dropitem.id);
                level.item_spawn_drops[dropitem.networkid] = dropitem;
            }
        }
    }
}

// Namespace item_inventory/weapon_switch_started
// Params 1, eflags: 0x44
// Checksum 0x4ca011cb, Offset: 0x1890
// Size: 0x96
function private event_handler[weapon_switch_started] function_f5883bb1(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    self.next_weapon = undefined;
    if (isplayer(self) && isalive(self)) {
        if (eventstruct.weapon.isprimary && eventstruct.weapon != eventstruct.last_weapon) {
            self.next_weapon = eventstruct.weapon;
        }
    }
}

// Namespace item_inventory/weapon_change
// Params 1, eflags: 0x44
// Checksum 0x6d8777bc, Offset: 0x1930
// Size: 0x222
function private event_handler[weapon_change] function_a8c42ee4(*eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    if (isplayer(self) && isalive(self)) {
        if (isdefined(self.var_8181d952)) {
            weapon = self.var_8181d952;
            equipments = array(#"ability_smart_cover");
            foreach (equipmentname in equipments) {
                if (weapon.name == equipmentname) {
                    self function_e72d56f9(weapon, 1);
                    return;
                }
            }
        }
        if (isdefined(self.var_d0015cb3)) {
            weapon = self.var_d0015cb3;
            equipments = array(#"ability_smart_cover", #"eq_concertina_wire", #"ultimate_turret");
            foreach (equipmentname in equipments) {
                if (weapon.name == equipmentname) {
                    self function_e72d56f9(weapon, 1);
                    return;
                }
            }
        }
    }
}

// Namespace item_inventory/gadget_primed
// Params 1, eflags: 0x40
// Checksum 0x9aeab703, Offset: 0x1b60
// Size: 0xae
function event_handler[gadget_primed] gadget_primed_callback(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    player = eventstruct.entity;
    if (isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon)) {
        function_d62822d5();
        player.var_cc111ddc = eventstruct.weapon;
    }
}

// Namespace item_inventory/gadget_on
// Params 1, eflags: 0x40
// Checksum 0x300b415, Offset: 0x1c18
// Size: 0x1a0
function event_handler[gadget_on] gadget_on_callback(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    player = eventstruct.entity;
    if (isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon)) {
        equipments = array(#"eq_grapple", #"dart", #"eq_hawk", #"hash_364914e1708cb629");
        foreach (equipmentname in equipments) {
            if (eventstruct.weapon.name == equipmentname) {
                weapon = eventstruct.weapon;
                player function_e72d56f9(weapon, 1);
            }
        }
    }
}

// Namespace item_inventory/event_dfabd488
// Params 1, eflags: 0x40
// Checksum 0x8033455e, Offset: 0x1dc0
// Size: 0x9a
function event_handler[event_dfabd488] function_40d8d1ec(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    player = eventstruct.entity;
    if (isplayer(player) && isalive(player) && player function_76646dad(eventstruct.weapon)) {
        player.var_14c391cc = eventstruct.weapon;
    }
}

// Namespace item_inventory/change_seat
// Params 1, eflags: 0x40
// Checksum 0x3b7ebcb3, Offset: 0x1e68
// Size: 0x9c
function event_handler[change_seat] function_2aa4e6cf(eventstruct) {
    if (function_7d5553ac()) {
        return;
    }
    player = self;
    if (isplayer(player) && isalive(player)) {
        if (eventstruct.seat_index == 0 && player function_2cceca7b()) {
            player forceoffhandend();
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xb9c06dda, Offset: 0x1f10
// Size: 0x1d4
function private function_ce3288cf(damage) {
    if (!isdefined(self.inventory)) {
        return damage;
    }
    originaldamage = damage;
    var_e67d2721 = 0;
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        if (!isdefined(item.itementry.var_dba54111) || item.itementry.var_dba54111 == 0) {
            continue;
        }
        var_babbb09b = item.itementry.var_dba54111;
        var_e67d2721 += var_babbb09b;
        if (var_e67d2721 > originaldamage) {
            var_babbb09b = var_e67d2721 - originaldamage;
        }
        var_e67d2721 = min(var_e67d2721, originaldamage);
        if (isdefined(item.var_1181c08b) && item.var_1181c08b > 0) {
            item.var_1181c08b -= var_babbb09b;
            if (item.var_1181c08b <= 0) {
                remove_inventory_item(item.networkid, 0, 1);
            }
        }
        if (var_e67d2721 >= damage) {
            break;
        }
    }
    return damage - var_e67d2721;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xe907e751, Offset: 0x20f0
// Size: 0x1a4
function private function_38d1ea04() {
    if (isplayer(self) && isdefined(self.inventory)) {
        inventoryitem = self.inventory.items[6];
        if (!is_true(inventoryitem.itementry.var_b5b2485b)) {
            return;
        }
        if (isdefined(inventoryitem) && isdefined(inventoryitem.itementry)) {
            armorshards = inventoryitem.itementry.armorshards;
        }
        if (isdefined(armorshards) && armorshards > 0) {
            armorshard = function_4ba8fde(#"hash_fb37841b0d2d7e7");
            if (isdefined(armorshard)) {
                var_7841fe31 = self give_inventory_item(armorshard, armorshards, undefined, 11);
                if (var_7841fe31 > 0) {
                    function_d7944517(armorshard.id, undefined, var_7841fe31);
                }
            }
        }
        if (inventoryitem.networkid != 32767 && inventoryitem.itementry.itemtype == #"armor") {
            self remove_inventory_item(inventoryitem.networkid);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x13de1b0e, Offset: 0x22a0
// Size: 0xd4
function private function_bdc03d88() {
    if (isplayer(self) && isdefined(self.inventory)) {
        inventoryitem = self.inventory.items[6];
        if (inventoryitem.networkid != 32767 && inventoryitem.itementry.itemtype == #"armor") {
            inventoryitem.amount = armor::get_armor();
            if (function_27cd171b(inventoryitem)) {
                self setperk(#"specialty_damaged_armor");
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x4
// Checksum 0x7ccaa43c, Offset: 0x2380
// Size: 0x2d4
function private function_434d0c2b(itemtype, prioritylist, var_ab9610ad = undefined) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    assert(isarray(prioritylist));
    items = [];
    var_e3c48c83 = item_world_util::get_itemtype(var_ab9610ad);
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_b74300d3 = item_world_util::get_itemtype(item.itementry);
        if (var_e3c48c83 === var_b74300d3) {
            return item;
        }
        if (item.itementry.itemtype == itemtype) {
            if (isdefined(items[var_b74300d3])) {
                if (item.count > items[var_b74300d3].count) {
                    items[var_b74300d3] = item;
                }
                continue;
            }
            items[var_b74300d3] = item;
        }
    }
    foreach (var_b74300d3 in prioritylist) {
        if (isdefined(items[var_b74300d3])) {
            return items[var_b74300d3];
        }
    }
    foreach (item in items) {
        if (isdefined(item)) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x4
// Checksum 0x696901f6, Offset: 0x2660
// Size: 0x292
function private _cycle_item(itemtype, prioritylist, var_bcc2655a) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    assert(isarray(prioritylist));
    if (!isdefined(var_bcc2655a)) {
        return;
    }
    items = [];
    var_c7837092 = item_world_util::get_itemtype(var_bcc2655a);
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_b74300d3 = item_world_util::get_itemtype(item.itementry);
        if (item.itementry.itemtype == itemtype) {
            if (isdefined(items[var_b74300d3])) {
                if (item.count > items[var_b74300d3].count) {
                    items[var_b74300d3] = item;
                }
                continue;
            }
            items[var_b74300d3] = item;
        }
    }
    for (currentindex = 0; currentindex < prioritylist.size; currentindex++) {
        if (prioritylist[currentindex] == var_c7837092) {
            break;
        }
    }
    for (index = currentindex + 1; index < prioritylist.size; index++) {
        var_b74300d3 = prioritylist[index];
        if (isdefined(items[var_b74300d3])) {
            return items[var_b74300d3];
        }
    }
    if (currentindex < prioritylist.size) {
        for (index = 0; index < currentindex; index++) {
            var_b74300d3 = prioritylist[index];
            if (isdefined(items[var_b74300d3])) {
                return items[var_b74300d3];
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x8486a4bd, Offset: 0x2900
// Size: 0x1de
function private function_9da31874(itemtype) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    items = [];
    foreach (index, item in self.inventory.items) {
        if (index >= 5) {
            break;
        }
        if (item.id == 32767 || item.itementry.itemtype != itemtype) {
            continue;
        }
        items[items.size] = item;
    }
    currentindex = isdefined(self.inventory.var_a0290b96[itemtype]) ? self.inventory.var_a0290b96[itemtype] : 0;
    if (currentindex < 0) {
        currentindex = 0;
    } else if (currentindex > items.size) {
        currentindex = items.size;
    }
    if (items.size > 0) {
        currentindex = (currentindex + 1) % items.size;
        self.inventory.var_a0290b96[itemtype] = currentindex;
    }
    return items[currentindex];
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x353f348, Offset: 0x2ae8
// Size: 0x374
function private function_283a29c8(var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(#"equipment", array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de", #"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"), var_ab9610ad);
    if (isdefined(item)) {
        equip_equipment(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x5ac8bdcf, Offset: 0x2e68
// Size: 0x374
function private function_bf956054(var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(#"field_upgrade", array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de", #"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"), var_ab9610ad);
    if (isdefined(item)) {
        equip_equipment(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xe2283496, Offset: 0x31e8
// Size: 0x374
function private function_cd5393a9(var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(#"tactical", array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de", #"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"), var_ab9610ad);
    if (isdefined(item)) {
        equip_equipment(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x45828c2a, Offset: 0x3568
// Size: 0x12c
function private function_714fce55(itemtype, var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(itemtype, array(#"hash_6eb09ea5da35e18f", #"hash_654445f6cc7a7e1c", #"item_survival_scorestreak_pineapple_gun", #"item_survival_scorestreak_deathmachine", #"item_survival_scorestreak_flamethrower", #"item_survival_scorestreak_hand_cannon", #"item_survival_scorestreak_ultimate_turret", #"hash_18fa1f3e4e43437c"), var_ab9610ad);
    if (isdefined(item)) {
        function_854cf2c3(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xebadd952, Offset: 0x36a0
// Size: 0x134
function private function_986801b8(var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(#"scorestreak", array(#"hash_6eb09ea5da35e18f", #"hash_654445f6cc7a7e1c", #"item_survival_scorestreak_pineapple_gun", #"item_survival_scorestreak_deathmachine", #"item_survival_scorestreak_flamethrower", #"item_survival_scorestreak_hand_cannon", #"item_survival_scorestreak_ultimate_turret", #"hash_18fa1f3e4e43437c"), var_ab9610ad);
    if (isdefined(item)) {
        function_1ac37022(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xa069b103, Offset: 0x37e0
// Size: 0xc4
function private function_2e10e66e(var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(#"backpack", array(#"hash_7c3701ba5f0879c2"), var_ab9610ad);
    if (isdefined(item)) {
        equip_backpack(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x521310b6, Offset: 0x38b0
// Size: 0x104
function private function_a7d62e18(var_ab9610ad = undefined) {
    assert(isplayer(self));
    if (function_fe402108()) {
        return;
    }
    item = function_434d0c2b(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad", #"hash_20699a922abaf2e1"), var_ab9610ad);
    if (isdefined(item)) {
        equip_health(item);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x36e380bd, Offset: 0x39c0
// Size: 0x212
function private function_9d805044(itemtype, var_ab9610ad = undefined) {
    assert(isplayer(self));
    assert(isstring(itemtype) || ishash(itemtype));
    if (function_fe402108()) {
        return;
    }
    switch (itemtype) {
    case #"backpack":
        function_2e10e66e(var_ab9610ad);
        break;
    case #"equipment":
        function_283a29c8(var_ab9610ad);
        break;
    case #"field_upgrade":
        function_bf956054(var_ab9610ad);
        break;
    case #"tactical":
        function_cd5393a9(var_ab9610ad);
        break;
    case #"health":
        function_a7d62e18(var_ab9610ad);
        break;
    case #"scorestreak":
        function_986801b8(var_ab9610ad);
        break;
    case #"perk_tier_3":
    case #"perk_tier_2":
    case #"perk_tier_1":
        function_714fce55(hash(itemtype), var_ab9610ad);
        break;
    default:
        break;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xae5ab63d, Offset: 0x3be0
// Size: 0x1e4
function private function_d08934c6(equipment) {
    var_b74300d3 = undefined;
    switch (equipment) {
    case #"satchel_charge":
        var_b74300d3 = sessionmodeiszombiesgame() ? #"satchel_charge_t9_item_sr" : #"satchel_charge_t9_item";
        break;
    case #"hatchet":
        var_b74300d3 = sessionmodeiszombiesgame() ? #"hatchet_t9_item_sr" : #"hatchet_t9_item";
        break;
    case #"tomahawk_t8":
        var_b74300d3 = #"tomahawk_t8_wz_item";
        break;
    case #"basketball":
        var_b74300d3 = #"wz_ball";
        break;
    case #"cymbal_monkey":
        var_b74300d3 = sessionmodeiszombiesgame() ? #"cymbal_monkey_t9_item_sr" : #"cymbal_monkey_wz_item";
        break;
    case #"trophy_system":
        var_b74300d3 = #"trophy_system_wz_item";
        break;
    case #"gadget_jammer":
        var_b74300d3 = sessionmodeiszombiesgame() ? #"hash_5aeb970e93a31c17" : #"hash_3f154f45479130ed";
        break;
    }
    if (isdefined(var_b74300d3)) {
        return function_4ba8fde(var_b74300d3);
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x9277f5a, Offset: 0x3dd0
// Size: 0x82
function function_520b16d6() {
    item = spawnstruct();
    item.amount = 0;
    item.count = 0;
    item.id = 32767;
    item.networkid = 32767;
    item.itementry = undefined;
    item.var_627c698b = undefined;
    item.weaponoptions = undefined;
    item.var_e91aba42 = undefined;
    return item;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x593d8947, Offset: 0x3e60
// Size: 0x5c
function private function_27cd171b(inventoryitem) {
    if (!isdefined(inventoryitem.amount)) {
        return false;
    }
    if (inventoryitem.amount <= 0) {
        return true;
    }
    return inventoryitem.amount / inventoryitem.itementry.amount <= 0.5;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xc1affd4f, Offset: 0x3ec8
// Size: 0x4c
function function_d85c5382(sensordart, *player) {
    level.sensor_darts[level.sensor_darts.size] = player;
    arrayremovevalue(level.sensor_darts, undefined);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xc4a9bb5e, Offset: 0x3f20
// Size: 0x254
function private function_d2f05352() {
    level endon(#"game_ended");
    while (true) {
        players = getplayers();
        time = gettime();
        for (playerindex = 0; playerindex < players.size; playerindex++) {
            if ((playerindex + 1) % 15 == 0) {
                waitframe(1);
            }
            player = players[playerindex];
            if (!isdefined(player) || player.sessionstate != "playing" || !isalive(player) || !isdefined(player.inventory) || player.inventory.consumed.size <= 0) {
                continue;
            }
            consumed = player.inventory.consumed;
            var_1bc7a1b2 = 0;
            for (i = 0; i < consumed.size; i++) {
                item = consumed[i];
                if (item.endtime <= time) {
                    arrayremoveindex(consumed, i);
                    var_1bc7a1b2 = 1;
                    continue;
                }
            }
            if (var_1bc7a1b2) {
                player function_6c36ab6b();
            }
            for (index = 0; index < 5; index++) {
                item = player.inventory.items[index];
                if (isdefined(item.endtime) && item.endtime <= time) {
                    player use_inventory_item(item.networkid, 1, 0);
                }
            }
        }
        players = undefined;
        waitframe(1);
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xb5e04f0b, Offset: 0x4180
// Size: 0xcc
function private function_755a35c5() {
    assert(isplayer(self));
    stimcount = 0;
    healthitem = self.inventory.items[5];
    if (healthitem.networkid !== 32767) {
        if (healthitem.itementry.name == #"hash_6d9b83e07c57fb35") {
            stimcount = function_bba770de(healthitem.itementry);
        }
    }
    gadget_health_regen::function_6eef7f4f(stimcount);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xda493ead, Offset: 0x4258
// Size: 0xfc
function private function_a4413333() {
    assert(isplayer(self));
    healthitem = self.inventory.items[5];
    if (healthitem.networkid !== 32767) {
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(healthitem.itementry));
    }
    equipmentitem = self.inventory.items[7];
    if (equipmentitem.networkid !== 32767) {
        self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(equipmentitem.itementry));
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x6808fa64, Offset: 0x4360
// Size: 0x49a
function private function_6c36ab6b() {
    self function_e6f9e3cd();
    foreach (slotid, item in self.inventory.items) {
        itementry = item.itementry;
        if (isdefined(itementry) && !is_true(itementry.consumable) && isarray(itementry.talents)) {
            if (is_true(itementry.var_97c5ead1) && slotid < 5) {
                continue;
            }
            foreach (var_9de7969b in itementry.talents) {
                self function_b5feff95(var_9de7969b.talent);
            }
        }
    }
    foreach (item in self.inventory.consumed) {
        itementry = item.itementry;
        if (isdefined(itementry) && isarray(itementry.talents)) {
            foreach (var_9de7969b in itementry.talents) {
                self function_b5feff95(var_9de7969b.talent);
            }
        }
    }
    if (isdefined(self.var_7341f980)) {
        foreach (talent in self.var_7341f980) {
            self function_b5feff95(talent);
        }
    }
    if (isdefined(self.class_num)) {
        self.specialty = self getloadoutperks(self.class_num);
    } else {
        self.specialty = [];
    }
    if (isdefined(level.var_74b10e67)) {
        self [[ level.var_74b10e67 ]]();
    }
    armoritem = self.inventory.items[6];
    if (armoritem.networkid != 32767 && armoritem.itementry.itemtype == #"armor") {
        if (function_27cd171b(armoritem)) {
            self setperk(#"specialty_damaged_armor");
        }
    }
    self player::function_9080887a();
    self.var_66cb03ad = isdefined(self.var_66cb03ad) ? self.var_66cb03ad : self.spawnhealth;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x65c94874, Offset: 0x4808
// Size: 0xe2
function private function_60706bdb(networkid) {
    assert(isplayer(self));
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    if (item.itementry.itemtype == #"weapon") {
        weapon = item_inventory_util::function_2b83d3ff(item);
        ammoclip = self getweaponammoclip(weapon);
        item.amount = ammoclip;
    }
}

// Namespace item_inventory/item_inventory
// Params 12, eflags: 0x4
// Checksum 0x7dff0812, Offset: 0x48f8
// Size: 0x1fc
function private function_d7944517(itemid, weapon, count, amount, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, attachments = undefined, stockammo = undefined, aat = undefined, paplv = undefined, immediately = 0) {
    assert(isplayer(self));
    assert(item_world_util::function_2c7fc531(itemid));
    self endon(#"death");
    droppos = var_7cab8e12;
    if (!stashitem) {
        droppos = self.origin;
    }
    if (!immediately) {
        return self item_drop::function_fd9026e4(0, weapon, count, amount, itemid, droppos, self.angles, 2, stashitem, 0, targetname, undefined, attachments, undefined, undefined, undefined, undefined, stockammo, aat, paplv);
    }
    self thread item_drop::function_fd9026e4(0, weapon, count, amount, itemid, droppos, self.angles, 2, stashitem, 0, targetname, undefined, attachments, undefined, undefined, undefined, undefined, stockammo, aat, paplv);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x30913336, Offset: 0x4b00
// Size: 0x3a
function private function_d116a346(*slot, weapon) {
    if (isplayer(self)) {
        self.var_e42fb511 = weapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x60021d92, Offset: 0x4b48
// Size: 0x3a
function private _gadget_health_regen_on(*slot, weapon) {
    if (isplayer(self)) {
        self.var_d6cd7d80 = weapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x674ede96, Offset: 0x4b90
// Size: 0x3e
function private _gadget_health_regen_off(*slot, *weapon) {
    if (isplayer(self)) {
        self.var_d6cd7d80 = undefined;
        self.var_e42fb511 = undefined;
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x5d7f141a, Offset: 0x4bd8
// Size: 0x54
function private function_2cceca7b() {
    return self isgrappling() || self isusingoffhand() || self function_55acff10(1);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xd3790ef6, Offset: 0x4c38
// Size: 0x42
function private function_c1cef1ec(weapon) {
    if (weapon != self getcurrentoffhand()) {
        return 0;
    }
    return self function_2cceca7b();
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x4ecefd56, Offset: 0x4c88
// Size: 0x1cc
function private function_c6be9f7f(weapon, ammo) {
    assert(isplayer(self));
    assert(isdefined(weapon));
    slot = self gadgetgetslot(weapon);
    if (slot >= 0 && slot < 3) {
        if ("ammo" != weapon.gadget_powerusetype) {
            return;
        }
        if (weapon.name == #"eq_tripwire") {
            newpower = weapon.gadget_powermax;
            ammo = weapon.clipsize;
        } else {
            if (!weapon.clipsize) {
                var_35935a45 = weapon.gadget_powermax;
            } else {
                var_35935a45 = weapon.gadget_powermax / weapon.clipsize;
            }
            newammo = ammo;
            if (newammo > weapon.clipsize) {
                newammo = weapon.clipsize;
            }
            newpower = newammo * var_35935a45;
        }
        power = self gadgetpowerset(slot, newpower);
        self setweaponammoclip(weapon, ammo);
        debug_print("set_gadget_power: " + power + ", ammo: " + ammo, weapon);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0xb452d008, Offset: 0x4e60
// Size: 0xee
function private function_ee9ce1c4(itementry, *var_dfe6c7e5) {
    self endon(#"death");
    self.var_10abd91d = 1;
    var_cbdeb265 = level.nullprimaryoffhand;
    switch (var_dfe6c7e5.itemtype) {
    case #"tactical":
        var_cbdeb265 = level.nullsecondaryoffhand;
        break;
    case #"field_upgrade":
        var_cbdeb265 = level.var_3488e988;
        break;
    }
    self replace_weapon(item_world_util::function_35e06774(var_dfe6c7e5), var_cbdeb265);
    self function_c6be9f7f(var_cbdeb265, 0);
    self.var_10abd91d = 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x4
// Checksum 0x49d4929b, Offset: 0x4f58
// Size: 0xfe
function private function_8214f1b6(itementry, *var_dfe6c7e5) {
    self endon(#"death");
    self.var_10abd91d = 1;
    weapon = item_world_util::function_35e06774(var_dfe6c7e5);
    slot = self gadgetgetslot(weapon);
    if (slot >= 0 && slot < 3) {
        while (self function_af359de(slot)) {
            waitframe(1);
        }
    }
    self replace_weapon(weapon, level.var_ef61b4b5);
    self function_755a35c5();
    self.var_10abd91d = 0;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x38e03f7d, Offset: 0x5060
// Size: 0x1b0
function function_bba770de(itementry) {
    assert(isplayer(self));
    count = 0;
    if (!isdefined(itementry)) {
        return count;
    }
    if (!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items)) {
        return count;
    }
    if (is_true(itementry.unlimited)) {
        return count;
    }
    name = isdefined(itementry.parentname) ? itementry.parentname : itementry.name;
    for (index = 0; index < self.inventory.items.size && index < 17 + 1; index++) {
        inventoryitem = self.inventory.items[index];
        if (!isdefined(inventoryitem.itementry)) {
            continue;
        }
        if (name == (isdefined(inventoryitem.itementry.parentname) ? inventoryitem.itementry.parentname : inventoryitem.itementry.name)) {
            count += inventoryitem.count;
        }
    }
    return count;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x7b744638, Offset: 0x5218
// Size: 0x146
function can_pickup_ammo(item, ammoamount = undefined) {
    assert(isplayer(self));
    itementry = item.itementry;
    ammoweapon = itementry.weapon;
    ammoamount = isdefined(itementry.amount) ? itementry.amount : isdefined(ammoamount) ? ammoamount : 1;
    maxstockammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
    currentammostock = self getweaponammostock(ammoweapon);
    var_9b9ba643 = maxstockammo - currentammostock;
    addammo = int(min(ammoamount, var_9b9ba643));
    return addammo > 0;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xca020926, Offset: 0x5368
// Size: 0x15e
function function_550fcb41(item) {
    assert(isplayer(self));
    if (!is_true(item.itementry.stackable)) {
        return false;
    }
    maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, item.itementry);
    if (maxstack <= 1) {
        return false;
    }
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].id == 32767) {
            continue;
        }
        if (self.inventory.items[i].itementry.name != item.itementry.name) {
            continue;
        }
        if (self.inventory.items[i].count < maxstack) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x70297c67, Offset: 0x54d0
// Size: 0xd2
function private function_85645978(item) {
    currtime = gettime();
    foreach (consumeditem in self.inventory.consumed) {
        if (item.itementry.name == consumeditem.itementry.name && currtime < consumeditem.endtime) {
            return consumeditem;
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x8ca45882, Offset: 0x55b0
// Size: 0xf2
function private function_3fe6ef04() {
    assert(isplayer(self));
    var_cfa0e915 = [];
    foreach (consumeditem in self.inventory.consumed) {
        if (isdefined(var_cfa0e915[consumeditem.itementry.name])) {
            continue;
        }
        var_cfa0e915[consumeditem.itementry.name] = 1;
    }
    return var_cfa0e915.size;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x2771c123, Offset: 0x56b0
// Size: 0x570
function consume_item(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return 0;
    }
    if (isdefined(item.starttime)) {
        return 0;
    }
    if (self isinvehicle()) {
        vehicle = self getvehicleoccupied();
        if (vehicle getoccupantseat(self) == 0) {
            self playsoundtoplayer(#"uin_default_action_denied", self);
            return 0;
        }
        currentweapon = self getcurrentweapon();
        if (isdefined(currentweapon) && is_true(currentweapon.var_29d24e37)) {
            self playsoundtoplayer(#"uin_default_action_denied", self);
            return 0;
        }
    }
    if (item.itementry.itemtype == #"armor_shard") {
        return function_6d647220(item);
    }
    consumeditem = self function_85645978(item);
    if (!isdefined(consumeditem) && self function_3fe6ef04() >= 10) {
        self playsoundtoplayer(#"uin_default_action_denied", self);
        return 0;
    }
    self callback::callback(#"hash_5775ae80fc576ea6", item);
    duration = int((isdefined(item.itementry.duration) ? item.itementry.duration : 0) * 1000);
    starttime = gettime();
    endtime = starttime + duration;
    item.starttime = starttime;
    item.endtime = endtime;
    if (isdefined(consumeditem)) {
        consumeditem.endtime += duration;
        for (index = 0; index < 5; index++) {
            inventoryitem = self.inventory.items[index];
            if (!isdefined(inventoryitem.endtime)) {
                continue;
            }
            if (inventoryitem.itementry.name == item.itementry.name) {
                inventoryitem.starttime = consumeditem.starttime;
                inventoryitem.endtime = consumeditem.endtime;
            }
        }
    } else {
        consumeditem = spawnstruct();
        consumeditem.id = item.id;
        consumeditem.itementry = item.itementry;
        consumeditem.starttime = gettime();
        consumeditem.endtime = consumeditem.starttime + duration;
    }
    self.inventory.consumed[self.inventory.consumed.size] = consumeditem;
    self function_b00db06(11, item.networkid);
    self function_db2abc4(item);
    self function_6c36ab6b();
    if (isdefined(consumeditem.itementry) && isdefined(consumeditem.itementry.talents) && isarray(consumeditem.itementry.talents)) {
        foreach (talent in consumeditem.itementry.talents) {
            if (talent.talent == #"hash_6b4f1f8c0c22026f") {
                self thread function_299d2131(300, 100, 0.1);
                break;
            }
        }
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xc14df82d, Offset: 0x5c28
// Size: 0x2d0
function function_6d647220(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    if (!isdefined(item) || item.networkid == 32767) {
        return false;
    }
    if (!has_armor()) {
        return false;
    }
    if (!isdefined(self.armor) || !isdefined(self.maxarmor)) {
        return false;
    }
    if (self.armor == self.maxarmor) {
        return false;
    }
    self use_inventory_item(item.networkid, 1);
    armoritem = undefined;
    if (isplayer(self) && isdefined(self.inventory)) {
        armoritem = self.inventory.items[6];
        if (!isdefined(armoritem) || armoritem.networkid == 32767 || armoritem.itementry.itemtype != #"armor") {
            return false;
        }
    }
    if (isdefined(self.var_3f1410dd)) {
        self.var_3f1410dd.repair_amount += int(min(isdefined(armoritem.itementry.var_a3aa1ca2) ? armoritem.itementry.var_a3aa1ca2 : 0, self.maxarmor - self.armor));
        self.var_3f1410dd.var_7352c057++;
    }
    self.armor = int(min(self.armor + (isdefined(armoritem.itementry.var_a3aa1ca2) ? armoritem.itementry.var_a3aa1ca2 : 0), self.maxarmor));
    function_bdc03d88();
    self function_6c36ab6b();
    self function_db2abc4(item);
    return true;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xc894cf2, Offset: 0x5f00
// Size: 0x414
function cycle_equipment_item() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    equipmentitem = self.inventory.items[7];
    if (equipmentitem.networkid !== 32767) {
        var_bcc2655a = equipmentitem.itementry;
    }
    if (getdvarint(#"hash_4cd4e3d15cf4ee7e", 1)) {
        item = _cycle_item(#"equipment", array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de", #"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"), var_bcc2655a);
    } else {
        item = function_9da31874(#"equipment");
    }
    if (isdefined(item)) {
        equip_equipment(item);
        return;
    }
    self playsoundtoplayer(#"uin_default_action_denied", self);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x2324599, Offset: 0x6320
// Size: 0x1a4
function cycle_health_item() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    healthitem = self.inventory.items[5];
    if (healthitem.networkid !== 32767) {
        var_bcc2655a = healthitem.itementry;
    }
    if (getdvarint(#"hash_4cd4e3d15cf4ee7e", 1)) {
        item = _cycle_item(#"health", array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad", #"hash_20699a922abaf2e1"), var_bcc2655a);
    } else {
        item = function_9da31874(#"health");
    }
    if (isdefined(item)) {
        equip_health(item);
        return;
    }
    self playsoundtoplayer(#"uin_default_action_denied", self);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xd1538e90, Offset: 0x64d0
// Size: 0x1d4
function function_fa4bb600() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    var_16f12c31 = self.inventory.items[17];
    if (var_16f12c31.networkid !== 32767) {
        var_bcc2655a = var_16f12c31.itementry;
    }
    if (getdvarint(#"hash_4cd4e3d15cf4ee7e", 1)) {
        item = _cycle_item(#"scorestreak", array(#"hash_6eb09ea5da35e18f", #"hash_654445f6cc7a7e1c", #"item_survival_scorestreak_pineapple_gun", #"item_survival_scorestreak_deathmachine", #"item_survival_scorestreak_flamethrower", #"item_survival_scorestreak_hand_cannon", #"item_survival_scorestreak_ultimate_turret", #"hash_18fa1f3e4e43437c"), var_bcc2655a);
    } else {
        item = function_9da31874(#"scorestreak");
    }
    if (isdefined(item)) {
        function_1ac37022(item);
        return;
    }
    self playsoundtoplayer(#"uin_default_action_denied", self);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x31c77397, Offset: 0x66b0
// Size: 0x1c4
function function_a50547af() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    var_16f12c31 = self.inventory.items[12];
    if (var_16f12c31.networkid !== 32767) {
        var_bcc2655a = var_16f12c31.itementry;
    }
    if (getdvarint(#"hash_4cd4e3d15cf4ee7e", 1)) {
        item = _cycle_item(#"field_upgrade", array(#"hash_3f154f45479130ed", #"hash_2c9b75b17410f2de", #"field_upgrade_frost_blast_item_sr", #"field_upgrade_frost_blast_2_item_sr", #"field_upgrade_frost_blast_3_item_sr", #"field_upgrade_frost_blast_4_item_sr", #"field_upgrade_frost_blast_5_item_sr"), var_bcc2655a);
    } else {
        item = function_9da31874(#"field_upgrade");
    }
    if (isdefined(item)) {
        equip_equipment(item);
        return;
    }
    self playsoundtoplayer(#"uin_default_action_denied", self);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x147b2e30, Offset: 0x6880
// Size: 0x244
function function_9ba10b94(networkid) {
    assert(isplayer(self));
    self endon(#"death");
    slotid = function_b246c573(networkid);
    if (!isdefined(slotid)) {
        return;
    }
    attachmentweapons = [];
    attachmentids = [];
    foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6, 7, 8)) {
        var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, attachmentoffset);
        item = self.inventory.items[var_f9f8c0b5];
        if (item.networkid != 32767) {
            attachmentweapons[attachmentweapons.size] = item_world_util::function_f4a8d375(item.id);
            attachmentids[attachmentids.size] = item.id;
            remove_inventory_item(item.networkid, 0, 1);
        }
    }
    drop_inventory_item(self.inventory.items[slotid].networkid);
    for (index = 0; index < attachmentids.size; index++) {
        self thread function_d7944517(attachmentids[index], attachmentweapons[index], 1, 1);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x7add8579, Offset: 0x6ad0
// Size: 0x7ba
function function_9d102bbd(var_b72297c2, networkid) {
    assert(isplayer(self));
    self endon(#"death");
    if (!item_world_util::can_pick_up(var_b72297c2)) {
        return 0;
    }
    if (!isdefined(var_b72297c2) || !isdefined(var_b72297c2.itementry) || var_b72297c2.itementry.itemtype !== #"weapon") {
        return 0;
    }
    weaponitem = get_inventory_item(networkid);
    if (!isdefined(weaponitem)) {
        return 0;
    }
    if (!isdefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
        return 0;
    }
    slotid = function_b246c573(networkid);
    if (!isdefined(slotid)) {
        return 0;
    }
    weapon = item_inventory_util::function_2b83d3ff(weaponitem);
    if (isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
        return 0;
    }
    if (isentity(var_b72297c2)) {
        var_b72297c2.hidetime = gettime();
    } else {
        function_54ca5536(var_b72297c2.id, gettime());
    }
    dropweapons = [];
    dropids = [];
    var_cc9e34fb = [];
    var_14174938 = [];
    if (item_inventory_util::function_4bd83c04(var_b72297c2)) {
        foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6, 7, 8)) {
            var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, attachmentoffset);
            item = self.inventory.items[var_f9f8c0b5];
            if (item.networkid != 32767) {
                attachmentname = item_inventory_util::function_2ced1d34(var_b72297c2, item.itementry, 1);
                assert(!isdefined(var_cc9e34fb[attachmentoffset]));
                if (isdefined(attachmentname) && !isdefined(var_cc9e34fb[attachmentoffset])) {
                    var_cc9e34fb[attachmentoffset] = item.itementry;
                } else {
                    dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(item.id);
                    dropids[dropids.size] = item.id;
                }
                var_14174938[var_14174938.size] = item.networkid;
            }
        }
    }
    if (isdefined(var_b72297c2.attachments) || isdefined(var_b72297c2.itementry.attachments)) {
        attachments = isdefined(var_b72297c2.attachments) ? var_b72297c2.attachments : var_b72297c2.itementry.attachments;
        foreach (attachment in attachments) {
            attachmentitem = attachment;
            if (!isdefined(attachmentitem)) {
                continue;
            }
            if (!isdefined(attachmentitem.itementry)) {
                if (!item_world_util::function_7363384a(attachment.attachment_type)) {
                    continue;
                }
                attachmentitem = function_4ba8fde(attachment.attachment_type);
                if (!isdefined(attachmentitem)) {
                    continue;
                }
            }
            attachmentoffset = item_inventory_util::function_837f4a57(attachmentitem.itementry);
            if (!isdefined(attachmentoffset)) {
                continue;
            }
            if (!isdefined(var_cc9e34fb[attachmentoffset])) {
                var_cc9e34fb[attachmentoffset] = attachmentitem.itementry;
                continue;
            }
            dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(attachmentitem.id);
            dropids[dropids.size] = attachmentitem.id;
        }
    }
    var_b72297c2.attachments = [];
    foreach (var_fe35755b in var_cc9e34fb) {
        if (isdefined(var_fe35755b.name)) {
            attachmentitem = function_4ba8fde(var_fe35755b.name);
            var_e38a0464 = function_520b16d6();
            var_e38a0464.count = 1;
            var_e38a0464.id = attachmentitem.id;
            var_e38a0464.networkid = var_e38a0464.id;
            var_e38a0464.itementry = attachmentitem.itementry;
            var_b72297c2.attachments[var_b72297c2.attachments.size] = var_e38a0464;
        }
    }
    for (index = 0; index < var_14174938.size; index++) {
        var_ddd377f2 = var_14174938[index];
        remove_inventory_item(var_ddd377f2, 0, 1);
    }
    dropweapon = self drop_inventory_item(networkid);
    for (index = 0; index < dropids.size; index++) {
        self thread function_d7944517(dropids[index], dropweapons[index], 1, 1);
    }
    item_world::function_de2018e3(var_b72297c2, self, slotid);
    item_world::consume_item(var_b72297c2);
    if (isdefined(dropweapon)) {
        return dropweapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x4688d64c, Offset: 0x7298
// Size: 0x2d2
function function_b76f46a0(var_b72297c2, networkid) {
    assert(isplayer(self));
    self endon(#"death");
    if (!item_world_util::can_pick_up(var_b72297c2)) {
        return 0;
    }
    if (!isdefined(var_b72297c2) || !isdefined(var_b72297c2.itementry) || var_b72297c2.itementry.itemtype !== #"weapon") {
        return 0;
    }
    weaponitem = get_inventory_item(networkid);
    if (!isdefined(weaponitem)) {
        return 0;
    }
    if (!isdefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
        return 0;
    }
    slotid = function_b246c573(networkid);
    if (!isdefined(slotid)) {
        return 0;
    }
    weapon = item_inventory_util::function_2b83d3ff(weaponitem);
    if (isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
        return 0;
    }
    if (isentity(var_b72297c2)) {
        var_b72297c2.hidetime = gettime();
    } else {
        function_54ca5536(var_b72297c2.id, gettime());
    }
    dropweapons = [];
    dropids = [];
    var_cc9e34fb = [];
    var_14174938 = [];
    dropweapon = self drop_inventory_item(networkid);
    for (index = 0; index < dropids.size; index++) {
        self thread function_d7944517(dropids[index], dropweapons[index], 1, 1);
    }
    item_world::function_de2018e3(var_b72297c2, self, slotid);
    item_world::consume_item(var_b72297c2);
    if (isdefined(dropweapon)) {
        return dropweapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xaacfa895, Offset: 0x7578
// Size: 0x1b0
function function_fba40e6c(item) {
    assert(isplayer(self));
    self endon(#"death");
    if (!item_world_util::can_pick_up(item)) {
        return 0;
    }
    itemslot = self function_e66dcff5(item, 1);
    dropitem = self.inventory.items[itemslot];
    self function_85287396(1);
    self drop_inventory_item(dropitem.networkid);
    slotid = function_e66dcff5(item, 1);
    itementry = item.itementry;
    self item_world::function_de2018e3(item, self, slotid);
    inventoryitem = self function_8babc9f9(itementry);
    item_world::consume_item(item);
    if (isdefined(inventoryitem)) {
        self equip_item(inventoryitem.networkid);
    }
    self function_85287396(0);
    return dropitem;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x181dca07, Offset: 0x7730
// Size: 0x868
function function_e66dcff5(item, var_662e1704 = 0) {
    assert(isplayer(self));
    if (!isdefined(self.inventory)) {
        return undefined;
    }
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return undefined;
    }
    if (item_inventory_util::function_819781bf()) {
        var_662e1704 = 1;
    }
    switch (item.itementry.itemtype) {
    case #"ammo":
        return undefined;
    case #"armor_shard":
        return 11;
    case #"weapon":
        foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
            if (self.inventory.items[slotid].networkid === 32767) {
                return slotid;
            }
        }
        weaponitem = function_230ceec4(get_current_weapon());
        if (!isdefined(weaponitem)) {
            return;
        }
        return function_b246c573(weaponitem.networkid);
    case #"backpack":
        return 8;
    case #"armor":
        return 6;
    case #"resource":
        if (item_world_util::function_41f06d9d(item.itementry)) {
            return 9;
        }
        return 10;
    case #"equipment":
        if (var_662e1704 || self.inventory.items[7].networkid === 32767) {
            return 7;
        }
        break;
    case #"field_upgrade":
        if (var_662e1704 || self.inventory.items[12].networkid === 32767) {
            return 12;
        }
        break;
    case #"tactical":
        if (var_662e1704 || self.inventory.items[13].networkid === 32767) {
            return 13;
        }
        break;
    case #"health":
        if (var_662e1704 || self.inventory.items[5].networkid === 32767) {
            return 5;
        }
        break;
    case #"perk_tier_1":
        if (var_662e1704 || self.inventory.items[14].networkid === 32767) {
            return 14;
        }
        break;
    case #"perk_tier_2":
        if (var_662e1704 || self.inventory.items[15].networkid === 32767) {
            return 15;
        }
        break;
    case #"perk_tier_3":
        if (var_662e1704 || self.inventory.items[16].networkid === 32767) {
            return 16;
        }
        break;
    case #"scorestreak":
        if (var_662e1704 || self.inventory.items[17].networkid === 32767) {
            return 17;
        }
        break;
    }
    if (item.itementry.itemtype == #"attachment") {
        weaponslotid = function_d768ea30();
        if (var_662e1704) {
            weaponslotid = isdefined(weaponslotid) && weaponslotid == 17 + 1 ? 17 + 1 + 8 + 1 : 17 + 1;
        }
        if (isdefined(weaponslotid)) {
            var_f0dc4e93 = item_world_util::function_970b8d86(weaponslotid);
            if (self.inventory.items[weaponslotid].networkid != 32767 && self.inventory.items[weaponslotid].itementry.itemtype != #"scorestreak") {
                var_ceefbd10 = item_inventory_util::function_837f4a57(item.itementry);
                var_f9f8c0b5 = item_inventory_util::function_dfaca25e(weaponslotid, var_ceefbd10);
                weaponitem = self get_inventory_item(var_f0dc4e93);
                attachmentname = item_inventory_util::function_2ced1d34(weaponitem, item.itementry, 1);
                if (isdefined(attachmentname)) {
                    return var_f9f8c0b5;
                }
            }
        }
    }
    if (is_true(item.itementry.stackable)) {
        weapon = item_world_util::function_35e06774(item.itementry);
        if (isdefined(weapon)) {
            maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, item.itementry);
            if (maxstack > 1) {
                foreach (i, spawnitem in self.inventory.items) {
                    if (spawnitem.id == 32767) {
                        continue;
                    }
                    inventoryitem = function_b1702735(spawnitem.id);
                    if (inventoryitem.itementry.name != item.itementry.name) {
                        continue;
                    }
                    if (self.inventory.items[i].count < maxstack) {
                        return i;
                    }
                }
            }
        }
    }
    if (!item_inventory_util::function_819781bf()) {
        for (index = 0; index < self.inventory.var_c212de25; index++) {
            if (self.inventory.items[index].id == 32767) {
                return index;
            }
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x7bd8d275, Offset: 0x7fa0
// Size: 0xdc
function drop_armor(stashitem = 0, var_7cab8e12 = undefined, targetname = undefined) {
    assert(isplayer(self));
    if (self has_armor()) {
        item = self.inventory.items[6];
        self thread drop_inventory_item(item.networkid, stashitem, var_7cab8e12, targetname);
        return true;
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0xf829d177, Offset: 0x8088
// Size: 0xfc
function function_d86d7ac7(stashitem = 0, var_7cab8e12 = undefined, targetname = undefined) {
    assert(isplayer(self));
    for (index = self.inventory.var_c212de25; index < 5; index++) {
        inventoryitem = self.inventory.items[index];
        if (inventoryitem.networkid != 32767) {
            self thread drop_inventory_item(inventoryitem.networkid, stashitem, var_7cab8e12, targetname);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 6, eflags: 0x0
// Checksum 0x48bb1e91, Offset: 0x8190
// Size: 0x75a
function drop_inventory_item(networkid, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, var_4a6f595d = 1, immediately = 0) {
    assert(isplayer(self));
    self endon(#"death");
    dropitem = undefined;
    item = get_inventory_item(networkid);
    if (!isdefined(item)) {
        return dropitem;
    }
    weapon = item_inventory_util::function_2b83d3ff(item);
    stockammo = 0;
    var_4f8a16ec = getgametypesetting(#"hash_b76e50c1202aa23");
    if (!var_4f8a16ec && isdefined(weapon) && (item.itementry.itemtype === #"weapon" || item.itementry.itemtype === #"scorestreak")) {
        stockammo = self getweaponammostock(weapon);
    }
    if (!immediately && isdefined(self) && isdefined(weapon) && get_current_weapon() == weapon && self isfiring()) {
        waitframe(1);
    }
    if (!isdefined(self) || isdefined(weapon) && get_current_weapon() == weapon && self isfiring()) {
        return dropitem;
    }
    /#
        if (!isdefined(var_7cab8e12) && getdvarint(#"hash_5f50ef95773c29b5", 0)) {
            for (i = getdvarint(#"hash_5f50ef95773c29b5", 0); i > 0; i--) {
                dropitem = self function_d7944517(item.id, weapon, item.count, item.amount, stashitem, var_7cab8e12, targetname, isdefined(item.attachments) ? item.attachments : array());
            }
            return dropitem;
        }
    #/
    function_60706bdb(networkid);
    count = isdefined(item.count) ? item.count : 1;
    amount = isdefined(item.amount) ? item.amount : 0;
    removeonly = isdefined(item.endtime);
    var_337ff88 = self.inventory.items[8].networkid === networkid;
    if (self function_23335063(networkid, 0)) {
        if (var_337ff88 && var_4a6f595d) {
            function_d86d7ac7(stashitem, var_7cab8e12, targetname);
            function_ec238da8();
        }
        if (count > 0) {
            if (is_true(item.var_59361ab4)) {
                item.var_59361ab4 = 0;
            }
            item_inventory_util::function_6e9e7169(item);
            if (!removeonly) {
                weapon = item_inventory_util::function_2b83d3ff(item);
                dropitem = self function_d7944517(item.id, weapon, count, amount, stashitem, var_7cab8e12, targetname, isdefined(item.attachments) ? item.attachments : array(), stockammo, item.aat, item.paplv, immediately);
            } else {
                consumeditem = function_85645978(item);
                if (isdefined(consumeditem)) {
                    var_ee0e9af9 = [];
                    for (index = 0; index < 5; index++) {
                        inventoryitem = self.inventory.items[index];
                        if (!isdefined(inventoryitem.endtime)) {
                            continue;
                        }
                        if (inventoryitem.itementry.name == item.itementry.name) {
                            var_ee0e9af9[var_ee0e9af9.size] = inventoryitem;
                        }
                    }
                    remaining = consumeditem.endtime - gettime();
                    consumeditem.endtime -= remaining / (var_ee0e9af9.size + 1);
                    for (index = 0; index < var_ee0e9af9.size; index++) {
                        inventoryitem = var_ee0e9af9[index];
                        inventoryitem.starttime = consumeditem.starttime;
                        inventoryitem.endtime = consumeditem.endtime;
                    }
                }
            }
            if (isdefined(item.attachments)) {
                attachments = arraycopy(item.attachments);
                foreach (attachment in attachments) {
                    if (!isdefined(attachment)) {
                        continue;
                    }
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
// Checksum 0x9bd27388, Offset: 0x88f8
// Size: 0x20a
function equip_ammo(item, var_aec6fa7f) {
    assert(isplayer(self));
    assert(isdefined(item));
    self function_db2abc4(item);
    itementry = item.itementry;
    ammoweapon = itementry.weapon;
    ammoamount = isdefined(itementry.amount) ? itementry.amount : isdefined(var_aec6fa7f) ? var_aec6fa7f : 1;
    maxstockammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
    currentammostock = self getweaponammostock(ammoweapon);
    var_9b9ba643 = maxstockammo - currentammostock;
    addammo = int(min(ammoamount, var_9b9ba643));
    if (isdefined(ammoweapon) && ammoweapon != level.weaponnone) {
        self.inventory.ammo[ammoweapon.name] = item.id;
        self function_fc9f8b05(ammoweapon, addammo);
        if (isdefined(var_aec6fa7f)) {
            return (ammoamount - addammo);
        }
        return 0;
    }
    assertmsg("<dev string:x38>" + itementry.name + "<dev string:x56>");
    return ammoamount - addammo;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x52112792, Offset: 0x8b10
// Size: 0x196
function function_4cde30fa(inventoryitem, itementry) {
    if (game.state == #"pregame" || !isplayer(self) || isdefined(self.var_3f1410dd) || !isdefined(inventoryitem) || !isdefined(itementry)) {
        return;
    }
    self.var_3f1410dd = {#player_xuid:int(self getxuid(1)), #start_time:function_f8d53445(), #end_time:0, #var_4550558c:isdefined(inventoryitem.amount) ? inventoryitem.amount : 0, #tier:isdefined(itementry.armortier) ? itementry.armortier : 1, #damage_taken:0, #var_7352c057:0, #repair_amount:0, #broken:0, #died:0};
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x135ffdc5, Offset: 0x8cb0
// Size: 0xf6
function function_bef83dc6() {
    if (game.state == #"pregame" || !isplayer(self) || !isdefined(self.var_3f1410dd)) {
        return;
    }
    self.var_3f1410dd.broken = isdefined(self.armor) && self.armor <= 0;
    self.var_3f1410dd.died = isdefined(self.health) && self.health <= 0;
    self.var_3f1410dd.end_time = function_f8d53445();
    function_92d1707f(#"hash_3d5d9b3e2bc86b28", self.var_3f1410dd);
    self.var_3f1410dd = undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x7e7c7f07, Offset: 0x8db0
// Size: 0x29c
function equip_armor(item) {
    itementry = item.itementry;
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    self function_db2abc4(item);
    self armor::set_armor(inventoryitem.amount, isdefined(itementry.amount) ? itementry.amount : 0, isdefined(itementry.armortier) ? itementry.armortier : 1, isdefined(itementry.var_99c0cb08) ? itementry.var_99c0cb08 : 1, isdefined(itementry.var_2ee21ae6) ? itementry.var_2ee21ae6 : 1, isdefined(itementry.var_c690c73d) ? itementry.var_c690c73d : 1, isdefined(itementry.var_99edb6a3) ? itementry.var_99edb6a3 : 1, isdefined(itementry.var_22c3ab38) ? itementry.var_22c3ab38 : 1, isdefined(itementry.var_9f307988) ? itementry.var_9f307988 : 1, isdefined(itementry.var_7a80f06e) ? itementry.var_7a80f06e : 1, isdefined(itementry.explosivedamagescale) ? itementry.explosivedamagescale : 1, isdefined(itementry.var_f2902d7b) ? itementry.var_f2902d7b : 1, itementry.var_19f48bbe);
    self function_4cde30fa(inventoryitem, itementry);
    self.inventory.items[6] = inventoryitem;
    self function_b00db06(6, item.networkid);
    self clientfield::set_player_uimodel("hudItems.armorType", isdefined(itementry.armortier) ? itementry.armortier : 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x73913207, Offset: 0x9058
// Size: 0x8a
function function_e258cef5(networkid, itemtype) {
    if (networkid == 32767) {
        return undefined;
    }
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.itementry) || item.itementry.itemtype != itemtype) {
        return undefined;
    }
    return item;
}

// Namespace item_inventory/item_inventory
// Params 5, eflags: 0x0
// Checksum 0x11ff0b08, Offset: 0x90f0
// Size: 0x464
function equip_attachment(item, var_610add8d, var_d6f68de7, var_a3a17c55 = 1, switchweapon = 1) {
    assert(isplayer(self));
    assert(isstruct(item));
    var_4e2a1ed8 = function_e258cef5(var_610add8d, #"weapon");
    if (!isdefined(var_4e2a1ed8)) {
        return;
    }
    if (item_inventory_util::function_9e9c82a6(var_4e2a1ed8, item, 0)) {
        function_b3342af3(item, undefined, var_4e2a1ed8);
        offset = item_inventory_util::function_837f4a57(item.itementry);
        var_ac396b2f = get_weapon_slot(var_4e2a1ed8);
        if (!isdefined(var_ac396b2f)) {
            return;
        }
        var_dd6937a8 = item_inventory_util::function_dfaca25e(var_ac396b2f, offset);
        var_2134bf0d = self.inventory.items[var_dd6937a8];
        itemslotid = function_b246c573(item.networkid);
        if (!isdefined(itemslotid)) {
            return;
        }
        var_97cc940d = 0;
        if (isdefined(var_d6f68de7)) {
            var_3f6f5f3c = function_e258cef5(var_d6f68de7, #"weapon");
            var_2134bf0d = self.inventory.items[var_dd6937a8];
            if (isdefined(var_3f6f5f3c) && isdefined(var_2134bf0d) && isdefined(function_e258cef5(var_2134bf0d.networkid, #"attachment")) && function_f3195b3d(var_2134bf0d.networkid)) {
                var_97cc940d = 1;
            }
        }
        if (!var_97cc940d) {
            function_26c87da8(itemslotid, var_dd6937a8);
        }
        self function_b00db06(6, item.networkid);
        foreach (slot in array("attachSlotOptics", "attachSlotMuzzle", "attachSlotBarrel", "attachSlotUnderbarrel", "attachSlotBody", "attachSlotMagazine", "attachSlotHandle", "attachSlotStock")) {
            if (is_true(item.itementry.(slot))) {
                function_41a57271(var_4e2a1ed8, slot, undefined, item);
            }
        }
        function_d019bf1d(var_610add8d, undefined, undefined, 0);
        item_inventory_util::function_6e9e7169(var_4e2a1ed8);
        equip_weapon(var_4e2a1ed8, switchweapon, undefined, var_a3a17c55, 0);
        self function_db2abc4(item);
        if (var_97cc940d) {
            equip_attachment(var_2134bf0d, var_d6f68de7, undefined, var_a3a17c55, 1);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x3871bfd3, Offset: 0x9560
// Size: 0x16c
function equip_backpack(item) {
    assert(isplayer(self));
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    slotid = function_b246c573(item.networkid);
    if (!isdefined(slotid)) {
        return;
    }
    self function_db2abc4(item);
    function_26c87da8(slotid, 8);
    self.inventory.var_7658cbec = item_inventory_util::function_d8cebda3(item.itementry);
    if (self.inventory.var_7658cbec & 1) {
        self.inventory.var_c212de25 = 5;
    }
    self.inventory.items[8] = inventoryitem;
    self function_b00db06(6, item.networkid);
    self clientfield::set_player_uimodel("hudItems.hasBackpack", 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xd813306f, Offset: 0x96d8
// Size: 0xe4
function debug_print(message, weapon) {
    /#
        if (getdvarint(#"inventory_debug", 0) > 0) {
            weaponname = "<dev string:x5b>";
            if (isdefined(weapon)) {
                weaponname = "<dev string:x5f>" + function_9e72a96(weapon.name);
            }
            self iprintlnbold("<dev string:x6d>" + message + weaponname);
            println("<dev string:x6d>" + self.playername + "<dev string:x82>" + message + weaponname);
        }
    #/
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xff6c8d76, Offset: 0x97c8
// Size: 0x604
function equip_equipment(item) {
    self notify("1b436a45fda6d0ea");
    self endon("1b436a45fda6d0ea");
    assert(isplayer(self));
    while (isdefined(self) && is_true(self.var_10abd91d)) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    itemslotid = 7;
    switch (item.itementry.itemtype) {
    case #"field_upgrade":
        itemslotid = 12;
        break;
    case #"tactical":
        itemslotid = 13;
        break;
    }
    itementry = item.itementry;
    weapon = itementry.weapon;
    debug_print("equip_equipment:", weapon);
    equipmentitem = self.inventory.items[itemslotid];
    if (equipmentitem.id != 32767) {
        equippedweapon = function_b1702735(equipmentitem.id).itementry.weapon;
        if (isdefined(equippedweapon)) {
            slot = self gadgetgetslot(equippedweapon);
            if (slot >= 0 && slot < 3) {
                if (self gadgetisprimed(slot)) {
                    debug_print("equip_equipment: fail: GadgetIsPrimed", equippedweapon);
                    return;
                }
            }
            if (self function_c1cef1ec(equippedweapon)) {
                debug_print("equip_equipment: fail: offhand equipment in use", equippedweapon);
                return;
            }
            if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === equippedweapon) {
                debug_print("equip_equipment: fail: equipment waiting for removal", equippedweapon);
                return;
            }
            if (equipmentitem.networkid != item.networkid) {
                if (item_inventory_util::function_819781bf()) {
                    drop_inventory_item(equipmentitem.networkid);
                } else {
                    function_d019bf1d(equipmentitem.networkid);
                }
            }
        }
    }
    if (isdefined(weapon) && weapon != level.weaponnone) {
        self function_db2abc4(item);
        slotid = function_b246c573(item.networkid);
        if (isdefined(slotid) && slotid < self.inventory.var_c212de25) {
            function_26c87da8(slotid, itemslotid);
        }
        weaponoptions = undefined;
        var_e91aba42 = undefined;
        var_cbdeb265 = level.nullprimaryoffhand;
        switch (item.itementry.itemtype) {
        case #"tactical":
            var_cbdeb265 = level.nullsecondaryoffhand;
            break;
        case #"field_upgrade":
            var_cbdeb265 = level.var_3488e988;
            break;
        }
        self replace_weapon(var_cbdeb265, weapon, undefined, undefined, undefined, weaponoptions, var_e91aba42);
        self function_b00db06(6, item.networkid);
        for (i = 0; i < self.inventory.items.size; i++) {
            if (self.inventory.items[i].networkid === item.networkid) {
                if (weapon.gadget_type == 0) {
                    self setweaponammoclip(weapon, self.inventory.items[i].count);
                } else {
                    self function_c6be9f7f(weapon, self.inventory.items[i].count);
                }
                break;
            }
        }
        debug_print("equip_equipment: success", weapon);
        if (itemslotid == 7) {
            self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[itemslotid].itementry));
        }
        return;
    }
    assertmsg("<dev string:x88>" + itementry.name + "<dev string:x56>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xb8f75060, Offset: 0x9dd8
// Size: 0x50c
function equip_health(item) {
    self notify("78415141d8201ed3");
    self endon("78415141d8201ed3");
    assert(isplayer(self));
    while (isdefined(self) && is_true(self.var_10abd91d)) {
        waitframe(1);
    }
    if (!isdefined(item) || !isdefined(self)) {
        return;
    }
    itementry = item.itementry;
    weapon = itementry.weapon;
    debug_print("equip_health:", weapon);
    if (isdefined(self.var_d6cd7d80)) {
        debug_print("equip_health: fail: offhand equipment casting", self.var_d6cd7d80);
        return;
    }
    if (isdefined(self.var_e42fb511)) {
        debug_print("equip_health: fail: offhand equipment primed", self.var_e42fb511);
        return;
    }
    if (isdefined(self.inventory) && isdefined(self.inventory.items[5])) {
        var_b6edb3b2 = self.inventory.items[5].networkid;
    }
    if (isdefined(var_b6edb3b2) && var_b6edb3b2 != 32767) {
        var_2337367a = get_inventory_item(var_b6edb3b2);
        if (isdefined(var_2337367a)) {
            equippedweapon = item_inventory_util::function_2b83d3ff(var_2337367a);
            if (isdefined(equippedweapon)) {
                slot = self gadgetgetslot(equippedweapon);
                if (slot >= 0 && slot < 3) {
                    if (self gadgetisprimed(slot)) {
                        debug_print("equip_health: fail: GadgetIsPrimed", equippedweapon);
                        return;
                    }
                    if (self gadgetisactive(slot)) {
                        debug_print("equip_health: fail: GadgetIsActive", equippedweapon);
                        return;
                    }
                }
                if (self function_c1cef1ec(equippedweapon)) {
                    debug_print("equip_health: fail: offhand equipment in use", equippedweapon);
                    return;
                }
                if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === equippedweapon) {
                    debug_print("equip_health: fail: equipment waiting for removal", equippedweapon);
                    return;
                }
            }
        }
        if (var_2337367a.networkid != item.networkid) {
            function_d019bf1d(var_b6edb3b2);
        }
    }
    if (isdefined(weapon) && weapon != level.weaponnone) {
        self function_db2abc4(item);
        slotid = function_b246c573(item.networkid);
        if (isdefined(slotid) && slotid < self.inventory.var_c212de25) {
            function_26c87da8(slotid, 5);
        }
        self replace_weapon(level.var_ef61b4b5, weapon);
        self function_b00db06(6, item.networkid);
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(item.itementry));
        slot = self gadgetgetslot(weapon);
        if (slot >= 0 && slot < 3) {
            self function_19ed70ca(slot, 0);
        }
        debug_print("equip_health: success", weapon);
        self function_755a35c5();
        return;
    }
    assertmsg("<dev string:xb2>" + itementry.name + "<dev string:x56>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x6b02dbfe, Offset: 0xa2f0
// Size: 0x224
function function_854cf2c3(item) {
    self notify("73da13277280096c");
    self endon("73da13277280096c");
    assert(isplayer(self));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    itementry = item.itementry;
    weapon = itementry.weapon;
    slotid = function_b246c573(item.networkid);
    if (!isdefined(slotid)) {
        return;
    }
    perkslot = item_inventory_util::function_417ec8b9(itementry);
    if (!isdefined(perkslot)) {
        return;
    }
    self function_db2abc4(item);
    function_26c87da8(slotid, perkslot);
    if (item.itementry.name == #"hash_6ac2848a2f6492ac") {
        backpack = item_world_util::function_49ce7663(#"hash_6a677bcb21d4432b");
        var_fa3df96 = self function_e66dcff5(backpack);
        self item_world::function_de2018e3(backpack, self, var_fa3df96);
    }
    self.inventory.items[perkslot] = inventoryitem;
    self function_b00db06(6, item.networkid);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xc83784c1, Offset: 0xa520
// Size: 0x26c
function function_1ac37022(item, ammo) {
    self notify("13fd2f035ef32ebe");
    self endon("13fd2f035ef32ebe");
    assert(isplayer(self));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    itementry = item.itementry;
    weapon = itementry.weapon;
    slotid = function_b246c573(item.networkid);
    if (!isdefined(slotid)) {
        return;
    }
    var_f4cc972d = 17;
    self function_db2abc4(item);
    function_26c87da8(slotid, var_f4cc972d);
    self.inventory.items[var_f4cc972d] = inventoryitem;
    self function_b00db06(6, item.networkid);
    var_4fead4c7 = undefined;
    killstreakbundle = getscriptbundle(item.itementry.killstreak);
    if (is_true(item.itementry.var_ef70c5b3)) {
        var_4fead4c7 = killstreakbundle.var_fc0c8eae.name;
    } else {
        var_4fead4c7 = killstreakbundle.var_d3413870;
    }
    if (isdefined(var_4fead4c7)) {
        killstreaks::give(var_4fead4c7);
        if (isdefined(ammo) && isdefined(weapon) && weapon.name != #"ultimate_turret") {
            self setweaponammostock(weapon, ammo);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x2151285a, Offset: 0xa798
// Size: 0x402
function equip_item(networkid, quickequip = 0, weaponid = 0) {
    assert(isplayer(self));
    item = get_inventory_item(networkid);
    if (isdefined(item) && isdefined(item.itementry)) {
        if (is_true(item.itementry.consumable)) {
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
            if (weaponid == 0) {
                self equip_attachment(item, function_ec087745(), undefined, !quickequip, 1);
            } else {
                self equip_attachment(item, function_c3fb7a6e(), function_ec087745(), !quickequip, 0);
            }
            break;
        case #"backpack":
            self equip_backpack(item);
            break;
        case #"tactical":
        case #"equipment":
        case #"field_upgrade":
            self equip_equipment(item);
            break;
        case #"perk_tier_3":
        case #"perk_tier_2":
        case #"perk_tier_1":
            self function_854cf2c3(item);
            break;
        case #"scorestreak":
            self function_1ac37022(item);
            break;
        case #"generic":
        case #"cash":
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
            assertmsg("<dev string:xd9>" + (isdefined(item.itementry.itemtype) ? item.itementry.itemtype : "<dev string:xf4>") + "<dev string:x101>");
            return 0;
        }
        return 1;
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xbb176e16, Offset: 0xaba8
// Size: 0x26
function private can_switch_weapons() {
    if (self function_2cceca7b()) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0xea4dae40, Offset: 0xabd8
// Size: 0x8e
function private function_bf2312f1(weapon) {
    currentweapon = self getcurrentweapon();
    if (isdefined(currentweapon) && currentweapon != level.weaponnone && currentweapon == weapon) {
        if (self function_55acff10()) {
            return false;
        }
        if (self isfiring()) {
            return false;
        }
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 6, eflags: 0x0
// Checksum 0xa18aec68, Offset: 0xac70
// Size: 0xacc
function equip_weapon(item, switchweapon = 1, var_9fa01da8 = 0, var_a3a17c55 = 0, initialweaponraise = 0, stockammo) {
    assert(isplayer(self));
    itementry = item.itementry;
    itemtype = itementry.itemtype;
    assert(itemtype == #"weapon");
    currentweapon = level.weaponbasemeleeheld;
    var_68dc9720 = 17 + 1;
    var_6073ab7b = 0;
    if (function_bad4a3a5() == 2) {
        if (var_9fa01da8) {
            currentweapon = self getstowedweapon();
        } else {
            currentweapon = get_current_weapon();
        }
        foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
            var_b8c2759f = self.inventory.items[slotid];
            if (var_b8c2759f.networkid === 32767) {
                continue;
            }
            equippedweapon = item_inventory_util::function_2b83d3ff(var_b8c2759f);
            if (currentweapon == equippedweapon) {
                var_68dc9720 = slotid;
                function_60706bdb(var_b8c2759f.networkid);
                function_d019bf1d(var_b8c2759f.networkid);
                break;
            }
        }
        currentweapon = level.weaponbasemeleeheld;
    } else {
        if (function_bad4a3a5() == 0) {
            if (self function_8b1a219a() && (self getcurrentweapon() != level.weaponnone || self getcurrentweapon() != currentweapon)) {
                var_6073ab7b = 1;
            } else {
                currentweapon = level.weaponnone;
            }
        }
        var_68dc9720 = undefined;
        foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
            if (self.inventory.items[slotid].networkid === item.networkid) {
                var_68dc9720 = slotid;
                break;
            }
        }
        if (!isdefined(var_68dc9720)) {
            foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
                if (self.inventory.items[slotid].networkid === 32767) {
                    var_68dc9720 = slotid;
                    break;
                }
            }
        }
    }
    weapon = item_inventory_util::function_2b83d3ff(item);
    if (isdefined(weapon) && weapon != level.weaponnone) {
        var_346dc077 = self getweaponammostock(weapon);
        item.var_59361ab4 = slotid == 17 + 1 + 8 + 1;
        item_inventory_util::function_6e9e7169(item);
        weapon = item_inventory_util::function_2b83d3ff(item);
        slotid = function_b246c573(item.networkid);
        if (!isdefined(slotid)) {
            return;
        }
        self function_26c87da8(slotid, var_68dc9720);
        if (initialweaponraise && !isdefined(item.weaponoptions) && !isdefined(item.var_e91aba42)) {
            weaponoptions = undefined;
            var_e91aba42 = undefined;
            if (isdefined(getgametypesetting(#"wzrandomcamo")) ? getgametypesetting(#"wzrandomcamo") : 0) {
                renderoptions = function_ea647602("camo", weapon);
                if (renderoptions.size > 0) {
                    var_9412af4a = randomint(renderoptions.size);
                    weaponoptions = self function_6eff28b5(renderoptions[var_9412af4a].item_index, 0, 0);
                }
            } else {
                buildkitweapon = activecamo::function_b259f3e0(weapon);
                weaponoptions = self getbuildkitweaponoptions(buildkitweapon);
                var_e91aba42 = self function_1744e243(buildkitweapon);
            }
            if (weaponoptions != self getbuildkitweaponoptions(level.weaponnone)) {
                item.weaponoptions = weaponoptions;
            }
            if (var_e91aba42 != self function_1744e243(level.weaponnone)) {
                item.var_e91aba42 = var_e91aba42;
            }
        }
        item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
        self replace_weapon(currentweapon, weapon, 1, initialweaponraise, var_a3a17c55, item.weaponoptions, item.var_e91aba42);
        if (var_6073ab7b) {
            self replace_weapon(level.weaponnone, level.weaponbasemeleeheld);
        }
        self function_b00db06(6, item.networkid);
        inventoryitem = get_inventory_item(item.networkid);
        if (!isdefined(inventoryitem)) {
            return;
        }
        if (weapon !== currentweapon) {
            var_b917b36f = int(min(var_346dc077, weapon.clipsize));
            self function_fc9f8b05(weapon, var_b917b36f);
        }
        var_954e19c7 = get_weapon_count();
        if (var_a3a17c55) {
            self function_c9a111a(weapon);
        } else {
            self shoulddoinitialweaponraise(weapon, initialweaponraise);
        }
        self setweaponammoclip(weapon, int(inventoryitem.amount));
        if (switchweapon || var_954e19c7 == 1) {
            if (self can_switch_weapons()) {
                self switchtoweapon(weapon, 1);
                self.currentweapon = weapons::function_251ec78c(weapon, 0);
            }
        }
        var_4f8a16ec = getgametypesetting(#"hash_b76e50c1202aa23");
        if (!var_4f8a16ec) {
            if (!isdefined(stockammo)) {
                self setweaponammostock(weapon, weapon.maxammo);
            } else {
                self setweaponammostock(weapon, stockammo);
            }
        }
        self function_db2abc4(item);
        return;
    }
    assertmsg("<dev string:x12a>" + itementry.name + "<dev string:x56>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xafe8bc42, Offset: 0xb748
// Size: 0x162
function function_ec087745(var_75e3ca7a = 0) {
    assert(isplayer(self));
    if (!isdefined(self) || !isplayer(self)) {
        return 32767;
    }
    weapon = get_current_weapon();
    if (!var_75e3ca7a && self isswitchingweapons() && isdefined(self.next_weapon) && self.next_weapon != level.weaponnone && self.next_weapon != level.weaponbasemeleeheld) {
    }
    networkid = function_a33744de(weapon);
    if (self isswitchingweapons() && networkid == 32767) {
        networkid = function_a33744de(get_current_weapon());
    }
    return networkid;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xb1bfacda, Offset: 0xb8b8
// Size: 0x150
function function_c3fb7a6e() {
    assert(isplayer(self));
    var_53c16cb = self function_ec087745();
    foreach (weaponslot in array(17 + 1, 17 + 1 + 8 + 1)) {
        item = self.inventory.items[weaponslot];
        if (!isdefined(item) || item.networkid === 32767 || var_53c16cb === item.networkid) {
            continue;
        }
        return item.networkid;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x6d865530, Offset: 0xba10
// Size: 0x1a
function get_current_weapon() {
    return weapons::function_251ec78c(self.currentweapon, 0);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xa9d888ab, Offset: 0xba38
// Size: 0x72
function function_d768ea30() {
    assert(isplayer(self));
    networkid = self function_ec087745();
    if (networkid === 32767) {
        return;
    }
    return item_world_util::function_808be9a3(networkid);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xf7993548, Offset: 0xbab8
// Size: 0x116
function function_bad4a3a5() {
    assert(isplayer(self));
    weaponcount = 0;
    weapons = self getweaponslistprimaries();
    foreach (weapon in weapons) {
        if (is_true(weapon.var_29d24e37)) {
            continue;
        }
        if (weapon != level.weaponnone && weapon != level.weaponbasemeleeheld) {
            weaponcount++;
        }
    }
    return weaponcount;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x8ce8a418, Offset: 0xbbd8
// Size: 0x9a
function function_777cc133() {
    assert(isplayer(self));
    if (item_inventory_util::function_819781bf()) {
        return;
    }
    for (index = 0; index < self.inventory.var_c212de25; index++) {
        if (self.inventory.items[index].networkid == 32767) {
            return index;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xc86ba3a4, Offset: 0xbc80
// Size: 0x7c
function function_2e711614(slotid) {
    assert(isplayer(self));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.inventory)) {
        return;
    }
    if (!isdefined(self.inventory.items)) {
        return;
    }
    return self.inventory.items[slotid];
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xa268a8d, Offset: 0xbd08
// Size: 0x1be
function function_230ceec4(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.inventory)) {
        return;
    }
    if (!isdefined(self.inventory.items)) {
        return;
    }
    foreach (weaponslot in array(5, 6, 12, 7, 13, 8, 17 + 1, 17 + 1 + 8 + 1, 14, 15, 16, 17)) {
        item = self.inventory.items[weaponslot];
        if (!isdefined(item)) {
            continue;
        }
        if (item.networkid === 32767) {
            continue;
        }
        if (item_inventory_util::function_2b83d3ff(item) === weapon) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xd3e9887d, Offset: 0xbed0
// Size: 0x96
function function_a33744de(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    weaponitem = function_230ceec4(weapon);
    return isdefined(weaponitem) ? weaponitem.networkid : 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x173878de, Offset: 0xbf70
// Size: 0xb6
function function_b246c573(networkid) {
    assert(isplayer(self));
    assert(item_world_util::function_db35e94f(networkid));
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            return i;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xb47fd380, Offset: 0xc030
// Size: 0xde
function get_inventory_item(networkid) {
    assert(isint(networkid) && networkid != 32767);
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.inventory)) {
        return;
    }
    if (!isdefined(self.inventory.items)) {
        return;
    }
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            return self.inventory.items[i];
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x66f8101f, Offset: 0xc118
// Size: 0x162
function function_8babc9f9(itementry) {
    assert(isplayer(self));
    name = isdefined(itementry.parentname) ? itementry.parentname : itementry.name;
    if (!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items)) {
        return undefined;
    }
    for (index = 0; index < self.inventory.items.size && index < 17 + 1; index++) {
        inventoryitem = self.inventory.items[index];
        if (!isdefined(inventoryitem.itementry)) {
            continue;
        }
        if (name == (isdefined(inventoryitem.itementry.parentname) ? inventoryitem.itementry.parentname : inventoryitem.itementry.name)) {
            return inventoryitem;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x1ce58c7f, Offset: 0xc288
// Size: 0x94
function function_c48cd17f(networkid) {
    assert(isplayer(self));
    assert(item_world_util::function_d9648161(networkid));
    item = get_inventory_item(networkid);
    if (isdefined(item)) {
        return item.id;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x2c1ef0c3, Offset: 0xc328
// Size: 0x94
function function_189a93f8(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    item = function_230ceec4(weapon);
    if (isdefined(item)) {
        return item.id;
    }
    return 32767;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xc253ab20, Offset: 0xc3c8
// Size: 0x110
function get_weapon_count() {
    assert(isplayer(self));
    if (!isdefined(self.inventory)) {
        return 0;
    }
    weaponcount = 0;
    foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
        if (self.inventory.items[slotid].networkid != 32767) {
            weaponcount++;
        }
    }
    return weaponcount;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x6e28491d, Offset: 0xc4e0
// Size: 0xea
function get_weapon_slot(item) {
    if (item.networkid === 32767) {
        return;
    }
    foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
        if (self.inventory.items[slotid].networkid == item.networkid) {
            return slotid;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x7e9b4def, Offset: 0xc5d8
// Size: 0x356
function function_3f7ef88() {
    assert(isplayer(self));
    if (!isplayer(self) || !isalive(self)) {
        return;
    }
    item_world::function_1b11e73c();
    while (isdefined(self) && !isdefined(self.inventory)) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    pistol = function_4ba8fde(#"pistol_standard_t8_item");
    var_fa3df96 = self function_e66dcff5(pistol);
    if (!isdefined(pistol)) {
        return;
    }
    pistol.attachments = [];
    attachment = function_4ba8fde(#"fastmag_wz_item");
    var_e38a0464 = function_520b16d6();
    var_e38a0464.count = 1;
    var_e38a0464.id = attachment.id;
    var_e38a0464.networkid = var_e38a0464.id;
    var_e38a0464.itementry = attachment.itementry;
    item_inventory_util::function_9e9c82a6(pistol, attachment);
    attachment = function_4ba8fde(#"reflex_wz_item");
    var_e38a0464 = function_520b16d6();
    var_e38a0464.count = 1;
    var_e38a0464.id = attachment.id;
    var_e38a0464.networkid = var_e38a0464.id;
    var_e38a0464.itementry = attachment.itementry;
    item_inventory_util::function_9e9c82a6(pistol, attachment);
    pistol.amount = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(pistol));
    self item_world::function_de2018e3(pistol, self, var_fa3df96);
    ammo = function_4ba8fde(#"ammo_small_caliber_item_t9");
    var_fa3df96 = self function_e66dcff5(ammo);
    self item_world::function_de2018e3(ammo, self, var_fa3df96);
    health = function_4ba8fde(#"health_item_small");
    health.count = 5;
    var_fa3df96 = self function_e66dcff5(health);
    self item_world::function_de2018e3(health, self, var_fa3df96);
    self.var_554ec2e2 = undefined;
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x727e1f80, Offset: 0xc938
// Size: 0xe98
function give_inventory_item(item, itemcount = 1, var_aec6fa7f = 0, slotid = undefined) {
    if (!isplayer(self) || !isdefined(self.inventory)) {
        assert(0, "<dev string:x14b>");
        return 0;
    }
    if (!isdefined(item)) {
        assert(0, "<dev string:x185>");
        return 0;
    }
    itementry = item.itementry;
    itemid = item.id;
    if (isdefined(item.itementry.actionregisterweapon)) {
        actionregisterweapon = getscriptbundle(item.itementry.actionregisterweapon);
        if (isdefined(actionregisterweapon)) {
            itementry = actionregisterweapon;
        }
        var_8c36ae16 = function_4ba8fde(item.itementry.actionregisterweapon);
        if (isdefined(var_8c36ae16)) {
            itemid = var_8c36ae16.id;
        }
    }
    maxstacksize = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, item.itementry);
    var_1393d318 = maxstacksize > 1;
    if (item.itementry.itemtype == #"resource" && item_world_util::function_41f06d9d(item.itementry)) {
        var_92d652f2 = self.inventory.items[slotid];
        var_b41045b2 = int(max(150 - self stats::get_stat_global(#"items_paint_cans_collected"), 0));
        maxstacksize = var_b41045b2 + (isdefined(var_92d652f2.count) ? var_92d652f2.count : 0);
    }
    if (isdefined(itementry.name) && var_1393d318) {
        for (i = 0; i < self.inventory.items.size; i++) {
            if (self.inventory.items[i].id != 32767) {
                if (self.inventory.items[i].itementry.name != itementry.name) {
                    continue;
                }
                var_35f34839 = maxstacksize - self.inventory.items[i].count;
                if (var_35f34839 <= 0) {
                    continue;
                }
                var_8c6165fc = int(min(itemcount, var_35f34839));
                self.inventory.items[i].count = self.inventory.items[i].count + var_8c6165fc;
                item.networkid = self.inventory.items[i].networkid;
                self function_b00db06(9, self.inventory.items[i].networkid, self.inventory.items[i].count);
                if (i == 5) {
                    self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(self.inventory.items[i].itementry));
                } else if (i == 7) {
                    self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[i].itementry));
                }
                inventoryweapon = item_inventory_util::function_2b83d3ff(self.inventory.items[i]);
                if (isdefined(inventoryweapon)) {
                    self function_c6be9f7f(inventoryweapon, self.inventory.items[i].count);
                }
                itemcount -= var_8c6165fc;
                assert(itemcount >= 0);
                if (itemcount <= 0) {
                    self function_b00db06(4, itemid, 0);
                    self function_755a35c5();
                    self function_6c36ab6b();
                    self function_a4413333();
                    self function_1caf5c88();
                    return 0;
                }
            }
        }
    }
    if (isdefined(slotid)) {
        var_92d652f2 = undefined;
        if (slotid < self.inventory.items.size) {
            var_92d652f2 = self.inventory.items[slotid];
        }
        assert(isdefined(var_92d652f2));
        if (var_92d652f2.networkid == 32767) {
            var_8c6165fc = int(min(itemcount, maxstacksize));
            item.networkid = item_world_util::function_970b8d86(slotid);
            item_inventory_util::function_6e9e7169(item);
            var_92d652f2.amount = var_aec6fa7f;
            var_92d652f2.count = var_8c6165fc;
            var_92d652f2.id = itemid;
            var_92d652f2.networkid = item.networkid;
            var_92d652f2.itementry = itementry;
            var_92d652f2.starttime = undefined;
            var_92d652f2.endtime = undefined;
            var_92d652f2.weaponoptions = undefined;
            var_92d652f2.var_e91aba42 = undefined;
            self function_b00db06(4, item.id, var_8c6165fc, slotid + 1);
            itemcount -= var_8c6165fc;
            assert(itemcount >= 0);
            if (itemcount <= 0) {
                if (isdefined(item.attachments)) {
                    foreach (attachmentitem in item.attachments) {
                        if (!isdefined(attachmentitem)) {
                            continue;
                        }
                        var_769a94ae = item_inventory_util::function_837f4a57(attachmentitem.itementry);
                        if (!isdefined(var_769a94ae)) {
                            continue;
                        }
                        var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, var_769a94ae);
                        give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
                        attachmentitem = get_inventory_item(attachmentitem.networkid);
                        item_inventory_util::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
                    }
                    item_inventory_util::function_6e9e7169(var_92d652f2);
                } else if (isdefined(itementry.attachments)) {
                    if (item_inventory_util::function_4bd83c04(item)) {
                        foreach (attachment in itementry.attachments) {
                            if (!item_world_util::function_7363384a(attachment.attachment_type)) {
                                continue;
                            }
                            attachmentitem = function_4ba8fde(attachment.attachment_type);
                            if (!isdefined(attachmentitem)) {
                                continue;
                            }
                            var_769a94ae = item_inventory_util::function_837f4a57(attachmentitem.itementry);
                            if (!isdefined(var_769a94ae)) {
                                continue;
                            }
                            var_f9f8c0b5 = item_inventory_util::function_dfaca25e(slotid, var_769a94ae);
                            give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
                            attachmentitem = get_inventory_item(attachmentitem.networkid);
                            item_inventory_util::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
                        }
                        item_inventory_util::function_6e9e7169(var_92d652f2);
                        weapon = item_inventory_util::function_2b83d3ff(var_92d652f2);
                        if (isdefined(weapon)) {
                            var_92d652f2.amount = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(var_92d652f2));
                        }
                    }
                }
                var_92d652f2.weaponoptions = item.weaponoptions;
                var_92d652f2.var_e91aba42 = item.var_e91aba42;
                var_92d652f2.var_1181c08b = item.var_1181c08b;
                self function_755a35c5();
                self function_6c36ab6b();
                self function_a4413333();
                self function_1caf5c88();
                return 0;
            }
        }
        if ((slotid === 9 || slotid === 10 || slotid == 11) && var_92d652f2.networkid != 32767) {
            return itemcount;
        }
    }
    if (!item_inventory_util::function_819781bf()) {
        for (i = 0; i < self.inventory.var_c212de25; i++) {
            if (self.inventory.items[i].networkid === 32767) {
                var_8c6165fc = int(min(itemcount, maxstacksize));
                item.networkid = item_world_util::function_970b8d86(i);
                self.inventory.items[i].amount = var_aec6fa7f;
                self.inventory.items[i].count = var_8c6165fc;
                self.inventory.items[i].id = itemid;
                self.inventory.items[i].networkid = item.networkid;
                self.inventory.items[i].itementry = itementry;
                self.inventory.items[i].starttime = undefined;
                self.inventory.items[i].endtime = undefined;
                self.inventory.items[i].var_1181c08b = item.var_1181c08b;
                item_inventory_util::function_6e9e7169(self.inventory.items[i]);
                self function_b00db06(4, item.id, var_8c6165fc, i + 1);
                itemcount -= var_8c6165fc;
                assert(itemcount >= 0);
                if (itemcount <= 0) {
                    break;
                }
            }
        }
    } else {
        itemcount = 0;
    }
    self function_755a35c5();
    self function_6c36ab6b();
    self function_a4413333();
    self function_1caf5c88();
    return itemcount;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x9714c02d, Offset: 0xd7d8
// Size: 0x134
function function_461de298() {
    assert(isplayer(self));
    if (!(isdefined(getgametypesetting(#"wzlootlockers")) ? getgametypesetting(#"wzlootlockers") : 0)) {
        return;
    }
    if (!isplayer(self)) {
        return;
    }
    var_73869e24 = function_4ba8fde(#"resource_item_loot_locker_key");
    lootweapons = self item_inventory_util::get_loot_weapons();
    var_51c5992 = min(lootweapons.size, 2);
    if (var_51c5992 > 0) {
        self give_inventory_item(var_73869e24, var_51c5992, 0, 10);
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x6a302c88, Offset: 0xd918
// Size: 0x5c
function function_44f1ab43() {
    assert(isplayer(self));
    self function_461de298();
    /#
        self thread function_76eb9bd7();
    #/
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x1c1fe534, Offset: 0xd980
// Size: 0xe6
function has_armor() {
    assert(isplayer(self));
    if (!isdefined(self)) {
        return 0;
    }
    if (!isdefined(self.inventory)) {
        return 0;
    }
    if (!isdefined(self.inventory.items)) {
        return 0;
    }
    if (!isdefined(self.inventory.items[6])) {
        return 0;
    }
    hasarmor = self.inventory.items[6].networkid != 32767 && self.inventory.items[6].itementry.itemtype == #"armor";
    return hasarmor;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xa48e0c4a, Offset: 0xda70
// Size: 0xd6
function has_backpack() {
    assert(isplayer(self));
    hasbackpack = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[8]) && isdefined(self.inventory.items[8].itementry) && self.inventory.items[8].itementry.itemtype == #"backpack";
    return hasbackpack;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x4b3f17d1, Offset: 0xdb50
// Size: 0x10e
function function_471897e2() {
    assert(isplayer(self));
    var_22939dc4 = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[10]) && isdefined(self.inventory.items[10].itementry) && self.inventory.items[10].itementry.itemtype == #"resource" && self.inventory.items[10].itementry.name == #"resource_item_loot_locker_key";
    return var_22939dc4;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xfeeae8de, Offset: 0xdc68
// Size: 0x102
function function_7fe4ce88(item_name) {
    assert(isplayer(self));
    if (!isdefined(self.inventory)) {
        return undefined;
    }
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_b74300d3 = item_world_util::get_itemtype(item.itementry);
        if (item_name == var_b74300d3) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xb0216571, Offset: 0xdd78
// Size: 0x72
function has_inventory_item(slotid) {
    assert(isplayer(self));
    return isdefined(self.inventory.items[slotid]) && self.inventory.items[slotid].networkid != 32767;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xac997a78, Offset: 0xddf8
// Size: 0x13c
function init_inventory() {
    if (function_7d5553ac()) {
        return;
    }
    assert(isplayer(self));
    self.inventory = spawnstruct();
    self.inventory.items = [];
    for (i = 0; i < 17 + 1 + 8 + 1 + 8 + 1; i++) {
        self.inventory.items[i] = function_520b16d6();
    }
    self.inventory.ammo = [];
    self.inventory.consumed = [];
    self.inventory.var_c212de25 = 3;
    self.inventory.var_7658cbec = 0;
    self.inventory.var_a0290b96 = [];
    self function_85287396(0);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xfb1d14c1, Offset: 0xdf40
// Size: 0x1a
function function_fe402108() {
    return is_true(self.var_11921c74);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x17bf53a7, Offset: 0xdf68
// Size: 0x9c
function function_e7af31c6(slotid) {
    assert(isplayer(self));
    assert(slotid >= 0 && slotid < 17 + 1 + 8 + 1 + 8 + 1);
    return self.inventory.items[slotid].networkid != 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xe5162e07, Offset: 0xe010
// Size: 0x2dc
function function_f3195b3d(networkid) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    foreach (slot in array(5, 6, 12, 7, 13, 8, 17 + 1, 17 + 1 + 8 + 1, 14, 15, 16, 17)) {
        if (self.inventory.items[slot].networkid === networkid) {
            return true;
        }
    }
    foreach (weaponid in array(17 + 1, 17 + 1 + 8 + 1)) {
        foreach (attachmentoffset in array(1, 2, 3, 4, 5, 6, 7, 8)) {
            attachmentid = item_inventory_util::function_dfaca25e(weaponid, attachmentoffset);
            if (self.inventory.items[attachmentid].networkid === networkid) {
                return true;
            }
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x5775e7ec, Offset: 0xe2f8
// Size: 0xe4
function function_7b39c6f9(params) {
    if (!isdefined(params) || !isdefined(params.player)) {
        return;
    }
    if (!isdefined(params.player.inventory)) {
        return;
    }
    item = params.player.inventory.items[17];
    if (item.networkid == 32767) {
        return;
    }
    killstreakbundle = getscriptbundle(item.itementry.killstreak);
    if (killstreakbundle.var_d3413870 == params.killstreaktype) {
        use_inventory_item(item.networkid, 1);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x99995120, Offset: 0xe3e8
// Size: 0x1f2
function function_db2abc4(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    if (isdefined(item) && isdefined(item.itementry)) {
        if (is_true(item.itementry.consumable)) {
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
        case #"field_upgrade":
            break;
        case #"tactical":
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
// Params 3, eflags: 0x0
// Checksum 0x9b74b127, Offset: 0xe5e8
// Size: 0x284
function function_a24d6e36(networkid, notifyclient = 1, var_cda2ff12 = 1) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    self endon(#"death");
    itemid = function_c48cd17f(networkid);
    if (itemid == 32767) {
        return 0;
    }
    item = get_inventory_item(networkid);
    weapon = item_inventory_util::function_2b83d3ff(item);
    if (isdefined(weapon)) {
        self.var_6d2ad74f = weapon;
        slot = self gadgetgetslot(weapon);
        if (slot >= 0 && slot < 3) {
            self function_19ed70ca(slot, 1);
            self gadgetpowerset(slot, 0);
        }
        while (isdefined(self) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon) || self isremotecontrolling())) {
            waitframe(1);
        }
    }
    if (item.count > 0 && isdefined(weapon)) {
        self function_19ed70ca(slot, 0);
        self gadgetpowerset(slot, weapon.gadget_powermax);
        return;
    }
    self remove_inventory_item(networkid, 0, notifyclient, var_cda2ff12);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x4
// Checksum 0x2e9be971, Offset: 0xe878
// Size: 0x204
function private function_eb70ad46(networkid, notifyclient = 1, var_cda2ff12 = 1) {
    item = get_inventory_item(networkid);
    weapon = item_inventory_util::function_2b83d3ff(item);
    itementry = item.itementry;
    self.inventory.items[8] = function_520b16d6();
    self.inventory.var_c212de25 = 3;
    self.inventory.var_7658cbec = 0;
    if (notifyclient) {
        self function_b00db06(5, networkid);
    }
    function_9d805044(itementry.itemtype, itementry);
    if (var_cda2ff12) {
        for (index = self.inventory.var_c212de25; index < 5; index++) {
            inventoryitem = self.inventory.items[index];
            if (inventoryitem.networkid != 32767) {
                remove_inventory_item(inventoryitem.networkid);
            }
        }
    }
    if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon) {
        self.var_6d2ad74f = undefined;
    }
    debug_print("remove_inventory_item: Success!", weapon);
    self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0x7e2c789, Offset: 0xea88
// Size: 0x4de
function remove_inventory_item(networkid, var_dfe6c7e5 = 0, notifyclient = 1, var_cda2ff12 = 1) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    itemid = function_c48cd17f(networkid);
    if (itemid == 32767) {
        debug_print("remove_inventory_item: failed! No ItemId");
        return false;
    }
    item = get_inventory_item(networkid);
    weapon = item_inventory_util::function_2b83d3ff(item);
    itementry = item.itementry;
    if (isdefined(self) && isdefined(weapon) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
        debug_print("remove_inventory_item: failed! Weapon in Use");
        return false;
    }
    if (self.inventory.items[8].networkid === networkid) {
        function_eb70ad46(networkid, notifyclient, var_cda2ff12);
        return true;
    }
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === networkid) {
            unequipped = self function_d019bf1d(networkid, var_dfe6c7e5, notifyclient, var_cda2ff12);
            self.inventory.items[i] = function_520b16d6();
            if (self function_8b1a219a()) {
                if (isdefined(array::find(array(17 + 1, 17 + 1 + 8 + 1), i)) && get_weapon_count() == 0) {
                    self sortheldweapons();
                }
            }
            self function_755a35c5();
            self function_6c36ab6b();
            self function_a4413333();
            self function_1caf5c88();
            if (notifyclient) {
                self function_b00db06(5, networkid);
            }
            if (i == 5) {
                self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
            } else if (i == 7) {
                self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
            }
            if (unequipped) {
                function_9d805044(itementry.itemtype, itementry);
            }
            if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon) {
                self.var_6d2ad74f = undefined;
            }
            if (itementry.itemtype == #"cash") {
                self function_3d113bfb();
            }
            debug_print("remove_inventory_item: Success!", weapon);
            return true;
        }
        if (!isdefined(self.inventory)) {
            return false;
        }
    }
    debug_print("remove_inventory_item: Failed!", weapon);
    return false;
}

// Namespace item_inventory/item_inventory
// Params 7, eflags: 0x0
// Checksum 0x60461914, Offset: 0xef70
// Size: 0x26e
function replace_weapon(old_weapon, new_weapon, primary_weapon = 0, var_e47b0bf = 1, var_6086c488 = 0, options = undefined, var_f879230e = undefined) {
    assert(isdefined(old_weapon));
    assert(isdefined(new_weapon));
    if (isdefined(old_weapon) && old_weapon != level.weaponnone) {
        var_6ac5075d = 1;
        if (old_weapon == level.nullprimaryoffhand || old_weapon == level.nullsecondaryoffhand || old_weapon == level.var_3488e988) {
            if (new_weapon.gadget_type == 0 && (new_weapon.inventorytype == "offhand" || new_weapon.inventorytype == "offhand_primary" || new_weapon.inventorytype == "ability")) {
                var_6ac5075d = 0;
            }
        }
        if (var_6ac5075d) {
            self replaceweapon(old_weapon, 0, new_weapon, options, var_f879230e);
            self takeweapon(old_weapon);
        } else {
            self giveweapon(new_weapon, options, var_f879230e);
        }
    } else {
        self giveweapon(new_weapon, options, var_f879230e);
    }
    if (var_6086c488) {
        self function_c9a111a(new_weapon);
    } else {
        self shoulddoinitialweaponraise(new_weapon, var_e47b0bf);
    }
    if (primary_weapon && self isinvehicle()) {
        self.currentweapon = new_weapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xbd33e7d1, Offset: 0xf1e8
// Size: 0x22
function function_85287396(enabled) {
    if (isdefined(self)) {
        self.var_11921c74 = enabled;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xa99c1beb, Offset: 0xf218
// Size: 0x39e
function function_fba4a353(item) {
    if (!isplayer(self) || !isdefined(self.inventory)) {
        assert(0, "<dev string:x14b>");
        return;
    }
    assert(isdefined(item));
    if (item_inventory_util::function_819781bf()) {
        return 1;
    }
    if (1 && isdefined(item) && isdefined(item.itementry)) {
        slotid = undefined;
        switch (item.itementry.itemtype) {
        case #"armor":
            slotid = 6;
            break;
        case #"backpack":
            slotid = 8;
            break;
        case #"equipment":
            slotid = 7;
            break;
        case #"field_upgrade":
            slotid = 12;
            break;
        case #"tactical":
            slotid = 13;
            break;
        case #"health":
            slotid = 5;
            break;
        case #"weapon":
            slotid = array(17 + 1, 17 + 1 + 8 + 1);
            break;
        case #"perk_tier_1":
            slotid = 14;
            break;
        case #"perk_tier_2":
            slotid = 15;
            break;
        case #"perk_tier_3":
            slotid = 16;
            break;
        case #"scorestreak":
            slotid = 17;
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
                return 0;
            }
        } else if (self.inventory.items[slotid].networkid !== 32767 && self.inventory.items[slotid].networkid !== item.networkid) {
            return 0;
        }
        return 1;
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x46b63552, Offset: 0xf5c0
// Size: 0x1b4
function function_ecd1c667(itemid, count) {
    assert(isplayer(self));
    assert(item_world_util::function_2c7fc531(itemid));
    self endon(#"death");
    item = function_b1702735(itemid);
    assert(item.itementry.itemtype == #"ammo");
    weapon = item.itementry.weapon;
    maxammo = self getweaponammostock(weapon);
    count = int(min(isdefined(count) ? count : maxammo, maxammo));
    if (count <= 0) {
        return;
    }
    self function_fc9f8b05(weapon, count * -1);
    self function_d7944517(item.id, item.itementry.weapon, 1, count);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x26526070, Offset: 0xf780
// Size: 0x20c
function function_cfe0e919(networkid, count) {
    assert(isplayer(self));
    assert(isint(count) && count > 0);
    self endon(#"death");
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.itementry)) {
        return;
    }
    var_aa3af497 = self.inventory.items[7].networkid == networkid || self.inventory.items[12].networkid == networkid;
    if (var_aa3af497 && isdefined(self.var_8181d952) && self.var_8181d952 == item.itementry.weapon) {
        if (item.count == count) {
            count--;
        }
    }
    count = int(min(item.count, count));
    if (count <= 0) {
        return;
    }
    weapon = item.itementry.weapon;
    self function_d7944517(item.id, item.itementry.weapon, count, 0);
    self use_inventory_item(networkid, count);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xd4dbf99b, Offset: 0xf998
// Size: 0x4e
function function_23335063(networkid, var_cda2ff12 = 1) {
    if (!self remove_inventory_item(networkid, undefined, undefined, var_cda2ff12)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xf97cf30a, Offset: 0xf9f0
// Size: 0x134
function function_c4468806(player, item) {
    if (game.state == #"pregame" || !isdefined(item)) {
        return;
    }
    data = {#game_time:function_f8d53445(), #player_xuid:int(player getxuid(1)), #item:hash(item.itementry.name)};
    println("<dev string:x1ba>" + item.itementry.name);
    function_92d1707f(#"hash_50be59ef12074ce", data);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x6af91300, Offset: 0xfb30
// Size: 0x244
function function_394d85cd() {
    assert(isplayer(self));
    var_13339abf = isdefined(level.var_13339abf) ? level.var_13339abf : array(#"ammo_small_caliber_item_t9", #"ammo_large_caliber_item_t9", #"ammo_ar_item_t9", #"ammo_sniper_item_t9", #"ammo_shotgun_item_t9", #"ammo_special_item_t9");
    var_c2043143 = array(2, 4, 8, 16, 32, 64);
    for (index = 0; index < var_13339abf.size; index++) {
        if (self.inventory.var_7658cbec & var_c2043143[index]) {
            continue;
        }
        ammoitem = var_13339abf[index];
        var_f415ce36 = getscriptbundle(ammoitem);
        weapon = var_f415ce36.weapon;
        assert(isdefined(weapon));
        if (!isdefined(weapon)) {
            continue;
        }
        maxammo = item_inventory_util::function_2879cbe0(self.inventory.var_7658cbec, weapon);
        var_346dc077 = self getweaponammostock(weapon);
        if (var_346dc077 > maxammo) {
            var_f580278d = function_4ba8fde(ammoitem).id;
            function_ecd1c667(var_f580278d, var_346dc077 - maxammo);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x928804b4, Offset: 0xfd80
// Size: 0x6ec
function function_a2c7ce35() {
    assert(isplayer(self));
    var_3e9ef0a1 = array(array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de"), array(#"swat_grenade_wz_item", #"hash_676aa70930960427", #"concussion_wz_item", #"concussion_t9_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"smoke_t9_item", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"hash_5f67f7b32b01ae53", #"hash_725e305ff465e73d", #"concussion_t9_item_sr", #"cymbal_monkey_t9_item_sr", #"hash_76ebb51bb24696a1", #"hash_51f70aff8a2ad330", #"stimshot_t9_item_sr"), array(#"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"));
    var_c77511ea = array(2048, 4096, 8192);
    var_710be50e = array(7);
    for (itemindex = 0; itemindex < 5; itemindex++) {
        var_710be50e[var_710be50e.size] = itemindex;
    }
    for (equipmenttype = 0; equipmenttype < var_3e9ef0a1.size; equipmenttype++) {
        if (self.inventory.var_7658cbec & var_c77511ea[equipmenttype]) {
            continue;
        }
        equipmentitems = var_3e9ef0a1[equipmenttype];
        for (index = 0; index < equipmentitems.size; index++) {
            equipmentitem = equipmentitems[index];
            itemspawnpoint = function_4ba8fde(equipmentitem);
            if (!isdefined(itemspawnpoint)) {
                continue;
            }
            maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.itementry);
            for (itemindex = 0; itemindex < var_710be50e.size; itemindex++) {
                item = self.inventory.items[var_710be50e[itemindex]];
                if (item.networkid == 32767) {
                    continue;
                }
                if (item.itementry.name != equipmentitem) {
                    continue;
                }
                if (item.count <= maxstack) {
                    continue;
                }
                var_9311e423 = item.count - maxstack;
                self use_inventory_item(item.networkid, var_9311e423);
                newitem = spawnstruct();
                newitem.id = item.id;
                newitem.itementry = item.itementry;
                remainingitems = give_inventory_item(newitem, var_9311e423);
                if (remainingitems > 0) {
                    self function_d7944517(newitem.id, newitem.itementry.weapon, remainingitems, 0);
                }
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xca64d82b, Offset: 0x10478
// Size: 0x32c
function function_2bb3a825() {
    assert(isplayer(self));
    var_9b624be0 = array(#"health_item_small", #"health_item_medium", #"health_item_large", #"health_item_squad", #"hash_20699a922abaf2e1");
    var_448bc079 = array(128, 256, 512, 1024, 256);
    var_5675add1 = array(5);
    for (itemindex = 0; itemindex < 5; itemindex++) {
        var_5675add1[var_5675add1.size] = itemindex;
    }
    for (index = var_9b624be0.size - 1; index >= 0; index--) {
        if (self.inventory.var_7658cbec & var_448bc079[index]) {
            continue;
        }
        healthitem = var_9b624be0[index];
        itemspawnpoint = function_4ba8fde(healthitem);
        if (!isdefined(itemspawnpoint)) {
            continue;
        }
        maxstack = item_inventory_util::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.itementry);
        for (itemindex = 0; itemindex < var_5675add1.size; itemindex++) {
            item = self.inventory.items[var_5675add1[itemindex]];
            if (item.networkid == 32767) {
                continue;
            }
            if (item.itementry.name != healthitem) {
                continue;
            }
            if (item.count <= maxstack) {
                continue;
            }
            var_9311e423 = item.count - maxstack;
            self use_inventory_item(item.networkid, var_9311e423);
            newitem = spawnstruct();
            newitem.id = item.id;
            newitem.itementry = item.itementry;
            remainingitems = give_inventory_item(newitem, var_9311e423);
            if (remainingitems > 0) {
                self function_d7944517(newitem.id, newitem.itementry.weapon, remainingitems, 0);
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x16ecf11a, Offset: 0x107b0
// Size: 0x144
function function_2521e90f() {
    for (index = self.inventory.var_c212de25; index < 5; index++) {
        item = self.inventory.items[index];
        if (item.networkid == 32767) {
            continue;
        }
        newitem = spawnstruct();
        newitem.id = item.id;
        newitem.itementry = item.itementry;
        newitem.count = item.count;
        remove_inventory_item(item.networkid, 0, 1, 1);
        remainingitems = give_inventory_item(newitem, newitem.count);
        if (remainingitems > 0) {
            self function_d7944517(newitem.id, newitem.itementry.weapon, remainingitems, 0);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x20a5b7c6, Offset: 0x10900
// Size: 0x44
function function_ec238da8() {
    function_394d85cd();
    function_a2c7ce35();
    function_2bb3a825();
    function_2521e90f();
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xeff58e43, Offset: 0x10950
// Size: 0x3ec
function reset_inventory(givecustomloadout = 1) {
    if (function_7d5553ac()) {
        return;
    }
    self endon(#"death", #"disconnect");
    assert(isplayer(self));
    self.var_7bba6210 = 1;
    self disableoffhandspecial();
    self disableoffhandweapons();
    while (self function_2cceca7b()) {
        waitframe(1);
    }
    if (!isdefined(self) || !isdefined(self.inventory)) {
        return;
    }
    self function_d62822d5();
    foreach (inventoryitem in self.inventory.items) {
        if (inventoryitem.networkid != 32767) {
            remove_inventory_item(inventoryitem.networkid, 0, 0);
        }
    }
    foreach (ammoweapon, itemid in self.inventory.ammo) {
        weapon = getweapon(ammoweapon);
        self setweaponammostock(weapon, 0);
    }
    if (is_true(givecustomloadout) && isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]](1);
    }
    self init_inventory();
    self function_6c36ab6b();
    self function_755a35c5();
    self function_1caf5c88();
    self function_b00db06(10);
    self clientfield::set_player_uimodel("hudItems.armorType", 0);
    self clientfield::set_player_uimodel("hudItems.hasBackpack", 0);
    self clientfield::set_player_uimodel("hudItems.healthItemstackCount", 0);
    self clientfield::set_player_uimodel("hudItems.equipmentStackCount", 0);
    self.var_7bba6210 = undefined;
    self enableoffhandspecial();
    self enableoffhandweapons();
    self callback::callback(#"inventory_reset");
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x723d9b39, Offset: 0x10d48
// Size: 0x1ec
function function_26c87da8(var_c9293a27, var_8f194e5a) {
    assert(isplayer(self));
    assert(isdefined(var_c9293a27) && isdefined(var_8f194e5a));
    if (!isdefined(var_c9293a27) || !isdefined(var_8f194e5a)) {
        return;
    }
    if (var_c9293a27 == var_8f194e5a) {
        return;
    }
    fromitem = self.inventory.items[var_c9293a27];
    toitem = self.inventory.items[var_8f194e5a];
    self.inventory.items[var_c9293a27] = toitem;
    self.inventory.items[var_8f194e5a] = fromitem;
    if (isdefined(fromitem.itementry)) {
        fromitem.networkid = item_world_util::function_970b8d86(var_8f194e5a);
    }
    if (isdefined(toitem.itementry)) {
        toitem.networkid = item_world_util::function_970b8d86(var_c9293a27);
    }
    if (var_8f194e5a == 5) {
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(toitem.itementry));
    } else if (var_8f194e5a == 7) {
        self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(toitem.itementry));
    }
    self function_b00db06(12, var_c9293a27, var_8f194e5a);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x66ecd2dd, Offset: 0x10f40
// Size: 0x3a0
function function_b3342af3(item, notifyclient = 1, ignoreweapon = undefined) {
    assert(isplayer(self));
    assert(isstruct(item));
    foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
        var_f0dc4e93 = self.inventory.items[slotid].networkid;
        if (var_f0dc4e93 == 32767) {
            continue;
        }
        if (isdefined(ignoreweapon) && ignoreweapon.networkid === var_f0dc4e93) {
            continue;
        }
        weaponitem = get_inventory_item(var_f0dc4e93);
        if (!isdefined(weaponitem) || !isdefined(weaponitem.itementry) || weaponitem.itementry.itemtype != #"weapon") {
            assert(0);
            continue;
        }
        currentammo = self getweaponammoclip(item_inventory_util::function_2b83d3ff(weaponitem));
        if (item_inventory_util::function_31a0b1ef(weaponitem, item, 0)) {
            itemtype = item.itementry.itemtype;
            networkid = item.networkid;
            if (notifyclient) {
                self function_b00db06(7, networkid);
            }
            weapon = item_inventory_util::function_2b83d3ff(weaponitem);
            iscurrentweapon = weapon == get_current_weapon();
            function_d019bf1d(var_f0dc4e93, undefined, notifyclient, 0);
            item_inventory_util::function_6e9e7169(weaponitem);
            equip_weapon(weaponitem, iscurrentweapon, undefined, 1, 0);
            newammo = self getweaponammoclipsize(item_inventory_util::function_2b83d3ff(weaponitem));
            var_b917b36f = currentammo - newammo;
            if (var_b917b36f > 0) {
                self function_fc9f8b05(weapon, var_b917b36f);
            }
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0xe20385d3, Offset: 0x112e8
// Size: 0x1d8
function function_41a57271(item, slot, notifyclient = 1, ignoreattachment = undefined) {
    assert(isplayer(self));
    assert(isstruct(item));
    if (!isdefined(item.attachments)) {
        return 0;
    }
    attachments = arraycopy(item.attachments);
    foreach (attachment in attachments) {
        if (!isdefined(attachment) || !isdefined(attachment.itementry)) {
            continue;
        }
        if (isdefined(ignoreattachment) && ignoreattachment.networkid == attachment.networkid) {
            continue;
        }
        if (is_true(attachment.itementry.(slot))) {
            function_b3342af3(get_inventory_item(attachment.networkid), notifyclient);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x0
// Checksum 0xd238631c, Offset: 0x114c8
// Size: 0x42c
function function_d019bf1d(networkid, var_dfe6c7e5 = 0, notifyclient = 1, var_8eb4edca = 1) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    if (!function_f3195b3d(networkid)) {
        return 0;
    }
    item = get_inventory_item(networkid);
    if (!isdefined(item)) {
        return 0;
    }
    itementry = item.itementry;
    itemtype = itementry.itemtype;
    if (itemtype == #"weapon") {
        return function_3f5b2e2e(item, notifyclient, var_8eb4edca);
    }
    if (itemtype == #"attachment") {
        return function_b3342af3(item, notifyclient);
    } else {
        if (itemtype == #"armor") {
            self function_bef83dc6();
            self armor::set_armor(0, 0, 0, 1, 0);
            self clientfield::set_player_uimodel("hudItems.armorType", 0);
        } else if (item_inventory_util::function_1507e6f0(itementry)) {
            self thread function_ee9ce1c4(itementry, var_dfe6c7e5);
        } else if (itemtype == #"health") {
            self thread function_8214f1b6(itementry, var_dfe6c7e5);
        } else if (itemtype == #"perk_tier_1" || itemtype == #"perk_tier_2" || itemtype == #"perk_tier_3") {
            if (itementry.name == #"hash_6ac2848a2f6492ac") {
                remove_inventory_item(item_world_util::function_970b8d86(8), undefined, undefined, 0);
                function_d86d7ac7();
                function_ec238da8();
            }
        } else if (itemtype == #"scorestreak") {
            slotid = function_b246c573(item.networkid);
            killstreakbundle = getscriptbundle(item.itementry.killstreak);
            if (isdefined(killstreakbundle)) {
                self thread killstreaks::take(killstreakbundle.var_d3413870);
                self.pers[#"killstreaks"] = [];
                if (isdefined(killstreakbundle.ksweapon)) {
                    self takeweapon(killstreakbundle.ksweapon);
                }
            }
        }
        if (notifyclient) {
            self function_b00db06(7, networkid);
        }
        return 1;
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x4bc06251, Offset: 0x11900
// Size: 0x508
function function_3f5b2e2e(item, notifyclient = 1, var_8eb4edca = 1) {
    assert(isplayer(self));
    assert(isstruct(item));
    itemtype = item.itementry.itemtype;
    networkid = item.networkid;
    function_60706bdb(networkid);
    if (isdefined(item.attachments) && var_8eb4edca) {
        attachmentitems = [];
        foreach (attachment in item.attachments) {
            if (!isdefined(attachment)) {
                continue;
            }
            attachmentitem = get_inventory_item(attachment.networkid);
            attachmentitems[attachmentitems.size] = attachmentitem;
        }
        foreach (attachmentitem in attachmentitems) {
            function_b3342af3(attachmentitem, 1);
        }
    }
    weapon = item_inventory_util::function_2b83d3ff(item);
    item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
    if (get_weapon_count() > 1) {
        self replace_weapon(weapon, level.weaponbasemeleeheld, 1);
        foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
            if (self.inventory.items[slotid].networkid != 32767 && self.inventory.items[slotid].networkid != item.networkid) {
                altweapon = item_inventory_util::function_2b83d3ff(self.inventory.items[slotid]);
                currentweapon = self getcurrentweapon();
                if (altweapon != currentweapon) {
                    self switchtoweapon(altweapon, 1);
                }
                self.currentweapon = altweapon;
                break;
            }
        }
    } else {
        self replace_weapon(weapon, level.weaponbasemeleeheld, 1);
        if (weapon == get_current_weapon()) {
            currentweapon = self getcurrentweapon();
            if (level.weaponbasemeleeheld != currentweapon) {
                self switchtoweapon(level.weaponbasemeleeheld, 1);
            }
            self.currentweapon = level.weaponbasemeleeheld;
        }
    }
    self clearstowedweapon();
    if (notifyclient) {
        self function_b00db06(7, networkid);
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x0
// Checksum 0x93332676, Offset: 0x11e10
// Size: 0x2d0
function use_inventory_item(networkid, usecount, *var_dfe6c7e5 = 1) {
    self endon(#"death");
    assert(isplayer(self));
    assert(isint(usecount) && usecount != 32767);
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === usecount) {
            if (is_true(self.inventory.items[i].itementry.unlimited)) {
                break;
            }
            self.inventory.items[i].count = self.inventory.items[i].count - var_dfe6c7e5;
            if (self.inventory.items[i].count < 0) {
                self.inventory.items[i].count = 0;
                break;
            }
            var_641929a7 = {#item:self.inventory.items[i]};
            self callback::callback(#"on_item_use", var_641929a7);
            self function_b00db06(9, usecount, self.inventory.items[i].count);
            function_755a35c5();
            function_a4413333();
            function_c4468806(self, self.inventory.items[i]);
            if (self.inventory.items[i].count <= 0) {
                self thread function_a24d6e36(usecount, 1);
            }
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xd6876367, Offset: 0x120e8
// Size: 0x364
function function_956a8ecd() {
    assert(isentity(self));
    if (!isentity(self)) {
        return;
    }
    self waittill(#"hash_363004a4e0ccc1f", #"hawk_settled", #"death", #"stationary");
    var_d783088e = [];
    foreach (sensordart in level.sensor_darts) {
        if (!isdefined(sensordart)) {
            continue;
        }
        parentent = sensordart getlinkedent();
        if (isdefined(parentent) && parentent == self) {
            var_d783088e[var_d783088e.size] = sensordart;
        }
    }
    if (isdefined(level.var_9911d36f)) {
        if (!isdefined(self) || self.health <= 0) {
            foreach (sensordart in var_d783088e) {
                sensordart thread [[ level.var_9911d36f ]]();
            }
            return;
        }
    }
    angles = self.angles;
    origin = self.origin;
    dropitem = item_drop::drop_item(0, undefined, 1, 0, self.id, origin, angles);
    if (isdefined(dropitem) && item_world_util::function_74e1e547(origin)) {
        dropitem.var_d783088e = var_d783088e;
    } else if (isdefined(level.var_9911d36f)) {
        foreach (sensordart in var_d783088e) {
            sensordart thread [[ level.var_9911d36f ]]();
        }
    }
    util::wait_network_frame(1);
    if (isdefined(self)) {
        self delete();
        arrayremovevalue(level.item_vehicles, undefined, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x4
// Checksum 0x91fb80f4, Offset: 0x12458
// Size: 0x34
function private function_d8ceeeec(*notifyhash) {
    self val::reset(#"item_killstreak", "freezecontrols_allowlook");
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0xf266a695, Offset: 0x12498
// Size: 0x82c
function use_killstreak(networkid, item) {
    assert(isplayer(self));
    assert(isdefined(item));
    self endoncallback(&function_d8ceeeec, #"death");
    if (self isinvehicle()) {
        return;
    }
    if (self function_2cceca7b()) {
        return;
    }
    if (self inlaststand()) {
        return;
    }
    if (self isonladder()) {
        return;
    }
    vehicletype = item.itementry.vehicle;
    if (item.itementry.weapon.deployable) {
        traceresults = self function_242060b9(item.itementry.weapon);
        if (traceresults.isvalid) {
            if (isdefined(level.var_1f020f16) && isdefined(vehicletype) && isdefined(level.var_1f020f16[vehicletype])) {
                traceresults.isvalid = self [[ level.var_1f020f16[vehicletype] ]](item.itementry.vehicle, item.itementry.weapon, traceresults);
            }
        }
    } else if (isdefined(level.var_4cf92425[vehicletype])) {
        traceresults = self [[ level.var_4cf92425[vehicletype] ]](item.itementry.vehicle);
    } else {
        eyeangle = self getplayerangles();
        forward = anglestoforward(eyeangle);
        eyepos = self getplayercamerapos();
        endpos = eyepos + forward * 50;
        var_f45df727 = eyepos + forward * 100;
        traceresults = {};
        traceresults.trace = bullettrace(eyepos, var_f45df727, 1, self, 1, 1);
        traceresults.isvalid = traceresults.trace[#"fraction"] >= 1;
        traceresults.waterdepth = 0;
        traceresults.origin = endpos;
        traceresults.angles = eyeangle;
    }
    if (traceresults.isvalid) {
        remoteweapon = getweapon(#"killstreak_remote");
        if (self hasweapon(remoteweapon)) {
            return;
        }
        if (self isswitchingweapons()) {
            self waittilltimeout(2, #"weapon_change");
        }
        self val::set(#"item_killstreak", "freezecontrols_allowlook", 1);
        self giveweapon(remoteweapon);
        self switchtoweapon(remoteweapon, 1);
        self waittilltimeout(2, #"weapon_change");
        if (self getcurrentweapon() != remoteweapon) {
            self takeweapon(remoteweapon);
            self val::reset(#"item_killstreak", "freezecontrols_allowlook");
            return;
        }
        remove_inventory_item(networkid);
        self closeingamemenu();
        relativeorigin = undefined;
        var_2e2dbfa3 = undefined;
        if (isdefined(traceresults.hitent)) {
            relativeorigin = traceresults.origin - traceresults.hitent.origin;
            var_2e2dbfa3 = traceresults.hitent.angles;
        }
        spawnorigin = traceresults.origin;
        if (isdefined(traceresults.hitent) && isdefined(relativeorigin)) {
            anglesdelta = traceresults.hitent.angles - var_2e2dbfa3;
            spawnorigin = traceresults.hitent.origin + rotatepoint(relativeorigin, anglesdelta);
        }
        vehicle = spawnvehicle(vehicletype, spawnorigin, traceresults.angles);
        if (isdefined(vehicle)) {
            if (isdefined(vehicle.vehicleclass) && vehicle.vehicleclass == #"helicopter") {
                vehicle.origin += (0, 0, vehicle.height);
            }
            level.item_vehicles[level.item_vehicles.size] = vehicle;
        }
        util::wait_network_frame(1);
        if (isdefined(vehicle)) {
            vehicle.id = item.id;
            if (isdefined(vehicle.vehicleclass) && vehicle.vehicleclass != #"helicopter") {
                vehicle thread function_956a8ecd();
            }
            vehicle setteam(self.team);
            vehicle.team = self.team;
            if (!isai(vehicle)) {
                vehicle setowner(self);
            }
            vehicle.owner = self;
            vehicle.ownerentnum = self.entnum;
            if (vehicle isremotecontrol()) {
                self val::reset(#"item_killstreak", "freezecontrols_allowlook");
                vehicle usevehicle(self, 0);
                self waittill(#"exit_vehicle");
            } else if (isdefined(vehicle.var_7feead71)) {
                vehicle [[ vehicle.var_7feead71 ]](self);
            }
        }
        self val::reset(#"item_killstreak", "freezecontrols_allowlook");
        self takeweapon(remoteweapon);
        return;
    }
    self sethintstring(#"hash_37605398dce96965");
    wait 1.5;
    if (isdefined(self)) {
        self sethintstring(#"");
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x70252766, Offset: 0x12cd0
// Size: 0x1ec
function function_3d113bfb() {
    if (!isplayer(self)) {
        return;
    }
    if (!isdefined(self.var_a097ccb7)) {
        self.var_a097ccb7 = 0;
    }
    if (!isstruct(self.inventory) || !isarray(self.inventory.items)) {
        return;
    }
    cash = 0;
    foreach (item in self.inventory.items) {
        if (!isdefined(item) || !isstruct(item.itementry) || item.itementry.itemtype !== #"cash") {
            continue;
        }
        cash += isdefined(item.itementry.amount) ? item.itementry.amount : 0;
    }
    self.var_a097ccb7 = cash;
    if (self.var_a097ccb7 > 0) {
        self clientfield::set("wz_cash_carrying", 1);
        return;
    }
    self clientfield::set("wz_cash_carrying", 0);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0xb67090c8, Offset: 0x12ec8
// Size: 0x1c
function function_9f438f15() {
    self function_6c36ab6b();
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x0
// Checksum 0x433ca88f, Offset: 0x12ef0
// Size: 0x114
function function_1caf5c88() {
    if (!isdefined(self.inventory)) {
        return;
    }
    reduction = 0;
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        if (!isdefined(item.itementry.var_dba54111) || item.itementry.var_dba54111 == 0) {
            continue;
        }
        reduction += item.itementry.var_dba54111;
    }
    radiation_ui::function_cca7424d(self, reduction);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x76920c, Offset: 0x13010
// Size: 0xa2
function function_b579540e(item, aat_name) {
    assert(isstruct(item));
    if (!isdefined(item) || !isdefined(item.itementry) || item.itementry.itemtype != #"weapon") {
        return false;
    }
    if (!isdefined(aat_name)) {
        return false;
    }
    item.aat = aat_name;
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x0
// Checksum 0x7c1dcaec, Offset: 0x130c0
// Size: 0x282
function function_73ae3380(item, paplv) {
    self endon(#"death");
    assert(isstruct(item));
    if (!isdefined(item) || !isdefined(item.itementry) || item.itementry.itemtype != #"weapon") {
        return 0;
    }
    if (!isdefined(paplv)) {
        return 0;
    }
    if (isdefined(level.var_fee1eaaf) && paplv < 2) {
        if (isdefined(item.aat)) {
            aat_name = item.aat;
        }
        new_item = [[ level.var_fee1eaaf ]](item);
        if (isdefined(new_item)) {
            var_bd31d7b2 = function_ec087745();
            new_item.hidetime = 0;
            new_item.var_5b4ae99d = 1;
            dropweapon = function_9d102bbd(new_item, var_bd31d7b2);
            if (isentity(dropweapon)) {
                item_world::consume_item(dropweapon);
            }
            for (currentweapon = self get_current_weapon(); currentweapon.name === #"none"; currentweapon = self get_current_weapon()) {
                waitframe(1);
            }
            var_ec0c35ac = function_230ceec4(currentweapon);
            var_ec0c35ac.paplv = paplv;
            if (isdefined(aat_name)) {
                var_ec0c35ac.aat = aat_name;
            }
            self notify(#"hash_75ec9942d2d5fd0f");
            return var_ec0c35ac;
        }
    } else if (paplv >= 2) {
        item.paplv = paplv;
    } else {
        return 0;
    }
    self notify(#"hash_75ec9942d2d5fd0f");
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xe40a103a, Offset: 0x13350
// Size: 0xfc
function function_dc5d31be(w_item) {
    a_items = self.inventory.items;
    n_count = 0;
    if (isdefined(a_items)) {
        foreach (item in a_items) {
            if (isdefined(item.itementry) && isdefined(item.count) && w_item === item.itementry.name) {
                n_count += item.count;
            }
        }
    }
    return n_count;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0xe0913159, Offset: 0x13458
// Size: 0xfc
function private function_eb0c9b9c() {
    players = getplayers();
    var_7bba6210 = 1;
    while (var_7bba6210) {
        waitframe(1);
        var_7bba6210 = 0;
        foreach (player in players) {
            if (isdefined(player) && isalive(player) && is_true(player.var_7bba6210)) {
                var_7bba6210 = 1;
                break;
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x4
// Checksum 0x664af835, Offset: 0x13560
// Size: 0xc4
function private function_f58e80e2() {
    players = getplayers();
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (isalive(player)) {
            if (!function_7d5553ac()) {
                player thread reset_inventory();
            }
        }
        if ((index + 1) % 3 == 0) {
            waitframe(1);
        }
    }
    function_eb0c9b9c();
}

/#

    // Namespace item_inventory/item_inventory
    // Params 0, eflags: 0x0
    // Checksum 0xb49790cc, Offset: 0x13630
    // Size: 0x1b8
    function function_76eb9bd7() {
        item_world::function_1b11e73c();
        if (!isdefined(self) || !isplayer(self) || !isalive(self)) {
            return;
        }
        while (isdefined(self) && !isdefined(self.inventory)) {
            waitframe(1);
        }
        if (!isdefined(self)) {
            return;
        }
        inventorystr = getdvarstring(#"hash_7b2be9e03d9785f3", "<dev string:x5b>");
        tokens = strtok(inventorystr, "<dev string:x1c8>");
        foreach (token in tokens) {
            item = function_4ba8fde(token);
            if (isdefined(item)) {
                var_fa3df96 = self function_e66dcff5(item);
                self item_world::function_de2018e3(item, self, var_fa3df96);
            }
        }
    }

#/
