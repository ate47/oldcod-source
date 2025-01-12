#using script_680dddbda86931fa;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;

#namespace item_supply_drop;

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x6
// Checksum 0x1acb53fd, Offset: 0x160
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"item_supply_drop", &function_70a657d8, undefined, undefined, #"item_world");
}

// Namespace item_supply_drop/item_supply_drop
// Params 0, eflags: 0x5 linked
// Checksum 0x47827ef7, Offset: 0x1b0
// Size: 0x134
function private function_70a657d8() {
    if (!item_world_util::use_item_spawns()) {
        return;
    }
    clientfield::register("scriptmover", "supply_drop_fx", 1, 1, "int", &supply_drop_fx, 0, 0);
    clientfield::register("scriptmover", "supply_drop_parachute_rob", 1, 1, "int", &supply_drop_parachute, 0, 0);
    clientfield::register("scriptmover", "supply_drop_portal_fx", 1, 1, "int", &supply_drop_portal_fx, 0, 0);
    clientfield::register("vehicle", "supply_drop_vehicle_landed", 1, 1, "counter", &supply_drop_vehicle_landed, 0, 0);
}

// Namespace item_supply_drop/item_supply_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x90a47e71, Offset: 0x2f0
// Size: 0x94
function supply_drop_parachute(*localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        self playrenderoverridebundle(#"hash_336cece53ae2342f");
        return;
    }
    self stoprenderoverridebundle(#"hash_336cece53ae2342f");
}

// Namespace item_supply_drop/item_supply_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x2c90c967, Offset: 0x390
// Size: 0x154
function supply_drop_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        fxent = spawn(fieldname, self.origin, "script_model");
        fxent setmodel("tag_origin");
        fxent linkto(self);
        fxent.supplydropfx = function_239993de(fieldname, "killstreaks/fx9_carepkg_signal_smk_blue", fxent, "tag_origin");
        self.fxent = fxent;
        self.var_3a55f5cf = 1;
        return;
    }
    if (isdefined(self.fxent)) {
        if (isdefined(self.fxent.supplydropfx)) {
            stopfx(fieldname, self.fxent.supplydropfx);
        }
        self.fxent delete();
    }
}

// Namespace item_supply_drop/item_supply_drop
// Params 7, eflags: 0x1 linked
// Checksum 0xdb76f73e, Offset: 0x4f0
// Size: 0x15a
function supply_drop_portal_fx(localclientnum, *oldval, newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    if (bwastimejump == 1) {
        player = function_5c10bd79(fieldname);
        if (isdefined(self.var_227361c6)) {
            stopfx(fieldname, self.var_227361c6);
        }
        self.startpos = self.origin;
        self.var_227361c6 = playfx(fieldname, #"hash_28b5c6ccaabb4afe", self.startpos);
        return;
    }
    if (isdefined(self.var_227361c6)) {
        stopfx(fieldname, self.var_227361c6);
    }
    var_752d14c2 = self.origin;
    if (isdefined(self.startpos)) {
        var_752d14c2 = self.startpos;
    }
    self.var_227361c6 = playfx(fieldname, #"hash_45086f1ffcabbf47", var_752d14c2);
}

// Namespace item_supply_drop/item_supply_drop
// Params 7, eflags: 0x1 linked
// Checksum 0x9bb9c70d, Offset: 0x658
// Size: 0x64
function supply_drop_vehicle_landed(localclientnum, *oldval, *newval, *bnewent, *binitialsnap, *fieldname, *bwastimejump) {
    self playrumbleonentity(bwastimejump, #"hash_6ee3e7be4dd47bed");
}

