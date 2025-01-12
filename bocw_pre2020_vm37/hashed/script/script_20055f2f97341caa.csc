#using script_3d35e2ff167b3a82;
#using script_680dddbda86931fa;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;

#namespace item_drop;

// Namespace item_drop/item_drop
// Params 0, eflags: 0x6
// Checksum 0xa978adf6, Offset: 0x130
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"item_drop", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x15c54180, Offset: 0x180
// Size: 0x64
function private function_70a657d8() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    function_2777823f();
    level.item_spawn_drops = [];
    level.var_624588d5 = [];
    level.var_d49a1a10 = [];
    level thread function_b8f6e02f();
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x5 linked
// Checksum 0xf8dd9505, Offset: 0x1f0
// Size: 0x224
function private function_2777823f() {
    clientfield::register("missile", "dynamic_item_drop_falling", 1, 1, "int", undefined, 0, 0);
    clientfield::register("missile", "dynamic_item_drop_count", 1, 10, "int", &function_fd47982d, 0, 0);
    clientfield::register("missile", "dynamic_item_drop", 1, 4, "int", &function_a517a859, 0, 0);
    clientfield::register("scriptmover", "dynamic_item_drop_falling", 1, 1, "int", undefined, 0, 0);
    clientfield::register("scriptmover", "dynamic_item_drop_count", 1, 10, "int", &function_fd47982d, 0, 0);
    clientfield::register("scriptmover", "dynamic_item_drop", 1, 4, "int", &function_a517a859, 0, 0);
    clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int", &function_e7bb925a, 0, 0);
    clientfield::register("scriptmover", "dynamic_stash_type", 1, 2, "int", &function_63226f88, 0, 0);
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x7c43253a, Offset: 0x420
// Size: 0x142
function private function_b8f6e02f() {
    while (true) {
        item_world::function_1b11e73c();
        reset = is_true(level flag::get(#"item_world_reset"));
        var_d68d9a4d = level.var_d49a1a10.size;
        for (index = 0; index < var_d68d9a4d; index++) {
            var_5c6af5cf = level.var_d49a1a10[index];
            level.var_d49a1a10[index] = undefined;
            if (!isdefined(var_5c6af5cf) || !isdefined(var_5c6af5cf.item)) {
                continue;
            }
            if (var_5c6af5cf.reset !== reset) {
                continue;
            }
            profilestart();
            var_5c6af5cf.item function_67189b6b(var_5c6af5cf.localclientnum, var_5c6af5cf.newval);
            profilestop();
        }
        level.var_d49a1a10 = [];
        if (reset) {
            break;
        }
        waitframe(1);
    }
}

// Namespace item_drop/item_drop
// Params 2, eflags: 0x5 linked
// Checksum 0xac1589d5, Offset: 0x570
// Size: 0x4cc
function private function_67189b6b(localclientnum, newval) {
    if (self.id === 32767 && !(newval == 2 || newval == 3)) {
        return;
    }
    stashitem = (newval & 4) != 0;
    newval &= -5;
    self.falling = self clientfield::get("dynamic_item_drop_falling");
    if (newval == 0) {
        if (isdefined(self) && isdefined(self.networkid) && isdefined(level.item_spawn_drops[self.networkid])) {
            arrayremoveindex(level.item_spawn_drops, self.networkid, 1);
        }
        return;
    }
    if (newval == 1) {
        assert(self.id < 1024);
        if (self.id >= 1024) {
            return;
        }
        self.networkid = item_world_util::function_1f0def85(self);
        self.hidetime = 0;
        if (stashitem) {
            self.hidetime = -1;
        }
        if (self.id != 32767 && self.id < function_8322cf16()) {
            self.var_a6762160 = function_b1702735(self.id).var_a6762160;
            self function_1fe1281(localclientnum, clientfield::get("dynamic_item_drop_count"));
        }
        arrayremovevalue(level.item_spawn_drops, undefined, 1);
        level.item_spawn_drops[self.networkid] = self;
        item_world::function_b78a9820(localclientnum);
        player = function_5c10bd79(localclientnum);
        player item_world::show_item(localclientnum, self.networkid, !stashitem);
        if (isplayer(player) && distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(1350)) {
            player.var_506495f9 = 1;
            clientdata = item_world::function_a7e98a1a(localclientnum);
            model = self item_world::function_7731d23c(clientdata);
            if (isdefined(model)) {
                model show();
                item_world::function_84964a9e(localclientnum, self.var_a6762160, model, self.networkid);
            }
        }
        item_inventory::function_b1136fc8(localclientnum, self);
        return;
    }
    if (newval == 2 || newval == 3) {
        self.hidetime = gettime();
        self.networkid = item_world_util::function_1f0def85(self);
        if (newval == 2) {
            item_inventory::function_31868137(localclientnum, self);
        } else {
            item_inventory::function_d1da833d(localclientnum, self);
        }
        item_world::function_b78a9820(localclientnum);
        item_world::function_2990e5f(localclientnum, self);
        if (isdefined(self.networkid) && getdvarint(#"hash_99bb0233e482c77", 0)) {
            level.item_spawn_drops[self.networkid] = undefined;
        }
        player = function_5c10bd79(localclientnum);
        player item_world::hide_item(localclientnum, self.networkid);
    }
}

// Namespace item_drop/item_drop
// Params 1, eflags: 0x5 linked
// Checksum 0x1e7ef2, Offset: 0xa48
// Size: 0x74
function private function_1a45bc2a(item) {
    if (!isdefined(item)) {
        return false;
    }
    if (!isdefined(item.type) || item.type != #"scriptmover" && item.type != #"missile") {
        return false;
    }
    return true;
}

// Namespace item_drop/item_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x8eea850c, Offset: 0xac8
// Size: 0x7c
function function_fd47982d(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (!isdefined(self.id) || !isdefined(self.var_a6762160)) {
        return;
    }
    self function_1fe1281(fieldname, bwastimejump);
}

// Namespace item_drop/item_drop
// Params 2, eflags: 0x1 linked
// Checksum 0x6b10b9c8, Offset: 0xb50
// Size: 0x1a4
function function_1fe1281(localclientnum, newval) {
    if (!isdefined(self)) {
        return;
    }
    assert(isdefined(self.id));
    assert(isdefined(self.var_a6762160));
    if (!isdefined(self.id) || !isdefined(self.var_a6762160)) {
        return;
    }
    if (self.var_a6762160.itemtype === #"ammo" || self.var_a6762160.itemtype === #"armor" || self.var_a6762160.itemtype === #"weapon") {
        if (isdefined(self.amount) && newval !== self.amount) {
            item_inventory::function_31868137(localclientnum, self);
        }
        self.amount = newval;
        self.count = 1;
    } else {
        if (isdefined(self.count) && newval !== self.count) {
            item_inventory::function_31868137(localclientnum, self);
        }
        self.amount = 0;
        self.count = newval;
    }
    item_world::function_b78a9820(localclientnum);
}

// Namespace item_drop/item_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x52506c62, Offset: 0xd00
// Size: 0xb4
function function_a517a859(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    self.id = self getitemindex();
    if (!item_world::function_1b11e73c()) {
        return;
    }
    if (!function_1a45bc2a(self)) {
        return;
    }
    self function_67189b6b(fieldname, bwastimejump);
}

// Namespace item_drop/item_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x4aca5b8c, Offset: 0xdc0
// Size: 0x154
function function_e7bb925a(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (!item_world::function_1b11e73c()) {
        return;
    }
    if (bwastimejump == 1) {
        self.var_bad13452 = 0;
    } else if (bwastimejump == 2) {
        self.var_bad13452 = 2;
    }
    level.var_624588d5[level.var_624588d5.size] = self;
    player = function_5c10bd79(fieldname);
    if (isplayer(player) && distance2dsquared(self.origin, player.origin) <= function_a3f6cdac(1350)) {
        item_world::function_a4886b1e(fieldname, undefined, self);
    }
}

// Namespace item_drop/item_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x74baf62d, Offset: 0xf20
// Size: 0xbe
function function_63226f88(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self endon(#"death");
    if (!item_world::function_1b11e73c()) {
        return;
    }
    if (bwastimejump == 0) {
        self.stash_type = 0;
        return;
    }
    if (bwastimejump == 1) {
        self.stash_type = 1;
        return;
    }
    if (bwastimejump == 2) {
        self.stash_type = 2;
    }
}

