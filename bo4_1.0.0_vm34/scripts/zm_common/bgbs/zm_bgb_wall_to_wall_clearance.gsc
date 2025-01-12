#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;

#namespace zm_bgb_wall_to_wall_clearance;

// Namespace zm_bgb_wall_to_wall_clearance/zm_bgb_wall_to_wall_clearance
// Params 0, eflags: 0x2
// Checksum 0x86ec28a6, Offset: 0x98
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"zm_bgb_wall_to_wall_clearance", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_wall_to_wall_clearance/zm_bgb_wall_to_wall_clearance
// Params 0, eflags: 0x0
// Checksum 0x29a26997, Offset: 0xe0
// Size: 0x74
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register(#"zm_bgb_wall_to_wall_clearance", "time", 30, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_wall_to_wall_clearance/zm_bgb_wall_to_wall_clearance
// Params 0, eflags: 0x0
// Checksum 0xb090fc0e, Offset: 0x160
// Size: 0x44
function enable() {
    zm_wallbuy::function_324bd2b6(&function_42906d9c);
    zm_wallbuy::function_c25b6154(&override_ammo_cost);
}

// Namespace zm_bgb_wall_to_wall_clearance/zm_bgb_wall_to_wall_clearance
// Params 0, eflags: 0x0
// Checksum 0x9b4b044e, Offset: 0x1b0
// Size: 0x44
function disable() {
    zm_wallbuy::function_7dbd127f(&function_42906d9c);
    zm_wallbuy::function_f62cb5a1(&override_ammo_cost);
}

// Namespace zm_bgb_wall_to_wall_clearance/zm_bgb_wall_to_wall_clearance
// Params 2, eflags: 0x0
// Checksum 0xbd65ef2e, Offset: 0x200
// Size: 0x18
function function_42906d9c(w_wallbuy, var_ae13b936) {
    return 10;
}

// Namespace zm_bgb_wall_to_wall_clearance/zm_bgb_wall_to_wall_clearance
// Params 2, eflags: 0x0
// Checksum 0x5e1f945f, Offset: 0x220
// Size: 0x3e
function override_ammo_cost(w_wallbuy, stub) {
    if (self zm_weapons::has_upgrade(w_wallbuy)) {
        return 500;
    }
    return 10;
}

