#using scripts\core_common\armor;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\system_shared;

#namespace namespace_2ed67032;

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x6
// Checksum 0x7eb9cd33, Offset: 0xb8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_7aac5c09cf9461e3", &function_70a657d8, undefined, &finalize, undefined);
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x4
// Checksum 0x67a09966, Offset: 0x108
// Size: 0x7c
function private function_70a657d8() {
    clientfield::register_clientuimodel("hudItems.armorPlateCount", 1, 3, "int");
    callback::on_spawned(&on_player_spawned);
    callback::add_callback(#"on_loadout", &on_player_loadout);
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x4
// Checksum 0xdc82de6a, Offset: 0x190
// Size: 0x4c
function private finalize() {
    item_world::function_861f348d(#"generic_pickup", &function_e74225a7);
    level thread function_b08d6eed();
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x4
// Checksum 0xe4e5ae7a, Offset: 0x1e8
// Size: 0x34
function private on_player_spawned() {
    self.var_7d7d976a = 0;
    self clientfield::set_player_uimodel("hudItems.armorPlateCount", self.var_7d7d976a);
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x4
// Checksum 0x3276e568, Offset: 0x228
// Size: 0x8c
function private on_player_loadout() {
    if (is_true(getgametypesetting(#"hash_5700fdc9d17186f7"))) {
        self armor::set_armor(225, 225, 2, 0.4, 1, 0.5, 0, 1, 1, 1);
    }
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 7, eflags: 0x4
// Checksum 0xef1cf94b, Offset: 0x2c0
// Size: 0xf0
function private function_e74225a7(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, *slot) {
    if (itemcount.var_a6762160.itemtype == #"armor_shard") {
        var_82da4e0 = int(min(slot, 5 - var_aec6fa7f.var_7d7d976a));
        var_aec6fa7f.var_7d7d976a += var_82da4e0;
        var_aec6fa7f clientfield::set_player_uimodel("hudItems.armorPlateCount", var_aec6fa7f.var_7d7d976a);
        return (slot - var_82da4e0);
    }
    return slot;
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 0, eflags: 0x4
// Checksum 0x26198c72, Offset: 0x3b8
// Size: 0x252
function private function_b08d6eed() {
    while (true) {
        time = gettime();
        foreach (player in getplayers()) {
            if (!isdefined(player.var_7d7d976a) || player.var_7d7d976a <= 0 || player laststand::player_is_in_laststand()) {
                continue;
            }
            var_2e2f19ff = player armor::get_armor();
            if (var_2e2f19ff >= 225) {
                continue;
            }
            if (isdefined(player.var_93507e9d) && player.var_93507e9d > time) {
                continue;
            }
            if (player function_315b0f70()) {
                if (!isdefined(player.var_46ea520c)) {
                    player.var_46ea520c = time;
                }
            } else if (player weaponswitchbuttonpressed()) {
                if (!isdefined(player.var_46ea520c)) {
                    player.var_46ea520c = time + 500;
                }
            } else {
                player.var_46ea520c = undefined;
                continue;
            }
            if (isdefined(player.var_46ea520c)) {
                if (player.var_46ea520c <= time) {
                    player.var_46ea520c = undefined;
                    player.var_93507e9d = time + 750;
                    amount = var_2e2f19ff + 75;
                    amount = int(min(amount, 225));
                    player thread function_d66636df(amount);
                }
            }
        }
        waitframe(1);
    }
}

// Namespace namespace_2ed67032/namespace_2ed67032
// Params 1, eflags: 0x4
// Checksum 0x9d3e0d11, Offset: 0x618
// Size: 0x1a4
function private function_d66636df(amount) {
    self endon(#"death");
    var_8ef8b9e8 = getweapon(#"weapon_armor");
    self giveweapon(var_8ef8b9e8);
    self switchtoweapon(var_8ef8b9e8, 1);
    while (self getcurrentweapon() != var_8ef8b9e8) {
        waitframe(1);
    }
    self.var_7d7d976a -= 1;
    self clientfield::set_player_uimodel("hudItems.armorPlateCount", self.var_7d7d976a);
    self armor::set_armor(amount, 225, 2, 0.4, 1, 0.5, 0, 1, 1, 1);
    self playlocalsound(#"hash_69949bb7db9ef21e");
    while (self getcurrentweapon() == var_8ef8b9e8) {
        waitframe(1);
    }
    self takeweapon(var_8ef8b9e8);
}

