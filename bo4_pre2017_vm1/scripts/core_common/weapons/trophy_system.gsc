#using scripts/core_common/callbacks_shared;
#using scripts/core_common/challenges_shared;
#using scripts/core_common/clientfield_shared;
#using scripts/core_common/damagefeedback_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/system_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/weaponobjects;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x918d9143, Offset: 0x408
// Size: 0xa4
function init_shared() {
    level.trophylongflashfx = "weapon/fx_trophy_flash";
    level.trophydetonationfx = "weapon/fx_trophy_detonation";
    level.fx_trophy_radius_indicator = "weapon/fx_trophy_radius_indicator";
    trophydeployanim = mp_trophy_system%o_trophy_deploy;
    trophyspinanim = mp_trophy_system%o_trophy_spin;
    level thread register();
    callback::on_spawned(&createtrophysystemwatcher);
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x2f578f96, Offset: 0x4b8
// Size: 0x64
function register() {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int");
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int");
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xda89e1eb, Offset: 0x528
// Size: 0x17c
function createtrophysystemwatcher() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("trophy_system", self.team);
    watcher.ondetonatecallback = &trophysystemdetonate;
    watcher.activatesound = "wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.activationdelay = 0.1;
    watcher.headicon = 0;
    watcher.enemydestroy = 1;
    watcher.onspawn = &ontrophysystemspawn;
    watcher.ondamage = &watchtrophysystemdamage;
    watcher.ondestroyed = &ontrophysystemsmashed;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xadfd66e8, Offset: 0x6b0
// Size: 0x28c
function ontrophysystemspawn(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    self useanimtree(#mp_trophy_system);
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self.trophysystemstationary = 0;
    movestate = self util::waittillrollingornotmoving();
    if (movestate == "rolling") {
        self setanim(mp_trophy_system%o_trophy_deploy, 1);
        self clientfield::set("trophy_system_state", 1);
        self util::waittillnotmoving();
    }
    self.trophysystemstationary = 1;
    player addweaponstat(self.weapon, "used", 1);
    self.ammo = player ammo_get(self.weapon);
    self thread trophyactive(player);
    self thread trophywatchhack();
    self setanim(mp_trophy_system%o_trophy_deploy, 0);
    self setanim(mp_trophy_system%o_trophy_spin, 1);
    self clientfield::set("trophy_system_state", 2);
    self playsound("wpn_trophy_deploy_start");
    self playloopsound("wpn_trophy_spin", 0.25);
    self setreconmodeldeployed();
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xab113ebb, Offset: 0x948
// Size: 0x3c
function setreconmodeldeployed() {
    if (isdefined(self.reconmodelentity)) {
        self.reconmodelentity clientfield::set("trophy_system_state", 2);
    }
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x1a548fa, Offset: 0x990
// Size: 0x3c
function trophywatchhack() {
    self endon(#"death");
    self waittill("hacked");
    self clientfield::set("trophy_system_state", 0);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xa5ba02ee, Offset: 0x9d8
// Size: 0x104
function ontrophysystemsmashed(attacker) {
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound("dst_trophy_smash");
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment();
        scoreevents::processscoreevent("destroyed_trophy_system", attacker, self.owner);
    }
    self delete();
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x3c4ed8d4, Offset: 0xae8
// Size: 0x392
function trophyactive(owner) {
    owner endon(#"disconnect");
    self endon(#"death");
    self endon(#"hacked");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (level.missileentities.size < 1 || isdefined(self.disabled)) {
            waitframe(1);
            continue;
        }
        waitframe(1);
        missileents = owner getentitiesinrange(level.missileentities, 512, self.origin);
        for (index = 0; index < missileents.size; index++) {
            if (!isdefined(self)) {
                return;
            }
            grenade = missileents[index];
            if (!isdefined(grenade)) {
                continue;
            }
            if (grenade == self) {
                continue;
            }
            if (!grenade.weapon.destroyablebytrophysystem) {
                continue;
            }
            switch (grenade.model) {
            case #"t6_wpn_grenade_supply_projectile":
                continue;
            }
            if (grenade.weapon == self.weapon) {
                if (self.trophysystemstationary == 0 && grenade.trophysystemstationary == 1) {
                    continue;
                }
            }
            if (!isdefined(grenade.owner)) {
                grenade.owner = getmissileowner(grenade);
            }
            if (isdefined(grenade.owner)) {
                if (level.teambased) {
                    if (grenade.owner.team == owner.team) {
                        continue;
                    }
                } else if (grenade.owner == owner) {
                    continue;
                }
                if (bullettracepassed(grenade.origin, self.origin + (0, 0, 29), 0, self, grenade, 0, 1)) {
                    playfx(level.trophylongflashfx, self.origin + (0, 0, 15), grenade.origin - self.origin, anglestoup(self.angles));
                    owner thread projectileexplode(grenade, self);
                    index--;
                    self playsound("wpn_trophy_alert");
                    if (getdvarint("player_sustainAmmo") == 0) {
                        self.ammo--;
                        if (self.ammo <= 0) {
                            self thread trophysystemdetonate();
                        }
                    }
                }
            }
        }
    }
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x7d88cc74, Offset: 0xe88
// Size: 0x154
function projectileexplode(projectile, trophy) {
    self endon(#"death");
    projposition = projectile.origin;
    playfx(level.trophydetonationfx, projposition);
    projectile notify(#"trophy_destroyed");
    trophy radiusdamage(projposition, 128, 105, 10, self);
    scoreevents::processscoreevent("trophy_defense", self);
    self challenges::trophy_defense(projposition, 512);
    if (self util::is_item_purchased("trophy_system")) {
        self addplayerstat("destroy_explosive_with_trophy", 1);
    }
    self addweaponstat(trophy.weapon, "CombatRecordStat", 1);
    projectile delete();
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x1ac1b2c0, Offset: 0xfe8
// Size: 0x134
function trophydestroytacinsert(tacinsert, trophy) {
    self endon(#"death");
    tacpos = tacinsert.origin;
    playfx(level.trophydetonationfx, tacinsert.origin);
    tacinsert thread tacticalinsertion::tacticalinsertiondestroyedbytrophysystem(self, trophy);
    trophy radiusdamage(tacpos, 128, 105, 10, self);
    scoreevents::processscoreevent("trophy_defense", self);
    if (self util::is_item_purchased("trophy_system")) {
        self addplayerstat("destroy_explosive_with_trophy", 1);
    }
    self addweaponstat(trophy.weapon, "CombatRecordStat", 1);
}

// Namespace trophy_system/trophy_system
// Params 3, eflags: 0x0
// Checksum 0x69976977, Offset: 0x1128
// Size: 0x10c
function trophysystemdetonate(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx_lg, self.origin);
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment(weapon);
        scoreevents::processscoreevent("destroyed_trophy_system", attacker, self.owner, weapon);
    }
    playsoundatposition("exp_trophy_system", self.origin);
    self delete();
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xb13c4fb1, Offset: 0x1240
// Size: 0x3a2
function watchtrophysystemdamage(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self setcandamage(1);
    damagemax = 20;
    if (!self util::ishacked()) {
        self.damagetaken = 0;
    }
    self.maxhealth = 10000;
    self.health = self.maxhealth;
    self setmaxhealth(self.maxhealth);
    attacker = undefined;
    while (true) {
        waitresult = self waittill("damage");
        damage = waitresult.amount;
        type = waitresult.mod;
        weapon = waitresult.weapon;
        attacker = self [[ level.figure_out_attacker ]](waitresult.attacker);
        if (!isplayer(attacker)) {
            continue;
        }
        if (level.teambased) {
            if (!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (weapon.dodamagefeedback) {
            if (level.teambased && self.owner.team != attacker.team) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            } else if (!level.teambased && self.owner != attacker) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            }
        }
        if (type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
            self.damagetaken = damagemax;
        } else {
            self.damagetaken += damage;
        }
        if (self.damagetaken >= damagemax) {
            watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
            return;
        }
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xc62435ab, Offset: 0x15f0
// Size: 0x24
function ammo_scavenger(weapon) {
    self ammo_reset();
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xe067da46, Offset: 0x1620
// Size: 0x16
function ammo_reset() {
    self._trophy_system_ammo1 = undefined;
    self._trophy_system_ammo2 = undefined;
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x6bacb501, Offset: 0x1640
// Size: 0x9a
function ammo_get(weapon) {
    totalammo = weapon.ammocountequipment;
    if (isdefined(self._trophy_system_ammo1) && !self util::ishacked()) {
        totalammo = self._trophy_system_ammo1;
        self._trophy_system_ammo1 = undefined;
        if (isdefined(self._trophy_system_ammo2)) {
            self._trophy_system_ammo1 = self._trophy_system_ammo2;
            self._trophy_system_ammo2 = undefined;
        }
    }
    return totalammo;
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xfa7868d, Offset: 0x16e8
// Size: 0x5c
function ammo_weapon_pickup(ammo) {
    if (isdefined(ammo)) {
        if (isdefined(self._trophy_system_ammo1)) {
            self._trophy_system_ammo2 = self._trophy_system_ammo1;
            self._trophy_system_ammo1 = ammo;
            return;
        }
        self._trophy_system_ammo1 = ammo;
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x7c85106, Offset: 0x1750
// Size: 0x24
function ammo_weapon_hacked(ammo) {
    self ammo_weapon_pickup(ammo);
}

