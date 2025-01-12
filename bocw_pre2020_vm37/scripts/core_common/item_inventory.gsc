#using script_1caf36ff04a85ff6;
#using script_1f41849126bfc83d;
#using script_471b31bd963b388e;
#using script_67c87580908a0a00;
#using script_7f6cd71c43c45c57;
#using scripts\abilities\ability_player;
#using scripts\abilities\gadgets\gadget_health_regen;
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
// Checksum 0xdaca23c8, Offset: 0x5c8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"item_inventory", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0xaa72debe, Offset: 0x618
// Size: 0x27c
function private function_70a657d8() {
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
// Params 0, eflags: 0x5 linked
// Checksum 0x146a98d9, Offset: 0x8a0
// Size: 0x1c
function private _on_player_connect() {
    self init_inventory();
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0xaa9ada65, Offset: 0x8c8
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf99d33, Offset: 0x910
// Size: 0x6a
function function_7d5553ac() {
    return currentsessionmode() == 4 || (isdefined(getgametypesetting(#"hash_1cc3f98086d6f5dd")) ? getgametypesetting(#"hash_1cc3f98086d6f5dd") : 0);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xfe35b540, Offset: 0x988
// Size: 0x124
function function_64d3e50(var_b4d5813c) {
    if (!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items) || !isdefined(self.inventory.items[5])) {
        return;
    }
    networkid = self.inventory.items[5].networkid;
    if (isdefined(networkid) && networkid != 32767) {
        item = get_inventory_item(networkid);
        if (item.var_a6762160.name == #"hash_6d9b83e07c57fb35") {
            if (var_b4d5813c) {
                self thread use_inventory_item(networkid, 1, 0);
            }
            return;
        }
        self thread use_inventory_item(networkid, 1, 0);
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x7ca56b96, Offset: 0xab8
// Size: 0x124
function function_299d2131(maxhealth, var_5af5a1bf, var_4465ef1e) {
    self endon(#"death");
    while (self.heal.enabled) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    self.var_44d52546 = 1;
    self player::function_9080887a(maxhealth);
    self.heal.var_bc840360 = math::clamp(var_5af5a1bf + self.health, 0, maxhealth);
    self.heal.rate = var_5af5a1bf / var_4465ef1e;
    self gadget_health_regen::function_ddfdddb1();
    self gadget_health_regen::function_1e02d458();
    self callback::function_d8abfc3d(#"done_healing", &function_4a257174);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x5cab981e, Offset: 0xbe8
// Size: 0x5c
function function_4a257174() {
    if (isdefined(self)) {
        self callback::function_52ac9652(#"done_healing", &function_4a257174);
        self.var_44d52546 = undefined;
        gadget_health_regen::heal_end();
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x41860764, Offset: 0xc50
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
    buildkitweapon = activecamo::function_385ef18d(weapon);
    weaponoptions = self getbuildkitweaponoptions(buildkitweapon, var_7df02232, stagenum);
    return weaponoptions;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xdfdc892d, Offset: 0xea8
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
// Params 0, eflags: 0x5 linked
// Checksum 0x760f5a39, Offset: 0xf68
// Size: 0x2e
function private function_d62822d5() {
    self.var_cc111ddc = undefined;
    self.var_8181d952 = undefined;
    self.var_cd3bc45b = undefined;
    self.var_d0015cb3 = undefined;
    self.var_14c391cc = undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x82c97f5f, Offset: 0xfa0
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
// Params 2, eflags: 0x5 linked
// Checksum 0xfa9e09a6, Offset: 0x10a0
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
// Checksum 0xaa3c89fd, Offset: 0x11c8
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
// Checksum 0xd8362474, Offset: 0x1258
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
// Checksum 0x9e12386a, Offset: 0x12e8
// Size: 0x598
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
        foreach (var_4308a069 in array(#"trophy_system", #"hatchet", #"tomahawk_t8", #"basketball", #"gadget_jammer")) {
            if (var_4308a069 == weaponname) {
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
                dropitem.var_a6762160 = itemspawnpoint.var_a6762160;
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
// Checksum 0x8a2f588, Offset: 0x1888
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
// Checksum 0xc33b9cb6, Offset: 0x1928
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
// Checksum 0x1b3eb73b, Offset: 0x1b58
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
// Checksum 0xc0a8d4eb, Offset: 0x1c10
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
// Checksum 0xfdba2672, Offset: 0x1db8
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
// Checksum 0x99c453bf, Offset: 0x1e60
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
// Params 1, eflags: 0x5 linked
// Checksum 0x933b0f17, Offset: 0x1f08
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
        if (!isdefined(item.var_a6762160.var_dba54111) || item.var_a6762160.var_dba54111 == 0) {
            continue;
        }
        var_babbb09b = item.var_a6762160.var_dba54111;
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
// Params 0, eflags: 0x5 linked
// Checksum 0x56b08105, Offset: 0x20e8
// Size: 0x1a4
function private function_38d1ea04() {
    if (isplayer(self) && isdefined(self.inventory)) {
        inventoryitem = self.inventory.items[6];
        if (!is_true(inventoryitem.var_a6762160.var_b5b2485b)) {
            return;
        }
        if (isdefined(inventoryitem) && isdefined(inventoryitem.var_a6762160)) {
            armorshards = inventoryitem.var_a6762160.armorshards;
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
        if (inventoryitem.networkid != 32767 && inventoryitem.var_a6762160.itemtype == #"armor") {
            self remove_inventory_item(inventoryitem.networkid);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0xa685301f, Offset: 0x2298
// Size: 0xd4
function private function_bdc03d88() {
    if (isplayer(self) && isdefined(self.inventory)) {
        inventoryitem = self.inventory.items[6];
        if (inventoryitem.networkid != 32767 && inventoryitem.var_a6762160.itemtype == #"armor") {
            inventoryitem.amount = armor::get_armor();
            if (function_27cd171b(inventoryitem)) {
                self setperk(#"hash_4df21972dd2a3a87");
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x5 linked
// Checksum 0x1031ed9, Offset: 0x2378
// Size: 0x2d4
function private function_434d0c2b(itemtype, var_da328e7b, var_ab9610ad = undefined) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    assert(isarray(var_da328e7b));
    items = [];
    var_e3c48c83 = item_world_util::get_itemtype(var_ab9610ad);
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_b74300d3 = item_world_util::get_itemtype(item.var_a6762160);
        if (var_e3c48c83 === var_b74300d3) {
            return item;
        }
        if (item.var_a6762160.itemtype == itemtype) {
            if (isdefined(items[var_b74300d3])) {
                if (item.count > items[var_b74300d3].count) {
                    items[var_b74300d3] = item;
                }
                continue;
            }
            items[var_b74300d3] = item;
        }
    }
    foreach (var_b74300d3 in var_da328e7b) {
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
// Params 3, eflags: 0x5 linked
// Checksum 0xc351f5db, Offset: 0x2658
// Size: 0x292
function private _cycle_item(itemtype, var_da328e7b, var_bcc2655a) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    assert(isarray(var_da328e7b));
    if (!isdefined(var_bcc2655a)) {
        return;
    }
    items = [];
    var_c7837092 = item_world_util::get_itemtype(var_bcc2655a);
    foreach (item in self.inventory.items) {
        if (item.id == 32767) {
            continue;
        }
        var_b74300d3 = item_world_util::get_itemtype(item.var_a6762160);
        if (item.var_a6762160.itemtype == itemtype) {
            if (isdefined(items[var_b74300d3])) {
                if (item.count > items[var_b74300d3].count) {
                    items[var_b74300d3] = item;
                }
                continue;
            }
            items[var_b74300d3] = item;
        }
    }
    for (currentindex = 0; currentindex < var_da328e7b.size; currentindex++) {
        if (var_da328e7b[currentindex] == var_c7837092) {
            break;
        }
    }
    for (index = currentindex + 1; index < var_da328e7b.size; index++) {
        var_b74300d3 = var_da328e7b[index];
        if (isdefined(items[var_b74300d3])) {
            return items[var_b74300d3];
        }
    }
    if (currentindex < var_da328e7b.size) {
        for (index = 0; index < currentindex; index++) {
            var_b74300d3 = var_da328e7b[index];
            if (isdefined(items[var_b74300d3])) {
                return items[var_b74300d3];
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x974c56e8, Offset: 0x28f8
// Size: 0x1de
function private function_9da31874(itemtype) {
    assert(isplayer(self));
    assert(ishash(itemtype));
    items = [];
    foreach (index, item in self.inventory.items) {
        if (index >= 5) {
            break;
        }
        if (item.id == 32767 || item.var_a6762160.itemtype != itemtype) {
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
// Params 1, eflags: 0x5 linked
// Checksum 0xa1401f04, Offset: 0x2ae0
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
// Params 1, eflags: 0x5 linked
// Checksum 0x6f97b2c1, Offset: 0x2e60
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
// Params 1, eflags: 0x5 linked
// Checksum 0xb280d1a, Offset: 0x31e0
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
// Params 2, eflags: 0x5 linked
// Checksum 0x120e4447, Offset: 0x3560
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
// Params 1, eflags: 0x5 linked
// Checksum 0x6138a242, Offset: 0x3698
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
// Params 1, eflags: 0x5 linked
// Checksum 0x27df762b, Offset: 0x37d8
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
// Params 1, eflags: 0x5 linked
// Checksum 0x93bbda89, Offset: 0x38a8
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
// Params 2, eflags: 0x5 linked
// Checksum 0xc5bdd1d8, Offset: 0x39b8
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
// Params 1, eflags: 0x5 linked
// Checksum 0x714c617b, Offset: 0x3bd8
// Size: 0x19c
function private function_d08934c6(equipment) {
    var_b74300d3 = undefined;
    switch (equipment) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x9a74b0fe, Offset: 0x3d80
// Size: 0x8e
function function_520b16d6() {
    item = spawnstruct();
    item.amount = 0;
    item.count = 0;
    item.id = 32767;
    item.networkid = 32767;
    item.var_a6762160 = undefined;
    item.var_627c698b = undefined;
    item.weaponoptions = undefined;
    item.charmindex = undefined;
    item.deathfxindex = undefined;
    return item;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xd79351d4, Offset: 0x3e18
// Size: 0x5c
function private function_27cd171b(inventoryitem) {
    if (!isdefined(inventoryitem.amount)) {
        return false;
    }
    if (inventoryitem.amount <= 0) {
        return true;
    }
    return inventoryitem.amount / inventoryitem.var_a6762160.amount <= 0.5;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xd5cca9c1, Offset: 0x3e80
// Size: 0x4c
function function_d85c5382(sensordart, *player) {
    level.sensor_darts[level.sensor_darts.size] = player;
    arrayremovevalue(level.sensor_darts, undefined);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0xf2dc921f, Offset: 0x3ed8
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
// Params 0, eflags: 0x5 linked
// Checksum 0xa75079df, Offset: 0x4138
// Size: 0xcc
function private function_755a35c5() {
    assert(isplayer(self));
    stimcount = 0;
    healthitem = self.inventory.items[5];
    if (healthitem.networkid !== 32767) {
        if (healthitem.var_a6762160.name == #"hash_6d9b83e07c57fb35") {
            stimcount = function_bba770de(healthitem.var_a6762160);
        }
    }
    gadget_health_regen::function_6eef7f4f(stimcount);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0xa491fcdb, Offset: 0x4210
// Size: 0xfc
function private function_a4413333() {
    assert(isplayer(self));
    healthitem = self.inventory.items[5];
    if (healthitem.networkid !== 32767) {
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(healthitem.var_a6762160));
    }
    equipmentitem = self.inventory.items[7];
    if (equipmentitem.networkid !== 32767) {
        self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(equipmentitem.var_a6762160));
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x8d6a321f, Offset: 0x4318
// Size: 0x49a
function private function_6c36ab6b() {
    self function_e6f9e3cd();
    foreach (slotid, item in self.inventory.items) {
        var_a6762160 = item.var_a6762160;
        if (isdefined(var_a6762160) && !is_true(var_a6762160.consumable) && isarray(var_a6762160.talents)) {
            if (is_true(var_a6762160.var_97c5ead1) && slotid < 5) {
                continue;
            }
            foreach (var_9de7969b in var_a6762160.talents) {
                self function_b5feff95(var_9de7969b.talent);
            }
        }
    }
    foreach (item in self.inventory.consumed) {
        var_a6762160 = item.var_a6762160;
        if (isdefined(var_a6762160) && isarray(var_a6762160.talents)) {
            foreach (var_9de7969b in var_a6762160.talents) {
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
    if (armoritem.networkid != 32767 && armoritem.var_a6762160.itemtype == #"armor") {
        if (function_27cd171b(armoritem)) {
            self setperk(#"hash_4df21972dd2a3a87");
        }
    }
    self player::function_9080887a();
    self.var_66cb03ad = isdefined(self.var_66cb03ad) ? self.var_66cb03ad : self.spawnhealth;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x24e76106, Offset: 0x47c0
// Size: 0xe2
function private function_60706bdb(networkid) {
    assert(isplayer(self));
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return;
    }
    if (item.var_a6762160.itemtype == #"weapon") {
        weapon = namespace_a0d533d1::function_2b83d3ff(item);
        ammoclip = self getweaponammoclip(weapon);
        item.amount = ammoclip;
    }
}

// Namespace item_inventory/item_inventory
// Params 8, eflags: 0x5 linked
// Checksum 0x5204e65d, Offset: 0x48b0
// Size: 0x13a
function private function_d7944517(itemid, weapon, count, amount, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, attachments = undefined) {
    assert(isplayer(self));
    assert(item_world_util::function_2c7fc531(itemid));
    self endon(#"death");
    droppos = var_7cab8e12;
    if (!stashitem) {
        droppos = self.origin;
    }
    return self item_drop::function_fd9026e4(0, weapon, count, amount, itemid, droppos, self.angles, 2, stashitem, 0, targetname, undefined, attachments);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x55b7d0e9, Offset: 0x49f8
// Size: 0x3a
function private function_d116a346(*slot, weapon) {
    if (isplayer(self)) {
        self.var_e42fb511 = weapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0x8c171e7e, Offset: 0x4a40
// Size: 0x3a
function private _gadget_health_regen_on(*slot, weapon) {
    if (isplayer(self)) {
        self.var_d6cd7d80 = weapon;
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0xb51a31e3, Offset: 0x4a88
// Size: 0x3e
function private _gadget_health_regen_off(*slot, *weapon) {
    if (isplayer(self)) {
        self.var_d6cd7d80 = undefined;
        self.var_e42fb511 = undefined;
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0xeaf9d9f8, Offset: 0x4ad0
// Size: 0x54
function private function_2cceca7b() {
    return self isgrappling() || self isusingoffhand() || self function_55acff10(1);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xb493eb3e, Offset: 0x4b30
// Size: 0x42
function private function_c1cef1ec(weapon) {
    if (weapon != self getcurrentoffhand()) {
        return 0;
    }
    return self function_2cceca7b();
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x5 linked
// Checksum 0xd8c5e076, Offset: 0x4b80
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
// Params 2, eflags: 0x5 linked
// Checksum 0xfc55810d, Offset: 0x4d58
// Size: 0xee
function private function_ee9ce1c4(var_a6762160, *var_dfe6c7e5) {
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
// Params 2, eflags: 0x5 linked
// Checksum 0x58eeccf9, Offset: 0x4e50
// Size: 0xfe
function private function_8214f1b6(var_a6762160, *var_dfe6c7e5) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xd0c398bd, Offset: 0x4f58
// Size: 0x1b0
function function_bba770de(var_a6762160) {
    assert(isplayer(self));
    count = 0;
    if (!isdefined(var_a6762160)) {
        return count;
    }
    if (!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items)) {
        return count;
    }
    if (is_true(var_a6762160.unlimited)) {
        return count;
    }
    name = isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name;
    for (index = 0; index < self.inventory.items.size && index < 17 + 1; index++) {
        inventoryitem = self.inventory.items[index];
        if (!isdefined(inventoryitem.var_a6762160)) {
            continue;
        }
        if (name == (isdefined(inventoryitem.var_a6762160.parentname) ? inventoryitem.var_a6762160.parentname : inventoryitem.var_a6762160.name)) {
            count += inventoryitem.count;
        }
    }
    return count;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x4e61d89e, Offset: 0x5110
// Size: 0x146
function can_pickup_ammo(item, var_1326fcc7 = undefined) {
    assert(isplayer(self));
    var_a6762160 = item.var_a6762160;
    ammoweapon = var_a6762160.weapon;
    var_1326fcc7 = isdefined(var_a6762160.amount) ? var_a6762160.amount : isdefined(var_1326fcc7) ? var_1326fcc7 : 1;
    var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
    currentammostock = self getweaponammostock(ammoweapon);
    var_9b9ba643 = var_2f399b51 - currentammostock;
    addammo = int(min(var_1326fcc7, var_9b9ba643));
    return addammo > 0;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xfa5fce42, Offset: 0x5260
// Size: 0x15e
function function_550fcb41(item) {
    assert(isplayer(self));
    if (!is_true(item.var_a6762160.stackable)) {
        return false;
    }
    maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
    if (maxstack <= 1) {
        return false;
    }
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].id == 32767) {
            continue;
        }
        if (self.inventory.items[i].var_a6762160.name != item.var_a6762160.name) {
            continue;
        }
        if (self.inventory.items[i].count < maxstack) {
            return true;
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0x35ac747a, Offset: 0x53c8
// Size: 0xd2
function private function_85645978(item) {
    currtime = gettime();
    foreach (consumeditem in self.inventory.consumed) {
        if (item.var_a6762160.name == consumeditem.var_a6762160.name && currtime < consumeditem.endtime) {
            return consumeditem;
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x2f7537c3, Offset: 0x54a8
// Size: 0xf2
function private function_3fe6ef04() {
    assert(isplayer(self));
    var_cfa0e915 = [];
    foreach (consumeditem in self.inventory.consumed) {
        if (isdefined(var_cfa0e915[consumeditem.var_a6762160.name])) {
            continue;
        }
        var_cfa0e915[consumeditem.var_a6762160.name] = 1;
    }
    return var_cfa0e915.size;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x72afcaee, Offset: 0x55a8
// Size: 0x570
function consume_item(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
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
    if (item.var_a6762160.itemtype == #"armor_shard") {
        return function_6d647220(item);
    }
    consumeditem = self function_85645978(item);
    if (!isdefined(consumeditem) && self function_3fe6ef04() >= 10) {
        self playsoundtoplayer(#"uin_default_action_denied", self);
        return 0;
    }
    self callback::callback(#"hash_5775ae80fc576ea6", item);
    duration = int((isdefined(item.var_a6762160.duration) ? item.var_a6762160.duration : 0) * 1000);
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
            if (inventoryitem.var_a6762160.name == item.var_a6762160.name) {
                inventoryitem.starttime = consumeditem.starttime;
                inventoryitem.endtime = consumeditem.endtime;
            }
        }
    } else {
        consumeditem = spawnstruct();
        consumeditem.id = item.id;
        consumeditem.var_a6762160 = item.var_a6762160;
        consumeditem.starttime = gettime();
        consumeditem.endtime = consumeditem.starttime + duration;
    }
    self.inventory.consumed[self.inventory.consumed.size] = consumeditem;
    self function_b00db06(11, item.networkid);
    self function_db2abc4(item);
    self function_6c36ab6b();
    if (isdefined(consumeditem.var_a6762160) && isdefined(consumeditem.var_a6762160.talents) && isarray(consumeditem.var_a6762160.talents)) {
        foreach (talent in consumeditem.var_a6762160.talents) {
            if (talent.talent == #"hash_6b4f1f8c0c22026f") {
                self thread function_299d2131(300, 100, 0.1);
                break;
            }
        }
    }
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xf30a8b37, Offset: 0x5b20
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
        if (!isdefined(armoritem) || armoritem.networkid == 32767 || armoritem.var_a6762160.itemtype != #"armor") {
            return false;
        }
    }
    if (isdefined(self.var_3f1410dd)) {
        self.var_3f1410dd.var_2b021e34 += int(min(isdefined(armoritem.var_a6762160.var_a3aa1ca2) ? armoritem.var_a6762160.var_a3aa1ca2 : 0, self.maxarmor - self.armor));
        self.var_3f1410dd.var_7352c057++;
    }
    self.armor = int(min(self.armor + (isdefined(armoritem.var_a6762160.var_a3aa1ca2) ? armoritem.var_a6762160.var_a3aa1ca2 : 0), self.maxarmor));
    function_bdc03d88();
    self function_6c36ab6b();
    self function_db2abc4(item);
    return true;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0xc756ae58, Offset: 0x5df8
// Size: 0x414
function cycle_equipment_item() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    equipmentitem = self.inventory.items[7];
    if (equipmentitem.networkid !== 32767) {
        var_bcc2655a = equipmentitem.var_a6762160;
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb502ea37, Offset: 0x6218
// Size: 0x1a4
function cycle_health_item() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    healthitem = self.inventory.items[5];
    if (healthitem.networkid !== 32767) {
        var_bcc2655a = healthitem.var_a6762160;
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
// Params 0, eflags: 0x1 linked
// Checksum 0xa1c71eda, Offset: 0x63c8
// Size: 0x1d4
function function_fa4bb600() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    var_16f12c31 = self.inventory.items[17];
    if (var_16f12c31.networkid !== 32767) {
        var_bcc2655a = var_16f12c31.var_a6762160;
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
// Params 0, eflags: 0x1 linked
// Checksum 0x8e0bccd8, Offset: 0x65a8
// Size: 0x1c4
function function_a50547af() {
    assert(isplayer(self));
    var_bcc2655a = undefined;
    var_16f12c31 = self.inventory.items[12];
    if (var_16f12c31.networkid !== 32767) {
        var_bcc2655a = var_16f12c31.var_a6762160;
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
// Params 1, eflags: 0x1 linked
// Checksum 0x3718102, Offset: 0x6778
// Size: 0x244
function function_9ba10b94(networkid) {
    assert(isplayer(self));
    self endon(#"death");
    slotid = function_b246c573(networkid);
    if (!isdefined(slotid)) {
        return;
    }
    attachmentweapons = [];
    var_8e198ed3 = [];
    foreach (var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
        var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_259f58f3);
        item = self.inventory.items[var_f9f8c0b5];
        if (item.networkid != 32767) {
            attachmentweapons[attachmentweapons.size] = item_world_util::function_f4a8d375(item.id);
            var_8e198ed3[var_8e198ed3.size] = item.id;
            remove_inventory_item(item.networkid, 0, 1);
        }
    }
    drop_inventory_item(self.inventory.items[slotid].networkid);
    for (index = 0; index < var_8e198ed3.size; index++) {
        self thread function_d7944517(var_8e198ed3[index], attachmentweapons[index], 1, 1);
    }
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x6e11c29, Offset: 0x69c8
// Size: 0x7ba
function function_9d102bbd(var_b72297c2, networkid) {
    assert(isplayer(self));
    self endon(#"death");
    if (!item_world_util::can_pick_up(var_b72297c2)) {
        return 0;
    }
    if (!isdefined(var_b72297c2) || !isdefined(var_b72297c2.var_a6762160) || var_b72297c2.var_a6762160.itemtype !== #"weapon") {
        return 0;
    }
    weaponitem = get_inventory_item(networkid);
    if (!isdefined(weaponitem)) {
        return 0;
    }
    if (!isdefined(weaponitem.var_a6762160) || weaponitem.var_a6762160.itemtype != #"weapon") {
        return 0;
    }
    slotid = function_b246c573(networkid);
    if (!isdefined(slotid)) {
        return 0;
    }
    weapon = namespace_a0d533d1::function_2b83d3ff(weaponitem);
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
    if (namespace_a0d533d1::function_4bd83c04(var_b72297c2)) {
        foreach (var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
            var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_259f58f3);
            item = self.inventory.items[var_f9f8c0b5];
            if (item.networkid != 32767) {
                attachmentname = namespace_a0d533d1::function_2ced1d34(var_b72297c2, item.var_a6762160, 1);
                assert(!isdefined(var_cc9e34fb[var_259f58f3]));
                if (isdefined(attachmentname) && !isdefined(var_cc9e34fb[var_259f58f3])) {
                    var_cc9e34fb[var_259f58f3] = item.var_a6762160;
                } else {
                    dropweapons[dropweapons.size] = item_world_util::function_f4a8d375(item.id);
                    dropids[dropids.size] = item.id;
                }
                var_14174938[var_14174938.size] = item.networkid;
            }
        }
    }
    if (isdefined(var_b72297c2.attachments) || isdefined(var_b72297c2.var_a6762160.attachments)) {
        attachments = isdefined(var_b72297c2.attachments) ? var_b72297c2.attachments : var_b72297c2.var_a6762160.attachments;
        foreach (attachment in attachments) {
            attachmentitem = attachment;
            if (!isdefined(attachmentitem)) {
                continue;
            }
            if (!isdefined(attachmentitem.var_a6762160)) {
                if (!item_world_util::function_7363384a(attachment.var_6be1bec7)) {
                    continue;
                }
                attachmentitem = function_4ba8fde(attachment.var_6be1bec7);
                if (!isdefined(attachmentitem)) {
                    continue;
                }
            }
            var_259f58f3 = namespace_a0d533d1::function_837f4a57(attachmentitem.var_a6762160);
            if (!isdefined(var_259f58f3)) {
                continue;
            }
            if (!isdefined(var_cc9e34fb[var_259f58f3])) {
                var_cc9e34fb[var_259f58f3] = attachmentitem.var_a6762160;
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
            var_e38a0464.var_a6762160 = attachmentitem.var_a6762160;
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
// Params 1, eflags: 0x1 linked
// Checksum 0xb41dcb99, Offset: 0x7190
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
    var_a6762160 = item.var_a6762160;
    self item_world::function_de2018e3(item, self, slotid);
    inventoryitem = self function_8babc9f9(var_a6762160);
    item_world::consume_item(item);
    if (isdefined(inventoryitem)) {
        self equip_item(inventoryitem.networkid);
    }
    self function_85287396(0);
    return dropitem;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x3f29477e, Offset: 0x7348
// Size: 0x868
function function_e66dcff5(item, var_662e1704 = 0) {
    assert(isplayer(self));
    if (!isdefined(self.inventory)) {
        return undefined;
    }
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return undefined;
    }
    if (namespace_a0d533d1::function_819781bf()) {
        var_662e1704 = 1;
    }
    switch (item.var_a6762160.itemtype) {
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
        if (item_world_util::function_41f06d9d(item.var_a6762160)) {
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
    if (item.var_a6762160.itemtype == #"attachment") {
        var_4838b749 = function_d768ea30();
        if (var_662e1704) {
            var_4838b749 = isdefined(var_4838b749) && var_4838b749 == 17 + 1 ? 17 + 1 + 8 + 1 : 17 + 1;
        }
        if (isdefined(var_4838b749)) {
            var_f0dc4e93 = item_world_util::function_970b8d86(var_4838b749);
            if (self.inventory.items[var_4838b749].networkid != 32767 && self.inventory.items[var_4838b749].var_a6762160.itemtype != #"scorestreak") {
                var_ceefbd10 = namespace_a0d533d1::function_837f4a57(item.var_a6762160);
                var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(var_4838b749, var_ceefbd10);
                weaponitem = self get_inventory_item(var_f0dc4e93);
                attachmentname = namespace_a0d533d1::function_2ced1d34(weaponitem, item.var_a6762160, 1);
                if (isdefined(attachmentname)) {
                    return var_f9f8c0b5;
                }
            }
        }
    }
    if (is_true(item.var_a6762160.stackable)) {
        weapon = item_world_util::function_35e06774(item.var_a6762160);
        if (isdefined(weapon)) {
            maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
            if (maxstack > 1) {
                foreach (i, spawnitem in self.inventory.items) {
                    if (spawnitem.id == 32767) {
                        continue;
                    }
                    inventoryitem = function_b1702735(spawnitem.id);
                    if (inventoryitem.var_a6762160.name != item.var_a6762160.name) {
                        continue;
                    }
                    if (self.inventory.items[i].count < maxstack) {
                        return i;
                    }
                }
            }
        }
    }
    if (!namespace_a0d533d1::function_819781bf()) {
        for (index = 0; index < self.inventory.var_c212de25; index++) {
            if (self.inventory.items[index].id == 32767) {
                return index;
            }
        }
    }
    return undefined;
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x34324fc3, Offset: 0x7bb8
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
// Params 3, eflags: 0x1 linked
// Checksum 0xaeb93e0f, Offset: 0x7ca0
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
// Params 5, eflags: 0x1 linked
// Checksum 0xc0f7a5cc, Offset: 0x7da8
// Size: 0x7a4
function drop_inventory_item(networkid, stashitem = 0, var_7cab8e12 = undefined, targetname = undefined, var_4a6f595d = 1) {
    assert(isplayer(self));
    self endon(#"death");
    dropitem = undefined;
    item = get_inventory_item(networkid);
    if (!isdefined(item)) {
        return dropitem;
    }
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    stockammo = 0;
    var_4f8a16ec = getgametypesetting(#"hash_b76e50c1202aa23");
    if (!var_4f8a16ec && isdefined(weapon) && (item.var_a6762160.itemtype === #"weapon" || item.var_a6762160.itemtype === #"scorestreak")) {
        stockammo = self getweaponammostock(weapon);
    }
    if (isdefined(self) && isdefined(weapon) && get_current_weapon() == weapon && self isfiring()) {
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
    var_104acafa = isdefined(item.endtime);
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
            namespace_a0d533d1::function_6e9e7169(item);
            if (!var_104acafa) {
                weapon = namespace_a0d533d1::function_2b83d3ff(item);
                dropitem = self function_d7944517(item.id, weapon, count, amount, stashitem, var_7cab8e12, targetname, isdefined(item.attachments) ? item.attachments : array());
                if (isdefined(item.aat)) {
                    dropitem.aat = item.aat;
                }
                if (isdefined(item.var_a8bccf69)) {
                    dropitem.var_a8bccf69 = item.var_a8bccf69;
                }
                dropitem.stockammo = stockammo;
            } else {
                consumeditem = function_85645978(item);
                if (isdefined(consumeditem)) {
                    var_ee0e9af9 = [];
                    for (index = 0; index < 5; index++) {
                        inventoryitem = self.inventory.items[index];
                        if (!isdefined(inventoryitem.endtime)) {
                            continue;
                        }
                        if (inventoryitem.var_a6762160.name == item.var_a6762160.name) {
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
            if (isdefined(item.var_887db92c)) {
                dropitem.var_887db92c = item.var_887db92c;
            }
            return dropitem;
        }
    }
    return dropitem;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x502bf32a, Offset: 0x8558
// Size: 0x20a
function equip_ammo(item, var_aec6fa7f) {
    assert(isplayer(self));
    assert(isdefined(item));
    self function_db2abc4(item);
    var_a6762160 = item.var_a6762160;
    ammoweapon = var_a6762160.weapon;
    var_1326fcc7 = isdefined(var_a6762160.amount) ? var_a6762160.amount : isdefined(var_aec6fa7f) ? var_aec6fa7f : 1;
    var_2f399b51 = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, ammoweapon);
    currentammostock = self getweaponammostock(ammoweapon);
    var_9b9ba643 = var_2f399b51 - currentammostock;
    addammo = int(min(var_1326fcc7, var_9b9ba643));
    if (isdefined(ammoweapon) && ammoweapon != level.weaponnone) {
        self.inventory.ammo[ammoweapon.name] = item.id;
        self function_fc9f8b05(ammoweapon, addammo);
        if (isdefined(var_aec6fa7f)) {
            return (var_1326fcc7 - addammo);
        }
        return 0;
    }
    assertmsg("<dev string:x38>" + var_a6762160.name + "<dev string:x56>");
    return var_1326fcc7 - addammo;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x2b14846d, Offset: 0x8770
// Size: 0x196
function function_4cde30fa(inventoryitem, var_a6762160) {
    if (game.state == "pregame" || !isplayer(self) || isdefined(self.var_3f1410dd) || !isdefined(inventoryitem) || !isdefined(var_a6762160)) {
        return;
    }
    self.var_3f1410dd = {#player_xuid:int(self getxuid(1)), #start_time:function_f8d53445(), #end_time:0, #var_4550558c:isdefined(inventoryitem.amount) ? inventoryitem.amount : 0, #tier:isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1, #damage_taken:0, #var_7352c057:0, #var_2b021e34:0, #broken:0, #died:0};
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0xb87aaf74, Offset: 0x8910
// Size: 0xf6
function function_bef83dc6() {
    if (game.state == "pregame" || !isplayer(self) || !isdefined(self.var_3f1410dd)) {
        return;
    }
    self.var_3f1410dd.broken = isdefined(self.armor) && self.armor <= 0;
    self.var_3f1410dd.died = isdefined(self.health) && self.health <= 0;
    self.var_3f1410dd.end_time = function_f8d53445();
    function_92d1707f(#"hash_3d5d9b3e2bc86b28", self.var_3f1410dd);
    self.var_3f1410dd = undefined;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xf67ad12d, Offset: 0x8a10
// Size: 0x29c
function equip_armor(item) {
    var_a6762160 = item.var_a6762160;
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    self function_db2abc4(item);
    self armor::set_armor(inventoryitem.amount, isdefined(var_a6762160.amount) ? var_a6762160.amount : 0, isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1, isdefined(var_a6762160.var_99c0cb08) ? var_a6762160.var_99c0cb08 : 1, isdefined(var_a6762160.var_2ee21ae6) ? var_a6762160.var_2ee21ae6 : 1, isdefined(var_a6762160.var_c690c73d) ? var_a6762160.var_c690c73d : 1, isdefined(var_a6762160.var_99edb6a3) ? var_a6762160.var_99edb6a3 : 1, isdefined(var_a6762160.var_22c3ab38) ? var_a6762160.var_22c3ab38 : 1, isdefined(var_a6762160.var_9f307988) ? var_a6762160.var_9f307988 : 1, isdefined(var_a6762160.var_7a80f06e) ? var_a6762160.var_7a80f06e : 1, isdefined(var_a6762160.explosivedamagescale) ? var_a6762160.explosivedamagescale : 1, isdefined(var_a6762160.var_f2902d7b) ? var_a6762160.var_f2902d7b : 1, var_a6762160.var_19f48bbe);
    self function_4cde30fa(inventoryitem, var_a6762160);
    self.inventory.items[6] = inventoryitem;
    self function_b00db06(6, item.networkid);
    self clientfield::set_player_uimodel("hudItems.armorType", isdefined(var_a6762160.armortier) ? var_a6762160.armortier : 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x8f11c3dd, Offset: 0x8cb8
// Size: 0x8a
function function_e258cef5(networkid, itemtype) {
    if (networkid == 32767) {
        return undefined;
    }
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != itemtype) {
        return undefined;
    }
    return item;
}

// Namespace item_inventory/item_inventory
// Params 5, eflags: 0x1 linked
// Checksum 0xabbe9215, Offset: 0x8d50
// Size: 0x464
function equip_attachment(item, var_610add8d, var_d6f68de7, var_a3a17c55 = 1, switchweapon = 1) {
    assert(isplayer(self));
    assert(isstruct(item));
    var_4e2a1ed8 = function_e258cef5(var_610add8d, #"weapon");
    if (!isdefined(var_4e2a1ed8)) {
        return;
    }
    if (namespace_a0d533d1::function_9e9c82a6(var_4e2a1ed8, item, 0)) {
        function_b3342af3(item, undefined, var_4e2a1ed8);
        offset = namespace_a0d533d1::function_837f4a57(item.var_a6762160);
        var_ac396b2f = function_d7dbfe3c(var_4e2a1ed8);
        if (!isdefined(var_ac396b2f)) {
            return;
        }
        var_dd6937a8 = namespace_a0d533d1::function_dfaca25e(var_ac396b2f, offset);
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
            if (is_true(item.var_a6762160.(slot))) {
                function_41a57271(var_4e2a1ed8, slot, undefined, item);
            }
        }
        function_d019bf1d(var_610add8d, undefined, undefined, 0);
        namespace_a0d533d1::function_6e9e7169(var_4e2a1ed8);
        equip_weapon(var_4e2a1ed8, switchweapon, undefined, var_a3a17c55, 0);
        self function_db2abc4(item);
        if (var_97cc940d) {
            equip_attachment(var_2134bf0d, var_d6f68de7, undefined, var_a3a17c55, 1);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x7f4db024, Offset: 0x91c0
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
    self.inventory.var_7658cbec = namespace_a0d533d1::function_d8cebda3(item.var_a6762160);
    if (self.inventory.var_7658cbec & 1) {
        self.inventory.var_c212de25 = 5;
    }
    self.inventory.items[8] = inventoryitem;
    self function_b00db06(6, item.networkid);
    self clientfield::set_player_uimodel("hudItems.hasBackpack", 1);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xfb88556d, Offset: 0x9338
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
// Params 1, eflags: 0x1 linked
// Checksum 0x510cc6bd, Offset: 0x9428
// Size: 0x5f4
function equip_equipment(item) {
    self notify("2b9d1c4d17812b55");
    self endon("2b9d1c4d17812b55");
    assert(isplayer(self));
    while (isdefined(self) && is_true(self.var_10abd91d)) {
        waitframe(1);
    }
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return;
    }
    itemslotid = 7;
    switch (item.var_a6762160.itemtype) {
    case #"field_upgrade":
        itemslotid = 12;
        break;
    case #"tactical":
        itemslotid = 13;
        break;
    }
    var_a6762160 = item.var_a6762160;
    weapon = var_a6762160.weapon;
    debug_print("equip_equipment:", weapon);
    equipmentitem = self.inventory.items[itemslotid];
    if (equipmentitem.id != 32767) {
        var_355db408 = function_b1702735(equipmentitem.id).var_a6762160.weapon;
        if (isdefined(var_355db408)) {
            slot = self gadgetgetslot(var_355db408);
            if (slot >= 0 && slot < 3) {
                if (self gadgetisprimed(slot)) {
                    debug_print("equip_equipment: fail: GadgetIsPrimed", var_355db408);
                    return;
                }
            }
            if (self function_c1cef1ec(var_355db408)) {
                debug_print("equip_equipment: fail: offhand equipment in use", var_355db408);
                return;
            }
            if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === var_355db408) {
                debug_print("equip_equipment: fail: equipment waiting for removal", var_355db408);
                return;
            }
            if (equipmentitem.networkid != item.networkid) {
                if (namespace_a0d533d1::function_819781bf()) {
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
        var_cbdeb265 = level.nullprimaryoffhand;
        switch (item.var_a6762160.itemtype) {
        case #"tactical":
            var_cbdeb265 = level.nullsecondaryoffhand;
            break;
        case #"field_upgrade":
            var_cbdeb265 = level.var_3488e988;
            break;
        }
        self replace_weapon(var_cbdeb265, weapon, undefined, undefined, undefined, weaponoptions);
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
            self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[itemslotid].var_a6762160));
        }
        return;
    }
    assertmsg("<dev string:x88>" + var_a6762160.name + "<dev string:x56>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x43277afb, Offset: 0x9a28
// Size: 0x50c
function equip_health(item) {
    self notify("2a501f625ed86d38");
    self endon("2a501f625ed86d38");
    assert(isplayer(self));
    while (isdefined(self) && is_true(self.var_10abd91d)) {
        waitframe(1);
    }
    if (!isdefined(item) || !isdefined(self)) {
        return;
    }
    var_a6762160 = item.var_a6762160;
    weapon = var_a6762160.weapon;
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
            var_355db408 = namespace_a0d533d1::function_2b83d3ff(var_2337367a);
            if (isdefined(var_355db408)) {
                slot = self gadgetgetslot(var_355db408);
                if (slot >= 0 && slot < 3) {
                    if (self gadgetisprimed(slot)) {
                        debug_print("equip_health: fail: GadgetIsPrimed", var_355db408);
                        return;
                    }
                    if (self gadgetisactive(slot)) {
                        debug_print("equip_health: fail: GadgetIsActive", var_355db408);
                        return;
                    }
                }
                if (self function_c1cef1ec(var_355db408)) {
                    debug_print("equip_health: fail: offhand equipment in use", var_355db408);
                    return;
                }
                if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === var_355db408) {
                    debug_print("equip_health: fail: equipment waiting for removal", var_355db408);
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
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(item.var_a6762160));
        slot = self gadgetgetslot(weapon);
        if (slot >= 0 && slot < 3) {
            self function_19ed70ca(slot, 0);
        }
        debug_print("equip_health: success", weapon);
        self function_755a35c5();
        return;
    }
    assertmsg("<dev string:xb2>" + var_a6762160.name + "<dev string:x56>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xc9e51e23, Offset: 0x9f40
// Size: 0x224
function function_854cf2c3(item) {
    self notify("1e8ce05acb6d0372");
    self endon("1e8ce05acb6d0372");
    assert(isplayer(self));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return;
    }
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    var_a6762160 = item.var_a6762160;
    weapon = var_a6762160.weapon;
    slotid = function_b246c573(item.networkid);
    if (!isdefined(slotid)) {
        return;
    }
    perkslot = namespace_a0d533d1::function_417ec8b9(var_a6762160);
    if (!isdefined(perkslot)) {
        return;
    }
    self function_db2abc4(item);
    function_26c87da8(slotid, perkslot);
    if (item.var_a6762160.name == #"hash_6ac2848a2f6492ac") {
        backpack = item_world_util::function_49ce7663(#"hash_6a677bcb21d4432b");
        var_fa3df96 = self function_e66dcff5(backpack);
        self item_world::function_de2018e3(backpack, self, var_fa3df96);
    }
    self.inventory.items[perkslot] = inventoryitem;
    self function_b00db06(6, item.networkid);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xd49c0fe0, Offset: 0xa170
// Size: 0x214
function function_1ac37022(item, ammo) {
    self notify("752f7f1a81c0dc");
    self endon("752f7f1a81c0dc");
    assert(isplayer(self));
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return;
    }
    inventoryitem = get_inventory_item(item.networkid);
    if (!isdefined(inventoryitem)) {
        return;
    }
    var_a6762160 = item.var_a6762160;
    weapon = var_a6762160.weapon;
    slotid = function_b246c573(item.networkid);
    if (!isdefined(slotid)) {
        return;
    }
    var_f4cc972d = 17;
    self function_db2abc4(item);
    function_26c87da8(slotid, var_f4cc972d);
    self.inventory.items[var_f4cc972d] = inventoryitem;
    self function_b00db06(6, item.networkid);
    killstreakbundle = getscriptbundle(item.var_a6762160.killstreak);
    killstreaks::give(killstreakbundle.var_d3413870);
    if (isdefined(ammo) && isdefined(weapon) && weapon.name != #"ultimate_turret") {
        self setweaponammostock(weapon, ammo);
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x9dfbc120, Offset: 0xa390
// Size: 0x402
function equip_item(networkid, quickequip = 0, weaponid = 0) {
    assert(isplayer(self));
    item = get_inventory_item(networkid);
    if (isdefined(item) && isdefined(item.var_a6762160)) {
        if (is_true(item.var_a6762160.consumable)) {
            return self consume_item(item);
        }
        itemtype = item.var_a6762160.itemtype;
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
            assertmsg("<dev string:xd9>" + (isdefined(item.var_a6762160.itemtype) ? item.var_a6762160.itemtype : "<dev string:xf4>") + "<dev string:x101>");
            return 0;
        }
        return 1;
    }
    return 0;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x1a76904f, Offset: 0xa7a0
// Size: 0x26
function private can_switch_weapons() {
    if (self function_2cceca7b()) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x5 linked
// Checksum 0xcee5f588, Offset: 0xa7d0
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
// Params 6, eflags: 0x1 linked
// Checksum 0xba4ec1be, Offset: 0xa868
// Size: 0xadc
function equip_weapon(item, switchweapon = 1, var_9fa01da8 = 0, var_a3a17c55 = 0, initialweaponraise = 0, stockammo) {
    assert(isplayer(self));
    var_a6762160 = item.var_a6762160;
    itemtype = var_a6762160.itemtype;
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
            var_355db408 = namespace_a0d533d1::function_2b83d3ff(var_b8c2759f);
            if (currentweapon == var_355db408) {
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
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    if (isdefined(weapon) && weapon != level.weaponnone) {
        var_346dc077 = self getweaponammostock(weapon);
        item.var_59361ab4 = slotid == 17 + 1 + 8 + 1;
        namespace_a0d533d1::function_6e9e7169(item);
        weapon = namespace_a0d533d1::function_2b83d3ff(item);
        slotid = function_b246c573(item.networkid);
        if (!isdefined(slotid)) {
            return;
        }
        self function_26c87da8(slotid, var_68dc9720);
        if (initialweaponraise && !isdefined(item.weaponoptions) && !isdefined(item.charmindex) && !isdefined(item.deathfxindex)) {
            weaponoptions = undefined;
            if (isdefined(getgametypesetting(#"wzrandomcamo")) ? getgametypesetting(#"wzrandomcamo") : 0) {
                renderoptions = function_ea647602("camo", weapon);
                if (renderoptions.size > 0) {
                    var_9412af4a = randomint(renderoptions.size);
                    weaponoptions = self function_6eff28b5(renderoptions[var_9412af4a].item_index, 0, 0);
                }
            } else {
                buildkitweapon = activecamo::function_385ef18d(weapon);
                weaponoptions = self getbuildkitweaponoptions(buildkitweapon);
                charmindex = self function_9826b353(buildkitweapon);
                deathfxindex = self function_74829bcf(buildkitweapon);
            }
            if (weaponoptions != self getbuildkitweaponoptions(level.weaponnone)) {
                item.weaponoptions = weaponoptions;
            }
            item.charmindex = charmindex;
            item.deathfxindex = deathfxindex;
        }
        item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
        self replace_weapon(currentweapon, weapon, 1, initialweaponraise, var_a3a17c55, item.weaponoptions, item.charmindex, item.deathfxindex);
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
    assertmsg("<dev string:x12a>" + var_a6762160.name + "<dev string:x56>");
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xaeceb429, Offset: 0xb350
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
// Params 0, eflags: 0x1 linked
// Checksum 0xcd579646, Offset: 0xb4c0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x85636071, Offset: 0xb618
// Size: 0x1a
function get_current_weapon() {
    return weapons::function_251ec78c(self.currentweapon, 0);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0xd4d0db1f, Offset: 0xb640
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb140d257, Offset: 0xb6c0
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
// Params 0, eflags: 0x1 linked
// Checksum 0x84697e51, Offset: 0xb7e0
// Size: 0x9a
function function_777cc133() {
    assert(isplayer(self));
    if (namespace_a0d533d1::function_819781bf()) {
        return;
    }
    for (index = 0; index < self.inventory.var_c212de25; index++) {
        if (self.inventory.items[index].networkid == 32767) {
            return index;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x2a95098f, Offset: 0xb888
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
// Params 1, eflags: 0x1 linked
// Checksum 0x829cd200, Offset: 0xb910
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
        if (namespace_a0d533d1::function_2b83d3ff(item) === weapon) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xae336969, Offset: 0xbad8
// Size: 0x96
function function_a33744de(weapon) {
    assert(isplayer(self));
    assert(isweapon(weapon));
    weaponitem = function_230ceec4(weapon);
    return isdefined(weaponitem) ? weaponitem.networkid : 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x9a5676ba, Offset: 0xbb78
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
// Params 1, eflags: 0x1 linked
// Checksum 0x93de224, Offset: 0xbc38
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
// Params 1, eflags: 0x1 linked
// Checksum 0x9f1b7b13, Offset: 0xbd20
// Size: 0x162
function function_8babc9f9(var_a6762160) {
    assert(isplayer(self));
    name = isdefined(var_a6762160.parentname) ? var_a6762160.parentname : var_a6762160.name;
    if (!isdefined(self) || !isdefined(self.inventory) || !isdefined(self.inventory.items)) {
        return undefined;
    }
    for (index = 0; index < self.inventory.items.size && index < 17 + 1; index++) {
        inventoryitem = self.inventory.items[index];
        if (!isdefined(inventoryitem.var_a6762160)) {
            continue;
        }
        if (name == (isdefined(inventoryitem.var_a6762160.parentname) ? inventoryitem.var_a6762160.parentname : inventoryitem.var_a6762160.name)) {
            return inventoryitem;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x4606ffaa, Offset: 0xbe90
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
// Checksum 0xc32cf317, Offset: 0xbf30
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
// Params 0, eflags: 0x1 linked
// Checksum 0xbe98147c, Offset: 0xbfd0
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
// Params 1, eflags: 0x1 linked
// Checksum 0x44e58b6, Offset: 0xc0e8
// Size: 0xea
function function_d7dbfe3c(item) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x41d9718d, Offset: 0xc1e0
// Size: 0x356
function function_3f7ef88() {
    assert(isplayer(self));
    if (!isplayer(self) || !isalive(self)) {
        return;
    }
    if (item_world::function_1b11e73c()) {
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
        var_e38a0464.var_a6762160 = attachment.var_a6762160;
        namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
        attachment = function_4ba8fde(#"reflex_wz_item");
        var_e38a0464 = function_520b16d6();
        var_e38a0464.count = 1;
        var_e38a0464.id = attachment.id;
        var_e38a0464.networkid = var_e38a0464.id;
        var_e38a0464.var_a6762160 = attachment.var_a6762160;
        namespace_a0d533d1::function_9e9c82a6(pistol, attachment);
        pistol.amount = self getweaponammoclipsize(namespace_a0d533d1::function_2b83d3ff(pistol));
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
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x1 linked
// Checksum 0xed33709b, Offset: 0xc540
// Size: 0xeb0
function give_inventory_item(item, itemcount = 1, var_aec6fa7f = 0, slotid = undefined) {
    if (!isplayer(self) || !isdefined(self.inventory)) {
        assert(0, "<dev string:x14b>");
        return 0;
    }
    if (!isdefined(item)) {
        assert(0, "<dev string:x185>");
        return 0;
    }
    var_a6762160 = item.var_a6762160;
    itemid = item.id;
    if (isdefined(item.var_a6762160.var_456aa154)) {
        var_456aa154 = getscriptbundle(item.var_a6762160.var_456aa154);
        if (isdefined(var_456aa154)) {
            var_a6762160 = var_456aa154;
        }
        var_8c36ae16 = function_4ba8fde(item.var_a6762160.var_456aa154);
        if (isdefined(var_8c36ae16)) {
            itemid = var_8c36ae16.id;
        }
    }
    var_a057551d = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, item.var_a6762160);
    var_1393d318 = var_a057551d > 1;
    if (item.var_a6762160.itemtype == #"resource" && item_world_util::function_41f06d9d(item.var_a6762160)) {
        var_92d652f2 = self.inventory.items[slotid];
        var_b41045b2 = int(max(150 - self stats::get_stat_global(#"items_paint_cans_collected"), 0));
        var_a057551d = var_b41045b2 + (isdefined(var_92d652f2.count) ? var_92d652f2.count : 0);
    }
    if (isdefined(var_a6762160.name) && var_1393d318) {
        for (i = 0; i < self.inventory.items.size; i++) {
            if (self.inventory.items[i].id != 32767) {
                if (self.inventory.items[i].var_a6762160.name != var_a6762160.name) {
                    continue;
                }
                var_35f34839 = var_a057551d - self.inventory.items[i].count;
                if (var_35f34839 <= 0) {
                    continue;
                }
                var_8c6165fc = int(min(itemcount, var_35f34839));
                self.inventory.items[i].count = self.inventory.items[i].count + var_8c6165fc;
                item.networkid = self.inventory.items[i].networkid;
                self function_b00db06(9, self.inventory.items[i].networkid, self.inventory.items[i].count);
                if (i == 5) {
                    self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(self.inventory.items[i].var_a6762160));
                } else if (i == 7) {
                    self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(self.inventory.items[i].var_a6762160));
                }
                inventoryweapon = namespace_a0d533d1::function_2b83d3ff(self.inventory.items[i]);
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
            var_8c6165fc = int(min(itemcount, var_a057551d));
            item.networkid = item_world_util::function_970b8d86(slotid);
            namespace_a0d533d1::function_6e9e7169(item);
            var_92d652f2.amount = var_aec6fa7f;
            var_92d652f2.count = var_8c6165fc;
            var_92d652f2.id = itemid;
            var_92d652f2.networkid = item.networkid;
            var_92d652f2.var_a6762160 = var_a6762160;
            var_92d652f2.starttime = undefined;
            var_92d652f2.endtime = undefined;
            var_92d652f2.weaponoptions = undefined;
            var_92d652f2.charmindex = undefined;
            var_92d652f2.deathfxindex = undefined;
            self function_b00db06(4, item.id, var_8c6165fc, slotid + 1);
            itemcount -= var_8c6165fc;
            assert(itemcount >= 0);
            if (itemcount <= 0) {
                if (isdefined(item.attachments)) {
                    foreach (attachmentitem in item.attachments) {
                        if (!isdefined(attachmentitem)) {
                            continue;
                        }
                        var_769a94ae = namespace_a0d533d1::function_837f4a57(attachmentitem.var_a6762160);
                        if (!isdefined(var_769a94ae)) {
                            continue;
                        }
                        var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_769a94ae);
                        give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
                        attachmentitem = get_inventory_item(attachmentitem.networkid);
                        namespace_a0d533d1::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
                    }
                    namespace_a0d533d1::function_6e9e7169(var_92d652f2);
                } else if (isdefined(var_a6762160.attachments)) {
                    if (namespace_a0d533d1::function_4bd83c04(item)) {
                        foreach (attachment in var_a6762160.attachments) {
                            if (!item_world_util::function_7363384a(attachment.var_6be1bec7)) {
                                continue;
                            }
                            attachmentitem = function_4ba8fde(attachment.var_6be1bec7);
                            if (!isdefined(attachmentitem)) {
                                continue;
                            }
                            var_769a94ae = namespace_a0d533d1::function_837f4a57(attachmentitem.var_a6762160);
                            if (!isdefined(var_769a94ae)) {
                                continue;
                            }
                            var_f9f8c0b5 = namespace_a0d533d1::function_dfaca25e(slotid, var_769a94ae);
                            give_inventory_item(attachmentitem, undefined, undefined, var_f9f8c0b5);
                            attachmentitem = get_inventory_item(attachmentitem.networkid);
                            namespace_a0d533d1::function_9e9c82a6(var_92d652f2, attachmentitem, 0);
                        }
                        namespace_a0d533d1::function_6e9e7169(var_92d652f2);
                        weapon = namespace_a0d533d1::function_2b83d3ff(var_92d652f2);
                        if (isdefined(weapon)) {
                            var_92d652f2.amount = self getweaponammoclipsize(namespace_a0d533d1::function_2b83d3ff(var_92d652f2));
                        }
                    }
                }
                var_92d652f2.weaponoptions = item.weaponoptions;
                var_92d652f2.charmindex = item.charmindex;
                var_92d652f2.deathfxindex = item.deathfxindex;
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
    if (!namespace_a0d533d1::function_819781bf()) {
        for (i = 0; i < self.inventory.var_c212de25; i++) {
            if (self.inventory.items[i].networkid === 32767) {
                var_8c6165fc = int(min(itemcount, var_a057551d));
                item.networkid = item_world_util::function_970b8d86(i);
                self.inventory.items[i].amount = var_aec6fa7f;
                self.inventory.items[i].count = var_8c6165fc;
                self.inventory.items[i].id = itemid;
                self.inventory.items[i].networkid = item.networkid;
                self.inventory.items[i].var_a6762160 = var_a6762160;
                self.inventory.items[i].starttime = undefined;
                self.inventory.items[i].endtime = undefined;
                self.inventory.items[i].var_1181c08b = item.var_1181c08b;
                namespace_a0d533d1::function_6e9e7169(self.inventory.items[i]);
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7478aaa8, Offset: 0xd3f8
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
    lootweapons = self namespace_a0d533d1::get_loot_weapons();
    var_51c5992 = min(lootweapons.size, 2);
    if (var_51c5992 > 0) {
        self give_inventory_item(var_73869e24, var_51c5992, 0, 10);
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x90feac58, Offset: 0xd538
// Size: 0x5c
function function_44f1ab43() {
    assert(isplayer(self));
    self function_461de298();
    /#
        self thread function_76eb9bd7();
    #/
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0xbffa3664, Offset: 0xd5a0
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
    hasarmor = self.inventory.items[6].networkid != 32767 && self.inventory.items[6].var_a6762160.itemtype == #"armor";
    return hasarmor;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0xe5ed543e, Offset: 0xd690
// Size: 0xd6
function has_backpack() {
    assert(isplayer(self));
    hasbackpack = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[8]) && isdefined(self.inventory.items[8].var_a6762160) && self.inventory.items[8].var_a6762160.itemtype == #"backpack";
    return hasbackpack;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x54e0ed72, Offset: 0xd770
// Size: 0x10e
function function_471897e2() {
    assert(isplayer(self));
    var_22939dc4 = isdefined(self.inventory) && isdefined(self.inventory.items) && isdefined(self.inventory.items[10]) && isdefined(self.inventory.items[10].var_a6762160) && self.inventory.items[10].var_a6762160.itemtype == #"resource" && self.inventory.items[10].var_a6762160.name == #"resource_item_loot_locker_key";
    return var_22939dc4;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x90c7f750, Offset: 0xd888
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
        var_b74300d3 = item_world_util::get_itemtype(item.var_a6762160);
        if (item_name == var_b74300d3) {
            return item;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xd7e6241e, Offset: 0xd998
// Size: 0x72
function has_inventory_item(slotid) {
    assert(isplayer(self));
    return isdefined(self.inventory.items[slotid]) && self.inventory.items[slotid].networkid != 32767;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x4a3cee0f, Offset: 0xda18
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
// Params 0, eflags: 0x1 linked
// Checksum 0xa45bff60, Offset: 0xdb60
// Size: 0x1a
function function_fe402108() {
    return is_true(self.var_11921c74);
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0x4a6bdab0, Offset: 0xdb88
// Size: 0x9c
function function_e7af31c6(slotid) {
    assert(isplayer(self));
    assert(slotid >= 0 && slotid < 17 + 1 + 8 + 1 + 8 + 1);
    return self.inventory.items[slotid].networkid != 32767;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x658865ed, Offset: 0xdc30
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
        foreach (var_259f58f3 in array(1, 2, 3, 4, 5, 6, 7, 8)) {
            attachmentid = namespace_a0d533d1::function_dfaca25e(weaponid, var_259f58f3);
            if (self.inventory.items[attachmentid].networkid === networkid) {
                return true;
            }
        }
    }
    return false;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xf43b3cfa, Offset: 0xdf18
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
    killstreakbundle = getscriptbundle(item.var_a6762160.killstreak);
    if (killstreakbundle.var_d3413870 == params.killstreaktype) {
        use_inventory_item(item.networkid, 1);
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xff7a4646, Offset: 0xe008
// Size: 0x1f2
function function_db2abc4(item) {
    assert(isplayer(self));
    assert(isdefined(item));
    if (isdefined(item) && isdefined(item.var_a6762160)) {
        if (is_true(item.var_a6762160.consumable)) {
            if (isdefined(item.var_a6762160.equipsound)) {
                self playsoundtoplayer(item.var_a6762160.equipsound, self);
                return;
            }
        }
        switch (item.var_a6762160.itemtype) {
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
            if (isdefined(item.var_a6762160.equipsound)) {
                self playsoundtoplayer(item.var_a6762160.equipsound, self);
            }
            break;
        case #"generic":
            break;
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x518672f7, Offset: 0xe208
// Size: 0x26c
function function_a24d6e36(networkid, notifyclient = 1, var_cda2ff12 = 1) {
    assert(isplayer(self));
    assert(isint(networkid) && networkid != 32767);
    self endon(#"death");
    itemid = function_c48cd17f(networkid);
    if (itemid == 32767) {
        return 0;
    }
    item = get_inventory_item(networkid);
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    if (isdefined(weapon)) {
        self.var_6d2ad74f = weapon;
        slot = self gadgetgetslot(weapon);
        if (slot >= 0 && slot < 3) {
            self function_19ed70ca(slot, 1);
            self gadgetpowerset(slot, 0);
        }
        while (isdefined(self) && (self function_c1cef1ec(weapon) || !self function_bf2312f1(weapon))) {
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
// Params 3, eflags: 0x5 linked
// Checksum 0x8a04112d, Offset: 0xe480
// Size: 0x204
function private function_eb70ad46(networkid, notifyclient = 1, var_cda2ff12 = 1) {
    item = get_inventory_item(networkid);
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    var_a6762160 = item.var_a6762160;
    self.inventory.items[8] = function_520b16d6();
    self.inventory.var_c212de25 = 3;
    self.inventory.var_7658cbec = 0;
    if (notifyclient) {
        self function_b00db06(5, networkid);
    }
    function_9d805044(var_a6762160.itemtype, var_a6762160);
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
// Params 4, eflags: 0x1 linked
// Checksum 0x4d213f3a, Offset: 0xe690
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
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    var_a6762160 = item.var_a6762160;
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
                function_9d805044(var_a6762160.itemtype, var_a6762160);
            }
            if (isdefined(self.var_6d2ad74f) && self.var_6d2ad74f === weapon) {
                self.var_6d2ad74f = undefined;
            }
            if (var_a6762160.itemtype == #"cash") {
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
// Params 8, eflags: 0x1 linked
// Checksum 0xe7f436d0, Offset: 0xeb78
// Size: 0x2d6
function replace_weapon(old_weapon, new_weapon, primary_weapon = 0, var_e47b0bf = 1, var_6086c488 = 0, options = undefined, charmindex = undefined, deathfxindex) {
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
            self replaceweapon(old_weapon, 0, new_weapon, options);
            self takeweapon(old_weapon);
        } else {
            self giveweapon(new_weapon, options);
        }
    } else {
        self giveweapon(new_weapon, options);
    }
    if (isdefined(charmindex) && charmindex >= 0) {
        self function_3fb8b14(new_weapon, charmindex);
    }
    if (isdefined(deathfxindex) && deathfxindex >= 0) {
        self function_a85d2581(new_weapon, deathfxindex);
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
// Params 1, eflags: 0x1 linked
// Checksum 0xda835f49, Offset: 0xee58
// Size: 0x22
function function_85287396(enabled) {
    if (isdefined(self)) {
        self.var_11921c74 = enabled;
    }
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0xbef152f0, Offset: 0xee88
// Size: 0x39e
function function_fba4a353(item) {
    if (!isplayer(self) || !isdefined(self.inventory)) {
        assert(0, "<dev string:x14b>");
        return;
    }
    assert(isdefined(item));
    if (namespace_a0d533d1::function_819781bf()) {
        return 1;
    }
    if (1 && isdefined(item) && isdefined(item.var_a6762160)) {
        slotid = undefined;
        switch (item.var_a6762160.itemtype) {
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
// Params 2, eflags: 0x1 linked
// Checksum 0xbecec6a6, Offset: 0xf230
// Size: 0x1b4
function function_ecd1c667(itemid, count) {
    assert(isplayer(self));
    assert(item_world_util::function_2c7fc531(itemid));
    self endon(#"death");
    item = function_b1702735(itemid);
    assert(item.var_a6762160.itemtype == #"ammo");
    weapon = item.var_a6762160.weapon;
    maxammo = self getweaponammostock(weapon);
    count = int(min(isdefined(count) ? count : maxammo, maxammo));
    if (count <= 0) {
        return;
    }
    self function_fc9f8b05(weapon, count * -1);
    self function_d7944517(item.id, item.var_a6762160.weapon, 1, count);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x39dfd0c, Offset: 0xf3f0
// Size: 0x20c
function function_cfe0e919(networkid, count) {
    assert(isplayer(self));
    assert(isint(count) && count > 0);
    self endon(#"death");
    item = get_inventory_item(networkid);
    if (!isdefined(item) || !isdefined(item.var_a6762160)) {
        return;
    }
    var_aa3af497 = self.inventory.items[7].networkid == networkid || self.inventory.items[12].networkid == networkid;
    if (var_aa3af497 && isdefined(self.var_8181d952) && self.var_8181d952 == item.var_a6762160.weapon) {
        if (item.count == count) {
            count--;
        }
    }
    count = int(min(item.count, count));
    if (count <= 0) {
        return;
    }
    weapon = item.var_a6762160.weapon;
    self function_d7944517(item.id, item.var_a6762160.weapon, count, 0);
    self use_inventory_item(networkid, count);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x1f615f69, Offset: 0xf608
// Size: 0x4e
function function_23335063(networkid, var_cda2ff12 = 1) {
    if (!self remove_inventory_item(networkid, undefined, undefined, var_cda2ff12)) {
        return false;
    }
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x26af96f, Offset: 0xf660
// Size: 0x12c
function function_c4468806(player, item) {
    if (game.state == "pregame" || !isdefined(item)) {
        return;
    }
    data = {#game_time:function_f8d53445(), #player_xuid:int(player getxuid(1)), #item:hash(item.var_a6762160.name)};
    println("<dev string:x1ba>" + item.var_a6762160.name);
    function_92d1707f(#"hash_50be59ef12074ce", data);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x88e8599d, Offset: 0xf798
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
        maxammo = namespace_a0d533d1::function_2879cbe0(self.inventory.var_7658cbec, weapon);
        var_346dc077 = self getweaponammostock(weapon);
        if (var_346dc077 > maxammo) {
            var_f580278d = function_4ba8fde(ammoitem).id;
            function_ecd1c667(var_f580278d, var_346dc077 - maxammo);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0xfc3de51, Offset: 0xf9e8
// Size: 0x6ec
function function_a2c7ce35() {
    assert(isplayer(self));
    var_3e9ef0a1 = array(array(#"frag_grenade_wz_item", #"frag_t9_item", #"frag_t9_item_sr", #"cluster_semtex_wz_item", #"semtex_t9_item", #"semtex_t9_item_sr", #"acid_bomb_wz_item", #"molotov_wz_item", #"molotov_t9_item", #"molotov_t9_item_sr", #"wraithfire_wz_item", #"hatchet_wz_item", #"hatchet_t9_item", #"hatchet_t9_item_sr", #"tomahawk_t8_wz_item", #"seeker_mine_wz_item", #"dart_wz_item", #"hawk_wz_item", #"ultimate_turret_wz_item", #"hash_49bb95f2912e68ad", #"hash_3c9430c4ac7d082e", #"hash_6a5294b915f32d32", #"hash_6cd8041bb6cd21b1", #"hash_6a07ccefe7f84985", #"hash_17f8849a56eba20f", #"satchel_charge_t9_item", #"satchel_charge_t9_item_sr", #"hash_2c9b75b17410f2de"), array(#"swat_grenade_wz_item", #"hash_676aa70930960427", #"concussion_wz_item", #"concussion_t9_item", #"smoke_grenade_wz_item", #"smoke_grenade_wz_item_spring_holiday", #"smoke_t9_item", #"emp_grenade_wz_item", #"spectre_grenade_wz_item", #"hash_5f67f7b32b01ae53", #"hash_725e305ff465e73d", #"concussion_t9_item_sr", #"cymbal_monkey_t9_item_sr", #"hash_76ebb51bb24696a1", #"hash_51f70aff8a2ad330", #"stimshot_t9_item_sr"), array(#"grapple_wz_item", #"hash_12fde8b0da04d262", #"barricade_wz_item", #"spiked_barrier_wz_item", #"trophy_system_wz_item", #"concertina_wire_wz_item", #"sensor_dart_wz_item", #"supply_pod_wz_item", #"trip_wire_wz_item", #"cymbal_monkey_wz_item", #"homunculus_wz_item", #"vision_pulse_wz_item", #"flare_gun_wz_item", #"wz_snowball", #"wz_waterballoon", #"hash_1ae9ade20084359f"));
    var_c77511ea = array(2048, 4096, 8192);
    var_710be50e = array(7);
    for (itemindex = 0; itemindex < 5; itemindex++) {
        var_710be50e[var_710be50e.size] = itemindex;
    }
    for (var_25c45152 = 0; var_25c45152 < var_3e9ef0a1.size; var_25c45152++) {
        if (self.inventory.var_7658cbec & var_c77511ea[var_25c45152]) {
            continue;
        }
        equipmentitems = var_3e9ef0a1[var_25c45152];
        for (index = 0; index < equipmentitems.size; index++) {
            equipmentitem = equipmentitems[index];
            itemspawnpoint = function_4ba8fde(equipmentitem);
            if (!isdefined(itemspawnpoint)) {
                continue;
            }
            maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.var_a6762160);
            for (itemindex = 0; itemindex < var_710be50e.size; itemindex++) {
                item = self.inventory.items[var_710be50e[itemindex]];
                if (item.networkid == 32767) {
                    continue;
                }
                if (item.var_a6762160.name != equipmentitem) {
                    continue;
                }
                if (item.count <= maxstack) {
                    continue;
                }
                var_9311e423 = item.count - maxstack;
                self use_inventory_item(item.networkid, var_9311e423);
                newitem = spawnstruct();
                newitem.id = item.id;
                newitem.var_a6762160 = item.var_a6762160;
                var_77e61fc6 = give_inventory_item(newitem, var_9311e423);
                if (var_77e61fc6 > 0) {
                    self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
                }
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x429564da, Offset: 0x100e0
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
        maxstack = namespace_a0d533d1::function_cfa794ca(self.inventory.var_7658cbec, itemspawnpoint.var_a6762160);
        for (itemindex = 0; itemindex < var_5675add1.size; itemindex++) {
            item = self.inventory.items[var_5675add1[itemindex]];
            if (item.networkid == 32767) {
                continue;
            }
            if (item.var_a6762160.name != healthitem) {
                continue;
            }
            if (item.count <= maxstack) {
                continue;
            }
            var_9311e423 = item.count - maxstack;
            self use_inventory_item(item.networkid, var_9311e423);
            newitem = spawnstruct();
            newitem.id = item.id;
            newitem.var_a6762160 = item.var_a6762160;
            var_77e61fc6 = give_inventory_item(newitem, var_9311e423);
            if (var_77e61fc6 > 0) {
                self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
            }
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x1e118537, Offset: 0x10418
// Size: 0x144
function function_2521e90f() {
    for (index = self.inventory.var_c212de25; index < 5; index++) {
        item = self.inventory.items[index];
        if (item.networkid == 32767) {
            continue;
        }
        newitem = spawnstruct();
        newitem.id = item.id;
        newitem.var_a6762160 = item.var_a6762160;
        newitem.count = item.count;
        remove_inventory_item(item.networkid, 0, 1, 1);
        var_77e61fc6 = give_inventory_item(newitem, newitem.count);
        if (var_77e61fc6 > 0) {
            self function_d7944517(newitem.id, newitem.var_a6762160.weapon, var_77e61fc6, 0);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x4bb71c0f, Offset: 0x10568
// Size: 0x44
function function_ec238da8() {
    function_394d85cd();
    function_a2c7ce35();
    function_2bb3a825();
    function_2521e90f();
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x1 linked
// Checksum 0x8779d23f, Offset: 0x105b8
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
// Params 2, eflags: 0x1 linked
// Checksum 0xa233fd75, Offset: 0x109b0
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
    if (isdefined(fromitem.var_a6762160)) {
        fromitem.networkid = item_world_util::function_970b8d86(var_8f194e5a);
    }
    if (isdefined(toitem.var_a6762160)) {
        toitem.networkid = item_world_util::function_970b8d86(var_c9293a27);
    }
    if (var_8f194e5a == 5) {
        self clientfield::set_player_uimodel("hudItems.healthItemstackCount", function_bba770de(toitem.var_a6762160));
    } else if (var_8f194e5a == 7) {
        self clientfield::set_player_uimodel("hudItems.equipmentStackCount", function_bba770de(toitem.var_a6762160));
    }
    self function_b00db06(12, var_c9293a27, var_8f194e5a);
}

// Namespace item_inventory/item_inventory
// Params 3, eflags: 0x1 linked
// Checksum 0x7951b673, Offset: 0x10ba8
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
        if (!isdefined(weaponitem) || !isdefined(weaponitem.var_a6762160) || weaponitem.var_a6762160.itemtype != #"weapon") {
            assert(0);
            continue;
        }
        currentammo = self getweaponammoclip(namespace_a0d533d1::function_2b83d3ff(weaponitem));
        if (namespace_a0d533d1::function_31a0b1ef(weaponitem, item, 0)) {
            itemtype = item.var_a6762160.itemtype;
            networkid = item.networkid;
            if (notifyclient) {
                self function_b00db06(7, networkid);
            }
            weapon = namespace_a0d533d1::function_2b83d3ff(weaponitem);
            iscurrentweapon = weapon == get_current_weapon();
            function_d019bf1d(var_f0dc4e93, undefined, notifyclient, 0);
            namespace_a0d533d1::function_6e9e7169(weaponitem);
            equip_weapon(weaponitem, iscurrentweapon, undefined, 1, 0);
            newammo = self getweaponammoclipsize(namespace_a0d533d1::function_2b83d3ff(weaponitem));
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
// Params 4, eflags: 0x1 linked
// Checksum 0x687420ba, Offset: 0x10f50
// Size: 0x1d8
function function_41a57271(item, slot, notifyclient = 1, ignoreattachment = undefined) {
    assert(isplayer(self));
    assert(isstruct(item));
    if (!isdefined(item.attachments)) {
        return 0;
    }
    attachments = arraycopy(item.attachments);
    foreach (attachment in attachments) {
        if (!isdefined(attachment) || !isdefined(attachment.var_a6762160)) {
            continue;
        }
        if (isdefined(ignoreattachment) && ignoreattachment.networkid == attachment.networkid) {
            continue;
        }
        if (is_true(attachment.var_a6762160.(slot))) {
            function_b3342af3(get_inventory_item(attachment.networkid), notifyclient);
        }
    }
}

// Namespace item_inventory/item_inventory
// Params 4, eflags: 0x1 linked
// Checksum 0x3206a0ec, Offset: 0x11130
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
    var_a6762160 = item.var_a6762160;
    itemtype = var_a6762160.itemtype;
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
        } else if (namespace_a0d533d1::function_1507e6f0(var_a6762160)) {
            self thread function_ee9ce1c4(var_a6762160, var_dfe6c7e5);
        } else if (itemtype == #"health") {
            self thread function_8214f1b6(var_a6762160, var_dfe6c7e5);
        } else if (itemtype == #"perk_tier_1" || itemtype == #"perk_tier_2" || itemtype == #"perk_tier_3") {
            if (var_a6762160.name == #"hash_6ac2848a2f6492ac") {
                remove_inventory_item(item_world_util::function_970b8d86(8), undefined, undefined, 0);
                function_d86d7ac7();
                function_ec238da8();
            }
        } else if (itemtype == #"scorestreak") {
            slotid = function_b246c573(item.networkid);
            killstreakbundle = getscriptbundle(item.var_a6762160.killstreak);
            if (isdefined(killstreakbundle)) {
                killstreaks::take(killstreakbundle.var_d3413870);
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
// Params 3, eflags: 0x1 linked
// Checksum 0xa07f389d, Offset: 0x11568
// Size: 0x508
function function_3f5b2e2e(item, notifyclient = 1, var_8eb4edca = 1) {
    assert(isplayer(self));
    assert(isstruct(item));
    itemtype = item.var_a6762160.itemtype;
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
    weapon = namespace_a0d533d1::function_2b83d3ff(item);
    item.weaponoptions = self function_fc04b237(weapon, item.weaponoptions);
    if (get_weapon_count() > 1) {
        self replace_weapon(weapon, level.weaponbasemeleeheld, 1);
        foreach (slotid in array(17 + 1, 17 + 1 + 8 + 1)) {
            if (self.inventory.items[slotid].networkid != 32767 && self.inventory.items[slotid].networkid != item.networkid) {
                altweapon = namespace_a0d533d1::function_2b83d3ff(self.inventory.items[slotid]);
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
// Params 3, eflags: 0x1 linked
// Checksum 0x4524533f, Offset: 0x11a78
// Size: 0x2d0
function use_inventory_item(networkid, usecount, *var_dfe6c7e5 = 1) {
    self endon(#"death");
    assert(isplayer(self));
    assert(isint(usecount) && usecount != 32767);
    for (i = 0; i < self.inventory.items.size; i++) {
        if (self.inventory.items[i].networkid === usecount) {
            if (is_true(self.inventory.items[i].var_a6762160.unlimited)) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xeb4c0ac5, Offset: 0x11d50
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
// Params 1, eflags: 0x5 linked
// Checksum 0x9b5b69d5, Offset: 0x120c0
// Size: 0x34
function private function_d8ceeeec(*notifyhash) {
    self val::reset(#"item_killstreak", "freezecontrols_allowlook");
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x7ab15bbf, Offset: 0x12100
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
    vehicletype = item.var_a6762160.vehicle;
    if (item.var_a6762160.weapon.deployable) {
        traceresults = self function_242060b9(item.var_a6762160.weapon);
        if (traceresults.isvalid) {
            if (isdefined(level.var_1f020f16) && isdefined(vehicletype) && isdefined(level.var_1f020f16[vehicletype])) {
                traceresults.isvalid = self [[ level.var_1f020f16[vehicletype] ]](item.var_a6762160.vehicle, item.var_a6762160.weapon, traceresults);
            }
        }
    } else if (isdefined(level.var_4cf92425[vehicletype])) {
        traceresults = self [[ level.var_4cf92425[vehicletype] ]](item.var_a6762160.vehicle);
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
        var_7f11909d = undefined;
        var_2e2dbfa3 = undefined;
        if (isdefined(traceresults.hitent)) {
            var_7f11909d = traceresults.origin - traceresults.hitent.origin;
            var_2e2dbfa3 = traceresults.hitent.angles;
        }
        spawnorigin = traceresults.origin;
        if (isdefined(traceresults.hitent) && isdefined(var_7f11909d)) {
            anglesdelta = traceresults.hitent.angles - var_2e2dbfa3;
            spawnorigin = traceresults.hitent.origin + rotatepoint(var_7f11909d, anglesdelta);
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
// Params 0, eflags: 0x1 linked
// Checksum 0x45235681, Offset: 0x12938
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
        if (!isdefined(item) || !isstruct(item.var_a6762160) || item.var_a6762160.itemtype !== #"cash") {
            continue;
        }
        cash += isdefined(item.var_a6762160.amount) ? item.var_a6762160.amount : 0;
    }
    self.var_a097ccb7 = cash;
    if (self.var_a097ccb7 > 0) {
        self clientfield::set("wz_cash_carrying", 1);
        return;
    }
    self clientfield::set("wz_cash_carrying", 0);
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x864ee66e, Offset: 0x12b30
// Size: 0x1c
function function_9f438f15() {
    self function_6c36ab6b();
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x1 linked
// Checksum 0x22b6a6ec, Offset: 0x12b58
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
        if (!isdefined(item.var_a6762160.var_dba54111) || item.var_a6762160.var_dba54111 == 0) {
            continue;
        }
        reduction += item.var_a6762160.var_dba54111;
    }
    namespace_6615ea91::function_cca7424d(self, reduction);
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0xd0900921, Offset: 0x12c78
// Size: 0xa2
function function_b579540e(item, aat_name) {
    assert(isstruct(item));
    if (!isdefined(item) || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != #"weapon") {
        return false;
    }
    if (!isdefined(aat_name)) {
        return false;
    }
    item.aat = aat_name;
    return true;
}

// Namespace item_inventory/item_inventory
// Params 2, eflags: 0x1 linked
// Checksum 0x4b0d36ad, Offset: 0x12d28
// Size: 0x27a
function function_73ae3380(item, var_a8bccf69) {
    self endon(#"death");
    assert(isstruct(item));
    if (!isdefined(item) || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != #"weapon") {
        return 0;
    }
    if (!isdefined(var_a8bccf69)) {
        return 0;
    }
    if (isdefined(level.var_fee1eaaf) && var_a8bccf69 < 2) {
        if (isdefined(item.aat)) {
            aat_name = item.aat;
        }
        new_item = [[ level.var_fee1eaaf ]](item);
        if (isdefined(new_item)) {
            var_bd31d7b2 = function_ec087745();
            new_item.hidetime = 0;
            dropweapon = function_9d102bbd(new_item, var_bd31d7b2);
            if (isentity(dropweapon)) {
                item_world::consume_item(dropweapon);
            }
            for (currentweapon = self get_current_weapon(); currentweapon.name === #"none"; currentweapon = self get_current_weapon()) {
                waitframe(1);
            }
            var_ec0c35ac = function_230ceec4(currentweapon);
            var_ec0c35ac.var_a8bccf69 = var_a8bccf69;
            if (isdefined(aat_name)) {
                var_ec0c35ac.aat = aat_name;
            }
            self notify(#"hash_75ec9942d2d5fd0f");
            return var_ec0c35ac;
        }
    } else if (var_a8bccf69 >= 2) {
        item.var_a8bccf69 = var_a8bccf69;
    } else {
        return 0;
    }
    self notify(#"hash_75ec9942d2d5fd0f");
    return 1;
}

// Namespace item_inventory/item_inventory
// Params 1, eflags: 0x0
// Checksum 0xedaec95c, Offset: 0x12fb0
// Size: 0xfc
function function_dc5d31be(w_item) {
    a_items = self.inventory.items;
    n_count = 0;
    if (isdefined(a_items)) {
        foreach (item in a_items) {
            if (isdefined(item.var_a6762160) && isdefined(item.count) && w_item === item.var_a6762160.name) {
                n_count += item.count;
            }
        }
    }
    return n_count;
}

// Namespace item_inventory/item_inventory
// Params 0, eflags: 0x5 linked
// Checksum 0x77a91117, Offset: 0x130b8
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
// Params 0, eflags: 0x5 linked
// Checksum 0x6a16a5ef, Offset: 0x131c0
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
    // Checksum 0xfd552c3b, Offset: 0x13290
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
