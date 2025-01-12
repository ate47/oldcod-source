#using script_1287f54612f9bfce;
#using script_18077945bb84ede7;
#using script_1caf36ff04a85ff6;
#using script_355c6e84a79530cb;
#using script_3751b21462a54a7d;
#using script_471b31bd963b388e;
#using script_7d7ac1f663edcdc8;
#using script_7fc996fe8678852;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\zm_utility;

#namespace namespace_1cc7b406;

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x6
// Checksum 0x38f8e05e, Offset: 0x1b0
// Size: 0x54
function private autoexec __init__system__() {
    system::register(#"hash_49e3cc2797ad6fbc", &function_70a657d8, &postinit, undefined, #"hash_f81b9dea74f0ee");
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x1 linked
// Checksum 0xa9be80a6, Offset: 0x210
// Size: 0x34
function function_70a657d8() {
    level.var_3ed9fd33 = sr_crafting_table_menu::register();
    /#
        level.var_633b283d = &function_633b283d;
    #/
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x1 linked
// Checksum 0xf5d74a1e, Offset: 0x250
// Size: 0x94
function postinit() {
    sr_scrap::init();
    var_f5ae494f = struct::get_array(#"content_destination", "variantname");
    if (zm_utility::is_classic() && isdefined(var_f5ae494f) && var_f5ae494f.size > 0) {
        level thread function_3aa5909e(var_f5ae494f[0]);
    }
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 3, eflags: 0x1 linked
// Checksum 0x66850792, Offset: 0x2f0
// Size: 0xc0
function function_7dddb953(var_beee4994, *hint_string, *model) {
    if (!isdefined(model)) {
        return;
    }
    foreach (var_7d0e37f8 in model) {
        function_db05041b(var_7d0e37f8, #"hash_1e1b751abcb0c5b6", &function_e3ad9f54);
    }
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 3, eflags: 0x1 linked
// Checksum 0xf27f5d69, Offset: 0x3b8
// Size: 0x27c
function function_db05041b(struct, hint_string, callbackfunction) {
    assert(isstruct(struct), "<dev string:x38>");
    assert(isfunctionptr(callbackfunction), "<dev string:x5e>");
    assert(isdefined(hint_string), "<dev string:x8b>");
    scriptmodel = namespace_8b6a9d79::spawn_script_model(struct, #"hash_55343c243e86e64");
    if (zm_utility::is_survival()) {
        objid = gameobjects::get_next_obj_id();
        struct.objectiveid = objid;
        scriptmodel.objectiveid = objid;
        objective_add(objid, "active", scriptmodel, #"hash_72c703e01db3de5d");
        if (!isdefined(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = [];
        } else if (!isarray(level.var_6bf8ee58)) {
            level.var_6bf8ee58 = array(level.var_6bf8ee58);
        }
        level.var_6bf8ee58[level.var_6bf8ee58.size] = objid;
    }
    trigger = namespace_8b6a9d79::function_214737c7(struct, callbackfunction, hint_string, undefined, 128, 128, 0, (0, 0, 50));
    trigger.scriptmodel = scriptmodel;
    scriptmodel.trigger = trigger;
    scriptmodel clientfield::set("safehouse_machine_spawn_rob", 1);
    playsoundatposition(#"hash_5c2fc4437449ddb4", struct.origin);
    playfx("sr/fx9_safehouse_mchn_workbench_spawn", struct.origin);
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 1, eflags: 0x1 linked
// Checksum 0xf9335052, Offset: 0x640
// Size: 0x11c
function function_e3ad9f54(eventstruct) {
    player = eventstruct.activator;
    machine = self.scriptmodel;
    assert(isdefined(machine), "<dev string:xbb>");
    if (isplayer(player)) {
        if (!level.var_3ed9fd33 sr_crafting_table_menu::is_open(player) && !player clientfield::get_player_uimodel("hudItems.survivalOverlayOpen")) {
            player notify(#"hash_6dd2905cac0ff8d0");
            level.var_3ed9fd33 sr_crafting_table_menu::open(player, 0);
            player thread function_4b23ad31(machine, self);
            player namespace_553954de::function_14bada94();
        }
    }
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 2, eflags: 0x1 linked
// Checksum 0x8008f282, Offset: 0x768
// Size: 0xee
function function_6c71e778(machine, trigger) {
    if (!isplayer(self) || !isdefined(level.var_3ed9fd33)) {
        return;
    }
    if (isdefined(machine) && isdefined(trigger)) {
        trigger sethintstring(#"hash_1e1b751abcb0c5b6");
        if (isdefined(machine.objectiveid)) {
            objective_setvisibletoplayer(machine.objectiveid, self);
        }
    }
    level.var_3ed9fd33 sr_crafting_table_menu::close(self);
    self namespace_553954de::function_548f282();
    self notify(#"hash_8a8d04156e14d76");
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 0, eflags: 0x0
// Checksum 0x8d69916f, Offset: 0x860
// Size: 0xaa
function function_366ba7f6() {
    self notify("47ee046f8e4dd27a");
    self endon("47ee046f8e4dd27a");
    self endon(#"death");
    if (!isdefined(self.var_496b54df)) {
        self.var_496b54df = 0;
    }
    if (!self.var_496b54df) {
        self.var_496b54df = 1;
        playsoundatposition(#"hash_12cfa31c1fb4a04", self.origin + (0, 0, 50));
        return;
    }
    wait 30;
    self.var_496b54df = 0;
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 1, eflags: 0x1 linked
// Checksum 0x6c54e8a8, Offset: 0x918
// Size: 0x16
function function_2c5b6acc(var_438da649) {
    return var_438da649.var_b5ec8024;
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 1, eflags: 0x1 linked
// Checksum 0xeaafdfaf, Offset: 0x938
// Size: 0x16
function function_3d272dc5(var_438da649) {
    return var_438da649.var_2d7d77d0;
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 2, eflags: 0x1 linked
// Checksum 0x7d585d7d, Offset: 0x958
// Size: 0xdc
function function_a4aa10f4(machine, trigger) {
    self endon(#"disconnect", #"death", #"hash_8a8d04156e14d76");
    while (distance2d(self.origin, machine.origin) <= 128 && !self laststand::player_is_in_laststand() && !self isinvehicle()) {
        waitframe(1);
        if (!isdefined(machine)) {
            break;
        }
    }
    self function_6c71e778(machine, trigger);
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 2, eflags: 0x1 linked
// Checksum 0xd320f241, Offset: 0xa40
// Size: 0x2a6
function function_4b23ad31(machine, trigger) {
    self endon(#"hash_6dd2905cac0ff8d0");
    trigger sethintstring("");
    if (isdefined(machine.objectiveid)) {
        objective_setinvisibletoplayer(machine.objectiveid, self);
    }
    self endoncallback(&function_6c71e778, #"death");
    self thread function_a4aa10f4(machine, trigger);
    while (true) {
        waitresult = self waittill(#"menuresponse");
        menu = waitresult.menu;
        response = waitresult.response;
        intpayload = waitresult.intpayload;
        if (menu == #"sr_crafting_table_menu") {
            switch (waitresult.response) {
            case #"hash_300cd920d1c2290e":
                var_438da649 = function_b143666d(intpayload, 1);
                var_1a988176 = function_3d272dc5(var_438da649);
                var_1d1d4a2a = function_2c5b6acc(var_438da649);
                if (!isdefined(var_1d1d4a2a)) {
                    var_1d1d4a2a = 0;
                }
                var_3069fe3 = self sr_scrap::function_c29a8aa1(var_1d1d4a2a);
                if (var_3069fe3) {
                    self give_item(var_1a988176);
                    self sr_scrap::function_3610299b(var_1d1d4a2a);
                } else {
                    machine playsoundtoplayer(#"uin_default_action_denied", self);
                }
                break;
            case #"hash_383c519d3bdac984":
                self notify(#"hash_8a8d04156e14d76");
                self function_6c71e778(machine, trigger);
                return;
            }
        }
    }
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 1, eflags: 0x1 linked
// Checksum 0x5b438b65, Offset: 0xcf0
// Size: 0x25c
function give_item(itemname) {
    self endon(#"death");
    if (!isdefined(itemname) || itemname == #"") {
        return;
    }
    item = function_4ba8fde(itemname);
    currentweapon = self getcurrentweapon();
    if (isdefined(item)) {
        var_fa3df96 = self item_inventory::function_e66dcff5(item);
        if (isdefined(var_fa3df96)) {
            if (!item_world_util::function_db35e94f(item.networkid)) {
                item.networkid = item_world_util::function_970b8d86(var_fa3df96);
            }
            if (isdefined(currentweapon) && killstreaks::is_killstreak_weapon(currentweapon) && var_fa3df96 == 17) {
                var_c5eb2acf = self.inventory.items[17 + 1];
                var_c5eb2acf = self namespace_a0d533d1::function_2b83d3ff(var_c5eb2acf);
                self switchtoweapon(var_c5eb2acf, 1);
                self waittill(#"weapon_change");
                waitframe(1);
            }
            item.hidetime = 0;
            if (self.inventory.items[var_fa3df96].networkid != 32767 && self.inventory.items[var_fa3df96].var_a6762160.name != item.var_a6762160.name) {
                self item_inventory::function_fba40e6c(item);
            } else {
                item_world::function_de2018e3(item, self, var_fa3df96);
            }
            return;
        }
        item_world::function_de2018e3(item, self);
    }
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 2, eflags: 0x0
// Checksum 0x4d00a114, Offset: 0xf58
// Size: 0x1ac
function give_equipment(itemname, var_738dfc81) {
    for (i = 0; i < var_738dfc81; i++) {
        point = function_4ba8fde(itemname);
        if (isdefined(point) && isdefined(point.var_a6762160)) {
            dropitem = self item_drop::drop_item(i, point.var_a6762160.weapon, 1, point.var_a6762160.amount, point.id, self.origin, self.angles);
            if (isdefined(dropitem)) {
                var_641d3dc2 = dropitem.var_a6762160.itemtype != #"attachment";
                var_a6762160 = dropitem.var_a6762160;
                var_1035544d = self item_world::pickup_item(dropitem, var_641d3dc2);
                if (is_true(var_1035544d)) {
                    if (isdefined(var_a6762160)) {
                        inventoryitem = self item_inventory::function_8babc9f9(var_a6762160);
                    }
                    if (isdefined(inventoryitem)) {
                        self item_inventory::equip_equipment(inventoryitem);
                    }
                    continue;
                }
                self item_inventory::function_fba40e6c(dropitem);
            }
        }
    }
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 1, eflags: 0x1 linked
// Checksum 0x56441422, Offset: 0x1110
// Size: 0x44
function function_3aa5909e(destination) {
    level flag::wait_till("start_zombie_round_logic");
    waittillframeend();
    function_18dfa93a(destination);
}

// Namespace namespace_1cc7b406/namespace_1cc7b406
// Params 1, eflags: 0x1 linked
// Checksum 0xa7f35fd4, Offset: 0x1160
// Size: 0x164
function function_18dfa93a(destination) {
    foreach (location in destination.locations) {
        crafting_table = location.instances[#"crafting_table"];
        if (isdefined(crafting_table)) {
            children = namespace_8b6a9d79::function_f703a5a(crafting_table);
            foreach (child in children) {
                function_db05041b(child, #"hash_1e1b751abcb0c5b6", &function_e3ad9f54);
            }
        }
    }
}

/#

    // Namespace namespace_1cc7b406/namespace_1cc7b406
    // Params 0, eflags: 0x0
    // Checksum 0xf3d5f6a2, Offset: 0x12d0
    // Size: 0x3b4
    function function_633b283d() {
        level endon(#"game_ended");
        setdvar(#"hash_3b28c5b5ac46d28d", "<dev string:xe1>");
        adddebugcommand("<dev string:xe5>" + function_9e72a96(#"concussion_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x139>" + function_9e72a96(#"cymbal_monkey_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x187>" + function_9e72a96(#"item_survival_scorestreak_deathmachine") + "<dev string:x134>");
        adddebugcommand("<dev string:x1d5>" + function_9e72a96(#"item_survival_scorestreak_flamethrower") + "<dev string:x134>");
        adddebugcommand("<dev string:x222>" + function_9e72a96(#"frag_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x26f>" + function_9e72a96(#"item_survival_scorestreak_pineapple_gun") + "<dev string:x134>");
        adddebugcommand("<dev string:x2c0>" + function_9e72a96(#"molotov_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x307>" + function_9e72a96(#"satchel_charge_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x356>" + function_9e72a96(#"stimshot_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x3a0>" + function_9e72a96(#"self_revive_sr_item") + "<dev string:x134>");
        adddebugcommand("<dev string:x3ec>" + function_9e72a96(#"semtex_t9_item_sr") + "<dev string:x134>");
        adddebugcommand("<dev string:x433>" + function_9e72a96(#"item_survival_scorestreak_ultimate_turret") + "<dev string:x134>");
        adddebugcommand("<dev string:x481>" + function_9e72a96(#"hatchet_t9_item_sr") + "<dev string:x134>");
        function_cd140ee9(#"hash_3b28c5b5ac46d28d", &function_7a1fc37c);
    }

    // Namespace namespace_1cc7b406/namespace_1cc7b406
    // Params 1, eflags: 0x0
    // Checksum 0x2d1244db, Offset: 0x1690
    // Size: 0x11c
    function function_7a1fc37c(params) {
        self notify("<dev string:x4cc>");
        self endon("<dev string:x4cc>");
        waitframe(1);
        foreach (player in getplayers()) {
            if (params.name === #"hash_3b28c5b5ac46d28d") {
                player give_item(hash(params.value));
            }
        }
        setdvar(#"hash_3b28c5b5ac46d28d", "<dev string:xe1>");
    }

#/
