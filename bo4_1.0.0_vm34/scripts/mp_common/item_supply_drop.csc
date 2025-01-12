#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace item_supply_drop;

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x2
// Checksum 0xbb6716e8, Offset: 0xd0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"item_supply_drop", &__init__, undefined, #"item_world");
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x4
// Checksum 0x50c8a711, Offset: 0x120
// Size: 0x9c
function private __init__() {
    if (!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0) {
        return;
    }
    clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int", &supply_drop_fx, 0, 0);
}

// Namespace item_supply_drop/item_supply_drop
// Params 7, eflags: 0x0
// Checksum 0xa7cb7e03, Offset: 0x1c8
// Size: 0x14c
function supply_drop_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        fxent = spawn(localclientnum, self.origin, "script_model");
        fxent setmodel("tag_origin");
        fxent linkto(self);
        fxent.supplydropfx = function_fb03c761(localclientnum, "smoke/fx8_column_md_red", fxent, "tag_origin");
        self.fxent = fxent;
        return;
    }
    if (isdefined(self.fxent)) {
        if (isdefined(self.fxent.supplydropfx)) {
            stopfx(localclientnum, self.fxent.supplydropfx);
        }
        self.fxent delete();
    }
}

