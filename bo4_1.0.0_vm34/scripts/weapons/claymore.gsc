#using scripts\core_common\system_shared;
#using scripts\weapons\proximity_grenade;
#using scripts\weapons\weaponobjects;

#namespace claymore;

// Namespace claymore/claymore
// Params 0, eflags: 0x2
// Checksum 0x8df92db1, Offset: 0xa8
// Size: 0x3c
function autoexec __init__system__() {
    system::register(#"claymore", &init_shared, undefined, undefined);
}

// Namespace claymore/claymore
// Params 0, eflags: 0x0
// Checksum 0x589ac555, Offset: 0xf0
// Size: 0x2c
function init_shared() {
    weaponobjects::function_f298eae6("claymore", &createclaymorewatcher, 0);
}

// Namespace claymore/claymore
// Params 1, eflags: 0x0
// Checksum 0x55f14b50, Offset: 0x128
// Size: 0x18e
function createclaymorewatcher(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = undefined;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.deleteonplayerspawn = 0;
    watcher.detectiondot = cos(70);
    watcher.detectionmindist = 20;
    watcher.detectiongraceperiod = 0.6;
    watcher.stuntime = 1;
    watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &function_daea5bd3;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.var_46869d39 = &function_9f078ba7;
}

// Namespace claymore/claymore
// Params 1, eflags: 0x0
// Checksum 0xa9236199, Offset: 0x2c0
// Size: 0x24
function function_9f078ba7(player) {
    self weaponobjects::weaponobjectfizzleout();
}

// Namespace claymore/claymore
// Params 2, eflags: 0x0
// Checksum 0xd138cb7f, Offset: 0x2f0
// Size: 0x52
function function_daea5bd3(watcher, player) {
    proximity_grenade::onspawnproximitygrenadeweaponobject(watcher, player);
    self.weapon = getweapon(#"claymore");
}

