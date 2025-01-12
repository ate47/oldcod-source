#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\weapons\weaponobjects;

#namespace sprint_boost_grenade;

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0, eflags: 0x6
// Checksum 0x15ac7d60, Offset: 0x88
// Size: 0x3c
function private autoexec __init__system__() {
    system::register(#"sprint_boost_grenade", &function_70a657d8, undefined, undefined, undefined);
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0, eflags: 0x4
// Checksum 0x7acf10f2, Offset: 0xd0
// Size: 0x8c
function private function_70a657d8() {
    level._effect[#"satchel_charge_enemy_light"] = #"weapon/fx_c4_light_orng";
    level._effect[#"satchel_charge_friendly_light"] = #"weapon/fx_c4_light_blue";
    weaponobjects::function_e6400478(#"sprint_boost_grenade", &create_grenade_watcher, 1);
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 1, eflags: 0x0
// Checksum 0x6246c3c7, Offset: 0x168
// Size: 0x5a
function create_grenade_watcher(watcher) {
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.onspawn = &grenade_spawn;
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 2, eflags: 0x0
// Checksum 0xb180e44e, Offset: 0x1d0
// Size: 0x194
function grenade_spawn(watcher, owner) {
    self endon(#"grenade_timeout");
    self thread grenade_timeout(10);
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    radius = self.weapon.sprintboostradius;
    duration = self.weapon.sprintboostduration;
    if (!is_true(self.previouslyhacked)) {
        if (isdefined(owner)) {
            owner stats::function_e24eec31(self.weapon, #"used", 1);
            origin = owner.origin;
        }
        boost_on_throw = 1;
        detonated = 0;
        if (!boost_on_throw) {
            waitresult = self waittill(#"explode");
            detonated = 1;
        }
        level thread apply_sprint_boost_to_players(owner, waitresult.position, radius, duration);
        if (!detonated) {
            self detonate(owner);
        }
    }
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 1, eflags: 0x0
// Checksum 0xb2d24305, Offset: 0x370
// Size: 0x86
function grenade_timeout(timeout) {
    self endon(#"death");
    frames = int(timeout / float(function_60d95f53()) / 1000);
    waitframe(frames);
    self notify(#"grenade_timeout");
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 4, eflags: 0x0
// Checksum 0x2a0898b3, Offset: 0x400
// Size: 0x168
function apply_sprint_boost_to_players(owner, origin, radius, duration) {
    if (!isdefined(owner)) {
        return;
    }
    if (!isdefined(owner.team)) {
        return;
    }
    if (!isdefined(origin)) {
        return;
    }
    radiussq = function_a3f6cdac(isdefined(radius) ? radius : 150);
    foreach (player in level.players) {
        if (!isplayer(player)) {
            continue;
        }
        if (util::function_fbce7263(player.team, owner.team)) {
            continue;
        }
        if (distancesquared(player.origin, origin) > radiussq) {
            continue;
        }
        player thread apply_sprint_boost(duration);
    }
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 1, eflags: 0x0
// Checksum 0x3c535a0a, Offset: 0x570
// Size: 0x124
function apply_sprint_boost(duration) {
    player = self;
    player endon(#"death", #"disconnect");
    player notify(#"apply_sprint_boost_singleton");
    player endon(#"apply_sprint_boost_singleton");
    player setsprintboost(1);
    duration = math::clamp(isdefined(duration) ? duration : 10, 1, 1200);
    frames_to_wait = int(duration / float(function_60d95f53()) / 1000);
    waitframe(frames_to_wait);
    player setsprintboost(0);
}

