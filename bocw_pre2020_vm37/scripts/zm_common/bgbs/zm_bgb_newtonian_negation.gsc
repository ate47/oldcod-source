#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_newtonian_negation;

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x6
// Checksum 0x4122d4cb, Offset: 0xb0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"zm_bgb_newtonian_negation", &function_70a657d8, undefined, undefined, #"bgb");
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x5 linked
// Checksum 0xc5942e06, Offset: 0x100
// Size: 0xcc
function private function_70a657d8() {
    if (!is_true(level.bgb_in_use) && !is_true(level.var_5470be1c)) {
        return;
    }
    clientfield::register("world", "newtonian_negation", 1, 1, "int");
    bgb::register(#"zm_bgb_newtonian_negation", "time", 1500, &enable, &disable, &validation);
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0x235ee16d, Offset: 0x1d8
// Size: 0x26
function validation() {
    if (is_true(level.var_6bbb45f9)) {
        return false;
    }
    return true;
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0xaac813e8, Offset: 0x208
// Size: 0x34
function enable() {
    function_8622e664(1);
    self thread function_4712db36();
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0xb92e6cf6, Offset: 0x248
// Size: 0x3c
function function_4712db36() {
    self endon(#"hash_429f79a1bdb91087");
    self waittill(#"disconnect");
    thread disable();
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0x7cc832d6, Offset: 0x290
// Size: 0xd4
function disable() {
    if (isdefined(self)) {
        self notify(#"hash_429f79a1bdb91087");
    }
    foreach (player in level.players) {
        if (player !== self && player bgb::is_enabled(#"zm_bgb_newtonian_negation")) {
            return;
        }
    }
    function_8622e664(0);
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 1, eflags: 0x1 linked
// Checksum 0xdbe99362, Offset: 0x370
// Size: 0x2c
function function_8622e664(var_b4666218) {
    level clientfield::set("newtonian_negation", var_b4666218);
}

