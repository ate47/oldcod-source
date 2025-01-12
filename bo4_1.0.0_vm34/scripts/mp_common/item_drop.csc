#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_inventory;
#using scripts\mp_common\item_world;
#using scripts\mp_common\item_world_util;

#namespace item_drop;

// Namespace item_drop/item_drop
// Params 0, eflags: 0x2
// Checksum 0xe6af31d0, Offset: 0xc8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"item_drop", &__init__, undefined, undefined);
}

// Namespace item_drop/item_drop
// Params 0, eflags: 0x0
// Checksum 0xa5150e76, Offset: 0x110
// Size: 0x11e
function __init__() {
    if (getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    clientfield::register("missile", "dynamic_item_drop", 1, 2, "int", &function_592c4d45, 0, 0);
    clientfield::register("scriptmover", "dynamic_item_drop", 1, 2, "int", &function_592c4d45, 0, 0);
    clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int", &function_ed4cdac9, 0, 0);
    level.item_spawn_drops = [];
    level.var_1b022657 = [];
}

// Namespace item_drop/item_drop
// Params 7, eflags: 0x0
// Checksum 0x28286470, Offset: 0x238
// Size: 0x234
function function_592c4d45(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"death");
    if (!item_world::function_61cbd38b()) {
        return;
    }
    if (newval == 0) {
        if (isdefined(self) && isdefined(self.networkid) && isdefined(level.item_spawn_drops[self.networkid])) {
            arrayremoveindex(level.item_spawn_drops, self.networkid, 1);
        }
        return;
    }
    if (newval == 1) {
        self.id = self getitemindex();
        self.networkid = item_world_util::function_4dec3654(self);
        self.hidetime = 0;
        if (self ishidden()) {
            self.hidetime = -1;
        }
        if (self.id != 32767) {
            self.itementry = function_9c3c6ff2(self.id).itementry;
        }
        arrayremovevalue(level.item_spawn_drops, undefined, 1);
        level.item_spawn_drops[self.networkid] = self;
        item_world::function_2cfb602b(localclientnum);
        item_world::function_c6594b00(localclientnum, self);
        item_inventory::function_516e33f1(localclientnum, self);
        return;
    }
    if (newval == 2) {
        self.hidetime = gettime();
        item_inventory::function_f5a659d4(localclientnum, self);
    }
}

// Namespace item_drop/item_drop
// Params 7, eflags: 0x0
// Checksum 0x15df1afa, Offset: 0x478
// Size: 0xac
function function_ed4cdac9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self.var_5adbea02 = 0;
    } else if (newval == 2) {
        self.var_5adbea02 = 2;
    }
    level.var_1b022657[level.var_1b022657.size] = self;
    item_world::function_c6594b00(localclientnum, self);
}

