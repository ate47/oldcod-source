#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\dynamic_loadout;
#using scripts\mp_common\laststand;

#namespace bounty;

// Namespace bounty/gametype_init
// Params 1, eflags: 0x40
// Checksum 0x6b65af08, Offset: 0xc8
// Size: 0x64
function event_handler[gametype_init] main(eventstruct) {
    level.var_ab22f020 = 1;
    clientfield::register("allplayers", "bountymoneytrail", 1, 1, "int", &function_b26c7a8, 0, 1);
}

// Namespace bounty/bounty
// Params 7, eflags: 0x4
// Checksum 0x2b1e7896, Offset: 0x138
// Size: 0x74
function private function_b26c7a8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self function_48494bde(localclientnum);
        return;
    }
    self function_3de27bd4();
}

// Namespace bounty/bounty
// Params 1, eflags: 0x0
// Checksum 0x219b3eb4, Offset: 0x1b8
// Size: 0x54
function function_48494bde(localclientnum) {
    if (!self function_60dbc438() || isthirdperson(localclientnum)) {
        self thread function_a440171b(localclientnum);
    }
}

// Namespace bounty/bounty
// Params 0, eflags: 0x0
// Checksum 0x3c7876c, Offset: 0x218
// Size: 0x16
function function_3de27bd4() {
    self notify(#"hash_eca936d9bc271de");
}

// Namespace bounty/bounty
// Params 1, eflags: 0x4
// Checksum 0x53a0d984, Offset: 0x238
// Size: 0x94
function private function_a440171b(localclientnum) {
    if (!isdefined(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"hash_eca936d9bc271de");
    self util::waittill_dobj(localclientnum);
    activefx = playtagfxset(localclientnum, "gametype_heist_money_trail", self);
    self thread function_ec025078(localclientnum, activefx);
}

// Namespace bounty/bounty
// Params 2, eflags: 0x4
// Checksum 0xdb1ce509, Offset: 0x2d8
// Size: 0xb8
function private function_ec025078(localclientnum, fxarray) {
    self waittill(#"hash_eca936d9bc271de", #"death");
    if (isdefined(fxarray)) {
        foreach (fx in fxarray) {
            stopfx(localclientnum, fx);
        }
    }
}

