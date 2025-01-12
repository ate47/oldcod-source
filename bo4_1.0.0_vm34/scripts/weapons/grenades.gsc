#using scripts\core_common\clientfield_shared;
#using scripts\weapons\weaponobjects;

#namespace grenades;

// Namespace grenades/grenades
// Params 0, eflags: 0x0
// Checksum 0xf3d9e3da, Offset: 0x88
// Size: 0xac
function init_shared() {
    weaponobjects::function_f298eae6(#"eq_sticky_grenade", &creategrenadewatcher, 1);
    weaponobjects::function_f298eae6(#"concussion_grenade", &creategrenadewatcher, 1);
    weaponobjects::function_f298eae6(#"hash_5825488ac68418af", &creategrenadewatcher, 1);
}

// Namespace grenades/grenades
// Params 1, eflags: 0x0
// Checksum 0xdd94a1fe, Offset: 0x140
// Size: 0x26
function creategrenadewatcher(watcher) {
    watcher.onspawn = &function_26b1a6cb;
}

// Namespace grenades/grenades
// Params 2, eflags: 0x0
// Checksum 0x6792631d, Offset: 0x170
// Size: 0x4c
function function_26b1a6cb(watcher, player) {
    self clientfield::set("enemyequip", 1);
    self thread function_c5013dfa();
}

// Namespace grenades/grenades
// Params 0, eflags: 0x0
// Checksum 0x708639d6, Offset: 0x1c8
// Size: 0x6c
function function_c5013dfa() {
    level endon(#"game_ended");
    self waittill(#"explode", #"death");
    if (!isdefined(self)) {
        return;
    }
    self clientfield::set("enemyequip", 0);
}

