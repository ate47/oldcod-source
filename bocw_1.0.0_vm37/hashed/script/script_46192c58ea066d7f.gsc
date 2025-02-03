#using script_471b31bd963b388e;
#using script_4ba46a0f73534383;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_drop;
#using scripts\killstreaks\killstreaks_shared;

#namespace namespace_234f0efc;

// Namespace namespace_234f0efc/namespace_234f0efc
// Params 1, eflags: 0x0
// Checksum 0x65060987, Offset: 0xc0
// Size: 0xe2
function drop_armor(var_4c42f7cf) {
    assert(isplayer(self));
    itempoint = function_4ba8fde(#"hash_fb37841b0d2d7e7");
    for (index = 0; index < self.var_7d7d976a; index++) {
        level thread item_drop::drop_item(var_4c42f7cf + index, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
    }
    return var_4c42f7cf + index;
}

// Namespace namespace_234f0efc/namespace_234f0efc
// Params 1, eflags: 0x0
// Checksum 0xde07a27, Offset: 0x1b0
// Size: 0x44
function function_d912fa6e(player) {
    assert(isplayer(player));
    return player.var_c52363ab == 10;
}

// Namespace namespace_234f0efc/namespace_234f0efc
// Params 7, eflags: 0x0
// Checksum 0x73c919c7, Offset: 0x200
// Size: 0x7c
function function_dd8cb464(*item, player, *networkid, *itemid, *itemcount, *var_aec6fa7f, *slot) {
    if (!function_d912fa6e(slot)) {
        slot armor_carrier::function_e12c220a(10);
        return true;
    }
    return false;
}

// Namespace namespace_234f0efc/namespace_234f0efc
// Params 1, eflags: 0x0
// Checksum 0xb359adb5, Offset: 0x288
// Size: 0xd6
function function_b31f892b(var_4c42f7cf) {
    assert(isplayer(self));
    index = 0;
    if (function_d912fa6e(self)) {
        itempoint = function_4ba8fde("armor_pouch_item_t9");
        level thread item_drop::drop_item(var_4c42f7cf + index, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
        index++;
    }
    return var_4c42f7cf + index;
}

// Namespace namespace_234f0efc/namespace_234f0efc
// Params 1, eflags: 0x0
// Checksum 0x1e257828, Offset: 0x368
// Size: 0x29a
function function_d5766919(var_4c42f7cf) {
    assert(isplayer(self));
    weapons = self getweaponslist();
    index = 0;
    foreach (weapon in weapons) {
        var_16f12c31 = item_world_util::function_3531b9ba(weapon.name);
        if (!isdefined(var_16f12c31)) {
            continue;
        }
        ammo = self getweaponammostock(weapon);
        hasammo = ammo > 0;
        if (hasammo) {
            itempoint = function_4ba8fde(var_16f12c31);
            killstreakbundle = getscriptbundle(itempoint.itementry.killstreak);
            killstreaks::take(killstreakbundle.var_d3413870);
            var_f8ffe143 = 0;
            if (killstreakbundle.var_fc0c8eae.name == #"inventory_recon_car") {
                if (self hasweapon(killstreakbundle.ksweapon)) {
                    var_f8ffe143 = 1;
                }
            }
            if (!var_f8ffe143) {
                level thread item_drop::drop_item(var_4c42f7cf + index, undefined, 1, ammo, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
                index++;
            }
            self takeweapon(weapon);
        }
    }
    self.pers[#"killstreaks"] = [];
    return var_4c42f7cf + index;
}

// Namespace namespace_234f0efc/namespace_234f0efc
// Params 1, eflags: 0x0
// Checksum 0xadecf2bd, Offset: 0x610
// Size: 0x114
function function_e50b5cec(var_4c42f7cf) {
    assert(isplayer(self));
    var_6a4efe8e = self clientfield::get_player_uimodel("hud_items.selfReviveAvailable");
    if (var_6a4efe8e) {
        self clientfield::set_player_uimodel("hud_items.selfReviveAvailable", 0);
        itempoint = function_4ba8fde(#"hash_b8b2580ac5556e1");
        level thread item_drop::drop_item(var_4c42f7cf + 1, undefined, 1, 0, itempoint.id, self.origin, (0, randomintrange(0, 360), 0), 2);
        return (var_4c42f7cf + 1);
    }
    return var_4c42f7cf;
}

