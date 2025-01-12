#using script_1caf36ff04a85ff6;
#using script_471b31bd963b388e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_1d9319e5;

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 0, eflags: 0x6
// Checksum 0xe1d420bd, Offset: 0xa8
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"hash_f11f051d1c7994a", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 0, eflags: 0x5 linked
// Checksum 0xc131d2e4, Offset: 0xf8
// Size: 0x2c
function private function_70a657d8() {
    if (!item_inventory::function_7d5553ac()) {
        return;
    }
    function_116fd9a7();
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 0, eflags: 0x5 linked
// Checksum 0x4dd056e5, Offset: 0x130
// Size: 0x34
function private function_116fd9a7() {
    item_world::function_861f348d(#"hash_1f0d729dc6dd1202", &function_898628ef);
}

// Namespace namespace_1d9319e5/namespace_1d9319e5
// Params 7, eflags: 0x5 linked
// Checksum 0xb2f9115e, Offset: 0x170
// Size: 0x2d6
function private function_898628ef(item, player, *networkid, *itemid, itemcount, *var_aec6fa7f, *slotid) {
    killstreakbundle = getscriptbundle(itemcount.var_a6762160.killstreak);
    result = 0;
    killstreakname = undefined;
    if (isdefined(killstreakbundle) && isdefined(killstreakbundle.var_fc0c8eae) && isdefined(killstreakbundle.var_fc0c8eae.name)) {
        killstreakname = killstreakbundle.var_fc0c8eae.name;
    } else if (isdefined(killstreakbundle.var_d3413870)) {
        killstreakname = killstreakbundle.var_d3413870;
    }
    if (isdefined(killstreakname)) {
        weapons = var_aec6fa7f getweaponslist();
        foreach (weapon in weapons) {
            var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
            if (!isdefined(var_16f12c31)) {
                continue;
            }
            hasammo = var_aec6fa7f getweaponammostock(weapon) > 0;
            if (hasammo) {
                itempoint = function_4ba8fde(var_16f12c31);
                level thread item_drop::drop_item(0, undefined, 1, 0, itempoint.id, var_aec6fa7f.origin + anglestoforward(var_aec6fa7f.angles) * randomfloatrange(10, 30), var_aec6fa7f.angles, 2);
                var_aec6fa7f takeweapon(weapon);
            }
        }
        var_aec6fa7f.pers[#"killstreaks"] = [];
        result = killstreaks::give(killstreakname);
    }
    if (result) {
        return (slotid - 1);
    }
    return slotid;
}

