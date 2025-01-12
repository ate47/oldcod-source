#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;

#namespace sprint_boost_grenade;

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0, eflags: 0x2
// Checksum 0xeff7ac43, Offset: 0x88
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"sprint_boost_grenade", &__init__, undefined, undefined);
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 0, eflags: 0x0
// Checksum 0x931fc3e3, Offset: 0xd0
// Size: 0x94
function __init__() {
    level._effect[#"satchel_charge_enemy_light"] = #"weapon/fx_c4_light_orng";
    level._effect[#"satchel_charge_friendly_light"] = #"weapon/fx_c4_light_blue";
    weaponobjects::function_f298eae6(#"sprint_boost_grenade", &create_grenade_watcher, 1);
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 1, eflags: 0x0
// Checksum 0xf464b0c3, Offset: 0x170
// Size: 0x6e
function create_grenade_watcher(watcher) {
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.onspawn = &grenade_spawn;
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 2, eflags: 0x0
// Checksum 0x463d4c14, Offset: 0x1e8
// Size: 0x18c
function grenade_spawn(watcher, owner) {
    self endon(#"grenade_timeout");
    self thread grenade_timeout(10);
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    radius = self.weapon.sprintboostradius;
    duration = self.weapon.sprintboostduration;
    if (!(isdefined(self.previouslyhacked) && self.previouslyhacked)) {
        if (isdefined(owner)) {
            owner stats::function_4f10b697(self.weapon, #"used", 1);
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
// Checksum 0x758cd5b4, Offset: 0x380
// Size: 0x86
function grenade_timeout(timeout) {
    self endon(#"death");
    frames = int(timeout / float(function_f9f48566()) / 1000);
    waitframe(frames);
    self notify(#"grenade_timeout");
}

// Namespace sprint_boost_grenade/sprint_boost_grenade
// Params 4, eflags: 0x0
// Checksum 0x2dd2d5d4, Offset: 0x410
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
    radiussq = (isdefined(radius) ? radius : 150) * (isdefined(radius) ? radius : 150);
    foreach (player in level.players) {
        if (!isplayer(player)) {
            continue;
        }
        if (player.team != owner.team) {
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
// Checksum 0x73699482, Offset: 0x580
// Size: 0x12c
function apply_sprint_boost(duration) {
    player = self;
    player endon(#"death");
    player endon(#"disconnect");
    player notify(#"apply_sprint_boost_singleton");
    player endon(#"apply_sprint_boost_singleton");
    player setsprintboost(1);
    duration = math::clamp(isdefined(duration) ? duration : 10, 1, 1200);
    frames_to_wait = int(duration / float(function_f9f48566()) / 1000);
    waitframe(frames_to_wait);
    player setsprintboost(0);
}

