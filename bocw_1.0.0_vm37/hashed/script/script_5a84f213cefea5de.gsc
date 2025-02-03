#using script_1caf36ff04a85ff6;
#using script_471b31bd963b388e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\loadout_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_1d9319e5;

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 0, eflags: 0x6
// Checksum 0x214e0872, Offset: 0xe0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_f11f051d1c7994a", &preinit, undefined, undefined, #"item_world");
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 0, eflags: 0x4
// Checksum 0x9b149774, Offset: 0x130
// Size: 0x3c
function private preinit() {
    if (!item_inventory::function_7d5553ac()) {
        return;
    }
    level.var_174c7c61 = 1;
    function_116fd9a7();
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 0, eflags: 0x4
// Checksum 0xce094d44, Offset: 0x178
// Size: 0x64
function private function_116fd9a7() {
    item_world::function_861f348d(#"hash_1f0d729dc6dd1202", &function_898628ef);
    item_world::function_861f348d(#"hash_20ffbe34a3390916", &function_6598f0a0);
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 2, eflags: 0x4
// Checksum 0x66e0140c, Offset: 0x1e8
// Size: 0x154
function private function_77512b90(killstreakbundle, hasscorestreak = 0) {
    assert(isplayer(self));
    self notify(#"hash_5cd53481d07fa89c");
    self endon(#"death", #"disconnect", #"hash_5cd53481d07fa89c");
    if (isdefined(self.var_48590990)) {
        waittime = int(3 * 1000) - gettime() - self.var_48590990;
        if (waittime > 0) {
            wait float(waittime) / 1000;
        }
    }
    if (hasscorestreak) {
        wait 1;
    }
    self.var_48590990 = gettime();
    self killstreaks::add_to_notification_queue(level.killstreaks[killstreakbundle.var_d3413870].menuname, undefined, killstreakbundle.var_d3413870, undefined, 1);
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 7, eflags: 0x4
// Checksum 0xea88bd61, Offset: 0x348
// Size: 0x384
function private function_898628ef(item, player, *networkid, *itemid, itemcount, var_aec6fa7f, *slotid) {
    killstreakbundle = getscriptbundle(itemid.itementry.killstreak);
    result = 0;
    killstreakname = undefined;
    if (isdefined(killstreakbundle) && isdefined(killstreakbundle.var_fc0c8eae) && isdefined(killstreakbundle.var_fc0c8eae.name)) {
        killstreakname = killstreakbundle.var_fc0c8eae.name;
    } else if (isdefined(killstreakbundle.var_d3413870)) {
        killstreakname = killstreakbundle.var_d3413870;
    }
    if (isdefined(killstreakname)) {
        hasscorestreak = 0;
        weapons = itemcount getweaponslist();
        foreach (weapon in weapons) {
            var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
            if (!isdefined(var_16f12c31)) {
                continue;
            }
            ammo = itemcount getweaponammostock(weapon);
            hasammo = ammo > 0;
            if (hasammo) {
                itempoint = function_4ba8fde(var_16f12c31);
                level thread item_drop::drop_item(0, undefined, 1, ammo, itempoint.id, itemcount.origin + anglestoforward(itemcount.angles) * randomfloatrange(10, 30), itemcount.angles, 2);
                hasscorestreak = 1;
            }
            itemcount takeweapon(weapon);
        }
        itemcount.pers[#"killstreaks"] = [];
        result = killstreaks::give(killstreakname, undefined, undefined, undefined, undefined);
        if (isdefined(slotid) && slotid > 0 && isdefined(killstreakbundle.var_fc0c8eae)) {
            itemcount loadout::function_3ba6ee5d(killstreakbundle.var_fc0c8eae, slotid);
            itemcount.pers[#"held_killstreak_ammo_count"][killstreakbundle.var_fc0c8eae] = slotid;
        }
        itemcount thread function_77512b90(killstreakbundle, hasscorestreak);
    }
    if (result) {
        return (var_aec6fa7f - 1);
    }
    return var_aec6fa7f;
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 7, eflags: 0x4
// Checksum 0x93b18bc3, Offset: 0x6d8
// Size: 0x9e
function private function_6598f0a0(*item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, *slotid) {
    var_6a4efe8e = var_aec6fa7f clientfield::get_player_uimodel("hud_items.selfReviveAvailable");
    if (var_6a4efe8e) {
        return slotid;
    }
    var_aec6fa7f clientfield::set_player_uimodel("hud_items.selfReviveAvailable", 1);
    return slotid - 1;
}

