#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\damage;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\tacticalinsertion;
#using scripts\weapons\weaponobjects;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xf1fa48a4, Offset: 0x190
// Size: 0xe4
function init_shared() {
    level.trophylongflashfx = #"weapon/fx_trophy_flash";
    level.trophydetonationfx = #"weapon/fx_trophy_detonation";
    level.fx_trophy_radius_indicator = #"weapon/fx_trophy_radius_indicator";
    trophydeployanim = "p8_fxanim_mp_eqp_trophy_system_world_anim";
    trophyspinanim = "p8_fxanim_mp_eqp_trophy_system_world_open_anim";
    level thread register();
    callback::on_player_killed_with_params(&on_player_killed);
    weaponobjects::function_f298eae6(#"trophy_system", &createtrophysystemwatcher, 1);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x810ab66a, Offset: 0x280
// Size: 0x1a
function function_9a915f37(func) {
    level.var_9ec5a315 = func;
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xd4556eed, Offset: 0x2a8
// Size: 0x64
function register() {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int");
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int");
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xa4fdd86d, Offset: 0x318
// Size: 0x9c
function on_player_killed(s_params) {
    attacker = s_params.eattacker;
    weapon = s_params.weapon;
    if (!isdefined(attacker) || !isdefined(weapon)) {
        return;
    }
    if (weapon.name == #"trophy_system") {
        scoreevents::processscoreevent(#"trophy_system_kill", attacker, self, weapon);
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x4ee0ae7, Offset: 0x3c0
// Size: 0x166
function createtrophysystemwatcher(watcher) {
    watcher.ondetonatecallback = &trophysystemdetonate;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.activationdelay = 0.1;
    watcher.deleteonplayerspawn = 0;
    watcher.enemydestroy = 1;
    watcher.onspawn = &ontrophysystemspawn;
    watcher.ondamage = &watchtrophysystemdamage;
    watcher.ondestroyed = &ontrophysystemsmashed;
    watcher.var_46869d39 = &function_42a42978;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ontimeout = &ontrophysystemsmashed;
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xe89e29b2, Offset: 0x530
// Size: 0x5e
function trophysystemstopped() {
    self endon(#"death");
    self endon(#"trophysystemstopped");
    self util::waittillnotmoving();
    self.trophysystemstationary = 1;
    self notify(#"trophysystemstopped");
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xa1dfe542, Offset: 0x598
// Size: 0x31c
function ontrophysystemspawn(watcher, player) {
    player endon(#"death");
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    self useanimtree("generic");
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self.trophysystemstationary = 0;
    self.weapon = getweapon(#"trophy_system");
    self setweapon(self.weapon);
    self thread trophysystemstopped();
    movestate = self util::waittillrollingornotmoving();
    if (movestate == "rolling") {
        self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
        self clientfield::set("trophy_system_state", 1);
    }
    if (!self.trophysystemstationary) {
        trophysystemstopped();
    }
    self.trophysystemstationary = 1;
    player stats::function_4f10b697(self.weapon, #"used", 1);
    self.ammo = player ammo_get(self.weapon);
    self thread trophyactive(player);
    self thread trophywatchhack();
    self util::make_sentient();
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
    self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
    self clientfield::set("trophy_system_state", 2);
    self playsound(#"wpn_trophy_deploy_start");
    self playloopsound(#"wpn_trophy_spin", 0.25);
    self setreconmodeldeployed();
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x31650163, Offset: 0x8c0
// Size: 0x34
function setreconmodeldeployed() {
    if (isdefined(self.reconmodelentity)) {
        self.reconmodelentity clientfield::set("trophy_system_state", 2);
    }
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xdaa74c5d, Offset: 0x900
// Size: 0x4c
function trophywatchhack() {
    self endon(#"death");
    self waittill(#"hacked");
    self clientfield::set("trophy_system_state", 0);
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xde6697e0, Offset: 0x958
// Size: 0x24
function function_42a42978(player) {
    self thread trophysystemdetonate();
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x4a7d3624, Offset: 0x988
// Size: 0x134
function ontrophysystemsmashed(attacker, callback_data) {
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound(#"dst_trophy_smash");
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment();
        scoreevents::processscoreevent(#"destroyed_trophy_system", attacker, self.owner, undefined);
    }
    if (isdefined(level.var_b31e16d4)) {
        self [[ level.var_b31e16d4 ]](attacker, self.owner, self.weapon);
    }
    self delete();
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xed73e265, Offset: 0xac8
// Size: 0x3d2
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
            if (grenade.destroyablebytrophysystem === 0) {
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
                    grenade notify(#"death");
                    if (isdefined(level.var_9ec5a315)) {
                        owner [[ level.var_9ec5a315 ]](self, grenade);
                    }
                    playfx(level.trophylongflashfx, self.origin + (0, 0, 15), grenade.origin - self.origin, anglestoup(self.angles));
                    owner thread projectileexplode(grenade, self);
                    index--;
                    self playsound(#"wpn_trophy_alert");
                    if (getdvarint(#"player_sustainammo", 0) == 0) {
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
// Checksum 0x8fc9c639, Offset: 0xea8
// Size: 0x194
function projectileexplode(projectile, trophy) {
    self endon(#"death");
    projposition = projectile.origin;
    playfx(level.trophydetonationfx, projposition);
    projectile notify(#"trophy_destroyed");
    trophy radiusdamage(projposition, 128, 105, 10, self);
    scoreevents::processscoreevent(#"trophy_defense", self, projectile.owner, trophy.weapon);
    self function_36242d1a(projectile, trophy);
    self challenges::trophy_defense(projposition, 512);
    if (self util::is_item_purchased(#"trophy_system")) {
        self stats::function_b48aa4e(#"destroy_explosive_with_trophy", 1);
    }
    self function_b5489c4b(trophy.weapon, 1);
    projectile delete();
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xfa0a9105, Offset: 0x1048
// Size: 0x54
function function_3d2582f5(gameobject, trophy) {
    return distancesquared(gameobject.origin, trophy.origin) <= math::pow(512, 2);
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xeaf923f6, Offset: 0x10a8
// Size: 0x694
function function_36242d1a(projectile, trophy) {
    player = self;
    entities = getentitiesinradius(trophy.origin, 512);
    var_23d650cf = 0;
    for (i = 0; i < entities.size; i++) {
        if (!isdefined(self)) {
            return;
        }
        ent = entities[i];
        if (isdefined(ent.owner) && ent.team == player.team && (ent.classname === "noclass" || ent.classname === "script_model" || ent.classname === "script_vehicle" || ent.archetype === #"mp_dog" || ent.archetype === #"human" || isdefined(ent.aitype)) && (ent.item !== level.weaponnone || ent.weapon !== level.weaponnone || ent.meleeweapon !== level.weaponnone || ent.turretweapon !== level.weaponnone) && isdefined(ent.takedamage) && ent.takedamage) {
            if ((isdefined(ent.health) ? ent.health : 0) > 0) {
                var_23d650cf = 1;
                break;
            }
        }
    }
    if (var_23d650cf) {
        scoreevents::processscoreevent(#"hash_1ed8a05490cfe606", player, projectile.owner, trophy.weapon);
    }
    if (isdefined(level.flags)) {
        var_8793486e = 0;
        foreach (flag in level.flags) {
            useobj = flag.useobj;
            if (!isdefined(useobj) || !function_3d2582f5(useobj, trophy)) {
                continue;
            }
            var_8793486e |= useobj.userate && (useobj.claimteam === player.team || useobj.interactteam === #"enemy");
            if (var_8793486e) {
                break;
            }
        }
        if (var_8793486e) {
            scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
        }
    }
    if (isdefined(level.zones)) {
        var_8793486e = 0;
        foreach (zone in level.zones) {
            useobj = zone.gameobject;
            if (!isdefined(useobj) || !function_3d2582f5(useobj, trophy)) {
                continue;
            }
            var_8793486e |= useobj.userate && (useobj.claimteam === player.team || useobj.interactteam === #"enemy");
            if (var_8793486e) {
                break;
            }
        }
        if (var_8793486e) {
            scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
        }
    }
    if (isdefined(level.bombzones)) {
        var_8793486e = 0;
        foreach (useobj in level.bombzones) {
            if (!isdefined(useobj) || !function_3d2582f5(useobj, trophy)) {
                continue;
            }
            var_8793486e |= useobj.userate && (useobj.claimteam === player.team || useobj.interactteam === #"enemy");
            if (var_8793486e) {
                break;
            }
        }
        if (var_8793486e) {
            scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
        }
    }
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xae10ed79, Offset: 0x1748
// Size: 0x144
function trophydestroytacinsert(tacinsert, trophy) {
    self endon(#"death");
    tacpos = tacinsert.origin;
    playfx(level.trophydetonationfx, tacinsert.origin);
    tacinsert thread tacticalinsertion::tacticalinsertiondestroyedbytrophysystem(self, trophy);
    trophy radiusdamage(tacpos, 128, 105, 10, self);
    scoreevents::processscoreevent(#"trophy_defense", self, undefined, trophy.weapon);
    if (self util::is_item_purchased(#"trophy_system")) {
        self stats::function_b48aa4e(#"destroy_explosive_with_trophy", 1);
    }
    self function_b5489c4b(trophy.weapon, 1);
}

// Namespace trophy_system/trophy_system
// Params 3, eflags: 0x0
// Checksum 0x9aa4833, Offset: 0x1898
// Size: 0x144
function trophysystemdetonate(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx_lg, self.origin);
    }
    if (isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyedequipment(weapon);
        scoreevents::processscoreevent(#"destroyed_trophy_system", attacker, self.owner, weapon);
        if (isdefined(level.var_b31e16d4)) {
            self [[ level.var_b31e16d4 ]](attacker, self.owner, self.weapon, weapon);
        }
    }
    playsoundatposition(#"exp_trophy_system", self.origin);
    self delete();
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x85846985, Offset: 0x19e8
// Size: 0x342
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
        waitresult = self waittill(#"damage");
        damage = waitresult.amount;
        type = waitresult.mod;
        weapon = waitresult.weapon;
        attacker = self [[ level.figure_out_attacker ]](waitresult.attacker);
        damage = weapons::function_fa5602(damage, weapon, self.weapon);
        if (!isplayer(attacker)) {
            continue;
        }
        if (level.teambased) {
            if (!sessionmodeiswarzonegame() && !level.hardcoremode && self.owner.team == attacker.pers[#"team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (damage::friendlyfirecheck(self.owner, attacker)) {
            if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                attacker damagefeedback::update();
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
// Checksum 0xdc6e6f73, Offset: 0x1d38
// Size: 0x24
function ammo_scavenger(weapon) {
    self ammo_reset();
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x6aac1a73, Offset: 0x1d68
// Size: 0x16
function ammo_reset() {
    self._trophy_system_ammo1 = undefined;
    self._trophy_system_ammo2 = undefined;
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xdba837b, Offset: 0x1d88
// Size: 0x86
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
// Checksum 0xf147103c, Offset: 0x1e18
// Size: 0x4a
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
// Checksum 0x90585c5d, Offset: 0x1e70
// Size: 0x24
function ammo_weapon_hacked(ammo) {
    self ammo_weapon_pickup(ammo);
}

