#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;

#namespace zm_items;

// Namespace zm_items/zm_items
// Params 0, eflags: 0x2
// Checksum 0xf382aabe, Offset: 0xf0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_items", &__init__, &__main__, undefined);
}

// Namespace zm_items/zm_items
// Params 0, eflags: 0x0
// Checksum 0x938a0b60, Offset: 0x140
// Size: 0xe4
function __init__() {
    if (!isdefined(level.var_6ca71ac9)) {
        level.var_6ca71ac9 = 0;
    }
    if (!isdefined(level.item_list)) {
        level.item_list = [];
    }
    if (!isdefined(level.item_spawns)) {
        level.item_spawns = [];
    }
    if (!isdefined(level.item_inventory)) {
        level.item_inventory = [];
    }
    if (!isdefined(level.item_callbacks)) {
        level.item_callbacks = [];
    }
    clientfield::register("item", "highlight_item", 1, 2, "int");
    callback::on_spawned(&player_on_spawned);
}

// Namespace zm_items/zm_items
// Params 0, eflags: 0x0
// Checksum 0x21741951, Offset: 0x230
// Size: 0x3b0
function __main__() {
    a_items = getitemarray();
    foreach (item in a_items) {
        w_item = item.item;
        if (isdefined(w_item) && isdefined(w_item.craftitem) && w_item.craftitem) {
            tname = w_item;
            if (!isdefined(level.item_spawns[tname])) {
                level.item_spawns[tname] = [];
            }
            if (!isdefined(level.item_spawns[tname])) {
                level.item_spawns[tname] = [];
            } else if (!isarray(level.item_spawns[tname])) {
                level.item_spawns[tname] = array(level.item_spawns[tname]);
            }
            level.item_spawns[tname][level.item_spawns[tname].size] = item;
            if (!isdefined(level.item_list)) {
                level.item_list = [];
            } else if (!isarray(level.item_list)) {
                level.item_list = array(level.item_list);
            }
            if (!isinarray(level.item_list, w_item)) {
                level.item_list[level.item_list.size] = w_item;
            }
        }
    }
    foreach (a_items in level.item_spawns) {
        var_176428d1 = a_items[0].item.var_b729f782;
        if (isdefined(level.var_acbbfe4f)) {
            a_items = [[ level.var_acbbfe4f ]](a_items);
        } else {
            a_items = array::randomize(a_items);
        }
        var_928d7083 = 0;
        /#
            var_928d7083 = getdvarint(#"hash_7f8707c59bcda3cb", 0);
        #/
        if (var_928d7083 === 0) {
            if (a_items.size > var_176428d1) {
                for (i = var_176428d1; i < a_items.size; i++) {
                    a_items[i] delete();
                }
            }
        }
    }
    level thread function_42a78915();
    /#
    #/
}

// Namespace zm_items/zm_items
// Params 0, eflags: 0x0
// Checksum 0xf8b82947, Offset: 0x5e8
// Size: 0x32
function player_on_spawned() {
    if (!isdefined(self.item_inventory)) {
        self.item_inventory = [];
    }
    if (!isdefined(self.item_slot_inventory)) {
        self.item_slot_inventory = [];
    }
}

// Namespace zm_items/zm_items
// Params 2, eflags: 0x0
// Checksum 0xb7a780fd, Offset: 0x628
// Size: 0x100
function function_187a472b(w_item, fn_callback) {
    if (!isdefined(level.item_callbacks)) {
        level.item_callbacks = [];
    }
    if (!isdefined(level.item_callbacks[w_item])) {
        level.item_callbacks[w_item] = [];
    }
    if (!isdefined(level.item_callbacks[w_item])) {
        level.item_callbacks[w_item] = [];
    } else if (!isarray(level.item_callbacks[w_item])) {
        level.item_callbacks[w_item] = array(level.item_callbacks[w_item]);
    }
    level.item_callbacks[w_item][level.item_callbacks[w_item].size] = fn_callback;
}

// Namespace zm_items/zm_items
// Params 0, eflags: 0x4
// Checksum 0x4b172fa2, Offset: 0x730
// Size: 0x60
function private function_42a78915() {
    while (true) {
        waitresult = level waittill(#"player_bled_out");
        player = waitresult.player;
        player thread function_a0cfbf62(player);
    }
}

// Namespace zm_items/zm_items
// Params 1, eflags: 0x4
// Checksum 0xfb11c1a1, Offset: 0x798
// Size: 0x110
function private function_a0cfbf62(player) {
    foreach (item in level.item_list) {
        if (item.var_8fb162ce && isdefined(player.item_inventory[item]) && player.item_inventory[item]) {
            if (item.var_73984566) {
                assertmsg("<dev string:x30>" + item.name + "<dev string:x3c>");
                continue;
            }
            function_3522557d(player, item);
        }
    }
}

// Namespace zm_items/zm_items
// Params 2, eflags: 0x0
// Checksum 0x19b2983e, Offset: 0x8b0
// Size: 0x11a
function player_has(player, w_item) {
    if (!(isdefined(w_item.craftitem) && w_item.craftitem) && isdefined(player)) {
        if (w_item.var_73984566) {
            assertmsg("<dev string:x8e>" + w_item.name + "<dev string:x96>");
        } else {
            return player hasweapon(w_item);
        }
    }
    if (w_item.var_73984566) {
        holder = level;
    } else {
        holder = player;
    }
    if (!isdefined(holder.item_inventory)) {
        holder.item_inventory = [];
    }
    return isdefined(holder.item_inventory[w_item]) && holder.item_inventory[w_item];
}

// Namespace zm_items/zm_items
// Params 2, eflags: 0x0
// Checksum 0x394c603b, Offset: 0x9d8
// Size: 0x25c
function player_pick_up(player, w_item) {
    if (w_item.var_73984566) {
        holder = level;
    } else {
        holder = player;
    }
    if (!isdefined(holder.item_inventory)) {
        holder.item_inventory = [];
    }
    holder.item_inventory[w_item] = 1;
    if (w_item.var_3546ec5) {
        if (isdefined(holder.item_slot_inventory[w_item.var_3546ec5])) {
            player function_3522557d(holder, holder.item_slot_inventory[w_item.var_3546ec5]);
        }
        holder.item_slot_inventory[w_item.var_3546ec5] = w_item;
    }
    level notify(#"component_collected", {#component:w_item, #holder:holder});
    player notify(#"component_collected", {#component:w_item, #holder:holder});
    if (isdefined(level.item_callbacks[w_item])) {
        foreach (callback in level.item_callbacks[w_item]) {
            player [[ callback ]](holder, w_item);
        }
    }
    if (!(isdefined(level.var_6ca71ac9) && level.var_6ca71ac9) && player hasweapon(w_item)) {
        player takeweapon(w_item);
    }
}

// Namespace zm_items/zm_items
// Params 2, eflags: 0x0
// Checksum 0xcc5b23f9, Offset: 0xc40
// Size: 0x116
function player_take(player, w_item) {
    if (!(isdefined(w_item.craftitem) && w_item.craftitem) && isdefined(player)) {
        if (w_item.var_73984566) {
            assertmsg("<dev string:x8e>" + w_item.name + "<dev string:x96>");
        } else {
            player zm_weapons::weapon_take(w_item);
        }
    }
    if (w_item.var_73984566) {
        holder = level;
    } else {
        holder = player;
        player zm_weapons::weapon_take(w_item);
    }
    if (!isdefined(holder.item_inventory)) {
        holder.item_inventory = [];
    }
    holder.item_inventory[w_item] = 0;
}

// Namespace zm_items/zm_items
// Params 2, eflags: 0x0
// Checksum 0x4aceb960, Offset: 0xd60
// Size: 0x13a
function function_3522557d(holder, w_item) {
    holder.item_inventory[w_item] = 0;
    if (w_item.var_3546ec5) {
        holder.item_slot_inventory[w_item.var_3546ec5] = undefined;
    }
    level notify(#"component_lost", {#component:w_item, #holder:holder});
    self notify(#"component_lost", {#component:w_item, #holder:holder});
    if (self hasweapon(w_item)) {
        self takeweapon(w_item);
    }
    new_item = spawn_item(w_item, self.origin + (0, 0, 8), self.angles);
    return new_item;
}

// Namespace zm_items/zm_items
// Params 4, eflags: 0x0
// Checksum 0x1699717b, Offset: 0xea8
// Size: 0x62
function spawn_item(w_item, v_origin, v_angles, var_70e0ebdf = 1) {
    new_item = spawnweapon(w_item, v_origin, v_angles, var_70e0ebdf);
    return new_item;
}

/#

    // Namespace zm_items/zm_items
    // Params 0, eflags: 0x0
    // Checksum 0x257edbf6, Offset: 0xf18
    // Size: 0x102
    function debug_items() {
        for (;;) {
            a_items = getitemarray();
            foreach (item in a_items) {
                w_item = item.item;
                if (isdefined(w_item) && isdefined(w_item.craftitem) && w_item.craftitem) {
                    sphere(item.origin, 6, (0, 0, 1), 1, 0, 12, 20);
                }
            }
            wait 1;
        }
    }

#/
