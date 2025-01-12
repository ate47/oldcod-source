#using scripts\weapons\molotov;
#using scripts\weapons\proximity_grenade;
#using scripts\weapons\weaponobjects;

#namespace trapd;

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xe379b632, Offset: 0xa0
// Size: 0x19a
function function_3062c270(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 0;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = undefined;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectiondot = cos(70);
    watcher.detectionmindist = 20;
    watcher.detectiongraceperiod = 0.6;
    watcher.stuntime = 3;
    watcher.notequipment = 1;
    watcher.activationdelay = 0.5;
    watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
    watcher.stun = &weaponobjects::weaponstun;
    return watcher;
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0xb5c0bf4, Offset: 0x248
// Size: 0x17a
function function_63db9c73(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 0;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectionmindist = 64;
    watcher.detectiongraceperiod = 0.6;
    watcher.stuntime = 3;
    watcher.notequipment = 1;
    watcher.activationdelay = 0.5;
    watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
    watcher.stun = &weaponobjects::weaponstun;
    return watcher;
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0x6f596c66, Offset: 0x3d0
// Size: 0x17a
function function_87cb44fe(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 0;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectionmindist = 64;
    watcher.detectiongraceperiod = 0.6;
    watcher.stuntime = 3;
    watcher.notequipment = 1;
    watcher.activationdelay = 0.5;
    watcher.ondetonatecallback = &proximity_grenade::proximitydetonate;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
    watcher.stun = &weaponobjects::weaponstun;
    return watcher;
}

// Namespace trapd/trapd
// Params 1, eflags: 0x0
// Checksum 0x6e30095f, Offset: 0x558
// Size: 0x17a
function function_99f6d728(watcher) {
    watcher.watchforfire = 1;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 0;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.immunespecialty = "specialty_immunetriggerbetty";
    watcher.detectionmindist = 64;
    watcher.detectiongraceperiod = 0.6;
    watcher.stuntime = 3;
    watcher.notequipment = 1;
    watcher.activationdelay = 0.5;
    watcher.ondetonatecallback = &function_a305d0e5;
    watcher.onfizzleout = &weaponobjects::weaponobjectfizzleout;
    watcher.onspawn = &proximity_grenade::onspawnproximitygrenadeweaponobject;
    watcher.stun = &weaponobjects::weaponstun;
    return watcher;
}

// Namespace trapd/trapd
// Params 3, eflags: 0x0
// Checksum 0xc1836c51, Offset: 0x6e0
// Size: 0xcc
function function_a305d0e5(attacker, weapon, target) {
    self.killcament.starttime = gettime();
    self molotov::function_6c835f28(self.owner, self.origin, (0, 0, 1), (0, 0, -400), self.killcament, weapon, self.team, getscriptbundle(self.weapon.customsettings));
    self hide();
    wait 10;
    self delete();
}

