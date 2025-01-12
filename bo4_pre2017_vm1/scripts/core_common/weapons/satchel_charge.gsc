#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/weaponobjects;

#namespace satchel_charge;

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x0
// Checksum 0x1a6fbbde, Offset: 0x2c8
// Size: 0x64
function init_shared() {
    level._effect["satchel_charge_enemy_light"] = "weapon/fx_c4_light_orng";
    level._effect["satchel_charge_friendly_light"] = "weapon/fx_c4_light_blue";
    callback::function_367a33a8(&function_d7ed4157);
}

// Namespace satchel_charge/satchel_charge
// Params 0, eflags: 0x0
// Checksum 0xcf1e7faa, Offset: 0x338
// Size: 0x1cc
function function_d7ed4157() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("satchel_charge", self.team);
    watcher.altdetonate = 1;
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.ondetonatecallback = &function_3543ddb5;
    watcher.onspawn = &function_a3a42df2;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.altweapon = getweapon("satchel_charge_detonator");
    watcher.ownergetsassist = 1;
    watcher.detonatestationary = 1;
    watcher.detonationdelay = getdvarfloat("scr_satchel_detonation_delay", 0);
    watcher.detonationsound = "wpn_claymore_alert";
    watcher.var_1ef0506d = "uin_c4_enemy_detection_alert";
    watcher.immunespecialty = "specialty_immunetriggerc4";
}

// Namespace satchel_charge/satchel_charge
// Params 3, eflags: 0x0
// Checksum 0x5119df7c, Offset: 0x510
// Size: 0xbc
function function_3543ddb5(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                attacker challenges::destroyedexplosive(weapon);
                scoreevents::processscoreevent("destroyed_c4", attacker, self.owner, weapon);
            }
        }
    }
    weaponobjects::weapondetonate(attacker, weapon);
}

// Namespace satchel_charge/satchel_charge
// Params 2, eflags: 0x0
// Checksum 0x2d69e28a, Offset: 0x5d8
// Size: 0x114
function function_a3a42df2(watcher, owner) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    if (!(isdefined(self.previouslyhacked) && self.previouslyhacked)) {
        if (isdefined(owner)) {
            owner addweaponstat(self.weapon, "used", 1);
        }
        self playloopsound("uin_c4_air_alarm_loop");
        self waittilltimeout(10, "stationary");
        delaytimesec = self.weapon.proximityalarmactivationdelay / 1000;
        if (delaytimesec > 0) {
            wait delaytimesec;
        }
        self stoploopsound(0.1);
    }
}

