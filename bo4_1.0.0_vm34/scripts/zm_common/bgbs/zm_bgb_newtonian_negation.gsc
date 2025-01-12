#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;

#namespace zm_bgb_newtonian_negation;

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x2
// Checksum 0x76d683b1, Offset: 0xb0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"zm_bgb_newtonian_negation", &__init__, undefined, #"bgb");
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x0
// Checksum 0xc747a207, Offset: 0x100
// Size: 0x9c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    clientfield::register("world", "newtonian_negation", 1, 1, "int");
    bgb::register(#"zm_bgb_newtonian_negation", "time", 1500, &enable, &disable, undefined);
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x0
// Checksum 0xec64c42f, Offset: 0x1a8
// Size: 0x34
function enable() {
    function_2b4ff13a(1);
    self thread function_7d6ddd3a();
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x0
// Checksum 0x6ade428c, Offset: 0x1e8
// Size: 0x3c
function function_7d6ddd3a() {
    self endon(#"hash_429f79a1bdb91087");
    self waittill(#"disconnect");
    thread disable();
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 0, eflags: 0x0
// Checksum 0xb0141cc1, Offset: 0x230
// Size: 0xdc
function disable() {
    if (isdefined(self)) {
        self notify(#"hash_429f79a1bdb91087");
    }
    foreach (player in level.players) {
        if (player !== self && player bgb::is_enabled(#"zm_bgb_newtonian_negation")) {
            return;
        }
    }
    function_2b4ff13a(0);
    zombie_utility::clear_all_corpses();
}

// Namespace zm_bgb_newtonian_negation/zm_bgb_newtonian_negation
// Params 1, eflags: 0x0
// Checksum 0xec722350, Offset: 0x318
// Size: 0x2c
function function_2b4ff13a(var_365c612) {
    level clientfield::set("newtonian_negation", var_365c612);
}

