#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\system_shared;

#namespace wz_player;

// Namespace wz_player/player
// Params 0, eflags: 0x6
// Checksum 0x9d42f33d, Offset: 0x78
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"wz_player", &preinit, undefined, undefined, undefined);
}

// Namespace wz_player/player
// Params 0, eflags: 0x4
// Checksum 0x7f761230, Offset: 0xc0
// Size: 0x24
function private preinit() {
    callback::on_spawned(&on_player_spawned);
}

// Namespace wz_player/player
// Params 0, eflags: 0x0
// Checksum 0xbf068341, Offset: 0xf0
// Size: 0x24
function on_player_spawned() {
    self callback::on_grenade_fired(&on_grenade_fired);
}

// Namespace wz_player/player
// Params 1, eflags: 0x0
// Checksum 0xbbf08644, Offset: 0x120
// Size: 0xa2
function on_grenade_fired(params) {
    grenade = params.projectile;
    weapon = params.weapon;
    switch (weapon.name) {
    case #"flare_gun":
        grenade function_4861487f(weapon, self);
        grenade thread function_cd8ee3c5();
        break;
    default:
        break;
    }
}

// Namespace wz_player/player
// Params 2, eflags: 0x0
// Checksum 0x2239c5e, Offset: 0x1d0
// Size: 0x56
function function_4861487f(weapon, player) {
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
// Checksum 0x39c8378a, Offset: 0x230
// Size: 0x124
function function_cd8ee3c5() {
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
// Checksum 0x694a4cd2, Offset: 0x360
// Size: 0x18
function grenade_safe_to_throw(*player, *weapon) {
    return true;
}

// Namespace wz_player/player
// Params 0, eflags: 0x0
// Checksum 0xd6e28601, Offset: 0x380
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
    // Checksum 0x69858db4, Offset: 0x3f0
    // Size: 0x7c
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
