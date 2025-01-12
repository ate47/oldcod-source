#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\mp_common\item_supply_drop;

#namespace wz_player;

// Namespace wz_player/player
// Params 0, eflags: 0x2
// Checksum 0x6f36124e, Offset: 0x80
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"wz_player", &__init__, undefined, undefined);
}

// Namespace wz_player/player
// Params 0, eflags: 0x0
// Checksum 0xb8376b97, Offset: 0xc8
// Size: 0x24
function __init__() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace wz_player/player
// Params 0, eflags: 0x0
// Checksum 0xed7ff664, Offset: 0xf8
// Size: 0x24
function on_player_spawned() {
    self callback::on_grenade_fired(&on_grenade_fired);
}

// Namespace wz_player/player
// Params 1, eflags: 0x0
// Checksum 0x5f166c2, Offset: 0x128
// Size: 0xb2
function on_grenade_fired(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    switch (weapon.name) {
    case #"flare_gun":
        grenade function_253ac3f1(weapon, self);
        grenade thread function_471d6805();
        break;
    default:
        break;
    }
}

// Namespace wz_player/player
// Params 2, eflags: 0x0
// Checksum 0xd1d8397d, Offset: 0x1e8
// Size: 0x56
function function_253ac3f1(weapon, player) {
    if (!isdefined(self)) {
        return;
    }
    if (!self grenade_safe_to_throw(player, weapon)) {
        self thread makegrenadedudanddestroy();
        return;
    }
}

// Namespace wz_player/player
// Params 0, eflags: 0x0
// Checksum 0x9abb0aa9, Offset: 0x248
// Size: 0x11c
function function_471d6805() {
    self endon(#"grenade_dud");
    waitresult = self waittill(#"explode", #"death");
    if (waitresult._notify == #"explode") {
        trace = groundtrace(waitresult.position, waitresult.position + (0, 0, -20000), 0, self, 0);
        if (isdefined(trace[#"position"]) && trace[#"surfacetype"] != #"none") {
            org = trace[#"position"];
            item_supply_drop::drop_supply_drop(org, 1);
        }
    }
}

// Namespace wz_player/player
// Params 2, eflags: 0x0
// Checksum 0x13702fa8, Offset: 0x370
// Size: 0x18
function grenade_safe_to_throw(player, weapon) {
    return true;
}

// Namespace wz_player/player
// Params 0, eflags: 0x0
// Checksum 0x10c7df70, Offset: 0x390
// Size: 0x64
function makegrenadedudanddestroy() {
    self endon(#"death");
    self notify(#"grenade_dud");
    self makegrenadedud();
    wait 3;
    if (isdefined(self)) {
        self delete();
    }
}

/#

    // Namespace wz_player/player
    // Params 3, eflags: 0x0
    // Checksum 0xe2aa9c17, Offset: 0x400
    // Size: 0x84
    function debug_star(origin, seconds, color) {
        if (!isdefined(seconds)) {
            seconds = 1;
        }
        if (!isdefined(color)) {
            color = (1, 0, 0);
        }
        frames = int(20 * seconds);
        debugstar(origin, frames, color);
    }

#/
