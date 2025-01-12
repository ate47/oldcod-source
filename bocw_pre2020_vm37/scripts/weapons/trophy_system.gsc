#using script_1435f3c9fc699e04;
#using script_1cc417743d7c262d;
#using scripts\core_common\battlechatter;
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
#using scripts\killstreaks\killstreaks_util;
#using scripts\weapons\weaponobjects;

#namespace trophy_system;

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xe956681f, Offset: 0x1e0
// Size: 0x124
function init_shared() {
    level.trophydetonationfx = #"hash_7e2c1749cc5fcfb9";
    level.fx_trophy_radius_indicator = #"weapon/fx_trophy_radius_indicator";
    trophydeployanim = "p8_fxanim_mp_eqp_trophy_system_world_anim";
    trophyspinanim = "p8_fxanim_mp_eqp_trophy_system_world_open_anim";
    level.var_4f3822f4 = &trophysystemdetonate;
    level thread register();
    callback::on_player_killed(&on_player_killed);
    callback::on_spawned(&ammo_reset);
    weaponobjects::function_e6400478(#"trophy_system", &createtrophysystemwatcher, 1);
    callback::on_finalize_initialization(&function_1c601b99);
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x2fe5ee1d, Offset: 0x310
// Size: 0xa0
function function_1c601b99() {
    if (isdefined(level.var_1b900c1d)) {
        [[ level.var_1b900c1d ]](getweapon(#"trophy_system"), &function_bff5c062);
    }
    if (isdefined(level.var_a5dacbea)) {
        [[ level.var_a5dacbea ]](getweapon(#"trophy_system"), &weaponobjects::function_127fb8f3);
    }
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x3c221ca8, Offset: 0x3b8
// Size: 0x200
function function_bff5c062(trophysystem, attackingplayer) {
    trophysystem notify(#"hacked");
    var_f3ab6571 = trophysystem.owner weaponobjects::function_7cdcc8ba(trophysystem.var_2d045452) > 1;
    trophysystem.owner thread globallogic_audio::function_a2cde53d(trophysystem.weapon, var_f3ab6571);
    trophysystem.owner weaponobjects::hackerremoveweapon(trophysystem);
    trophysystem.team = attackingplayer.team;
    trophysystem setteam(attackingplayer.team);
    trophysystem.owner = attackingplayer;
    trophysystem setowner(attackingplayer);
    trophysystem thread trophyactive(attackingplayer);
    trophysystem weaponobjects::function_386fa470(attackingplayer);
    if (isdefined(trophysystem) && isdefined(level.var_f1edf93f)) {
        _station_up_to_detention_center_triggers = [[ level.var_f1edf93f ]]();
        if (isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
            trophysystem notify(#"cancel_timeout");
            trophysystem thread weaponobjects::weapon_object_timeout(trophysystem.var_2d045452, _station_up_to_detention_center_triggers);
        }
    }
    trophysystem thread weaponobjects::function_6d8aa6a0(attackingplayer, trophysystem.var_2d045452);
    if (isdefined(trophysystem) && isdefined(level.var_fc1bbaef)) {
        [[ level.var_fc1bbaef ]](trophysystem);
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x857ed571, Offset: 0x5c0
// Size: 0x1c
function function_720ddf7f(func) {
    level.var_ccfcde75 = func;
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x886b29c0, Offset: 0x5e8
// Size: 0x64
function register() {
    clientfield::register("missile", "trophy_system_state", 1, 2, "int");
    clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int");
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xf6984fcb, Offset: 0x658
// Size: 0x94
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
// Checksum 0xd9a80896, Offset: 0x6f8
// Size: 0x142
function createtrophysystemwatcher(watcher) {
    watcher.ondetonatecallback = &trophysystemdetonate;
    watcher.activatesound = #"wpn_claymore_alert";
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.activationdelay = 0.1;
    watcher.enemydestroy = 1;
    watcher.var_10efd558 = "switched_field_upgrade";
    watcher.onspawn = &ontrophysystemspawn;
    watcher.ondamage = &watchtrophysystemdamage;
    watcher.ondestroyed = &ontrophysystemsmashed;
    watcher.var_994b472b = &function_5a4f1e1e;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.ontimeout = &ontrophysystemsmashed;
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0xe5f95d3a, Offset: 0x848
// Size: 0x5e
function trophysystemstopped() {
    self endon(#"death", #"trophysystemstopped");
    self util::waittillnotmoving();
    self.trophysystemstationary = 1;
    self notify(#"trophysystemstopped");
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0x912fa5e7, Offset: 0x8b0
// Size: 0x32c
function ontrophysystemspawn(watcher, player) {
    player endon(#"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    self useanimtree("generic");
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self.trophysystemstationary = 0;
    self.weapon = getweapon(#"trophy_system");
    self.var_2d045452 = watcher;
    self.delete_on_death = 1;
    self.var_48d842c3 = 1;
    self.var_515d6dda = 1;
    self setweapon(self.weapon);
    self.ammo = player ammo_get(self.weapon);
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
    if (isalive(player)) {
        player stats::function_e24eec31(self.weapon, #"used", 1);
    }
    self thread trophyactive(player);
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
// Checksum 0x673ac65c, Offset: 0xbe8
// Size: 0x34
function setreconmodeldeployed() {
    if (isdefined(self.reconmodelentity)) {
        self.reconmodelentity clientfield::set("trophy_system_state", 2);
    }
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0xa1b40c4c, Offset: 0xc28
// Size: 0x24
function function_5a4f1e1e(*player) {
    self thread trophysystemdetonate();
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xe4bcb151, Offset: 0xc58
// Size: 0x19c
function ontrophysystemsmashed(attacker, *callback_data) {
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound(#"dst_trophy_smash");
    var_3c4d4b60 = isdefined(self.owner);
    if (var_3c4d4b60 && isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    if (isdefined(callback_data) && (!var_3c4d4b60 || self.owner util::isenemyplayer(callback_data))) {
        callback_data challenges::destroyedequipment();
        scoreevents::processscoreevent(#"destroyed_trophy_system", callback_data, self.owner, undefined);
        var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
        self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
    }
    self battlechatter::function_d2600afc(callback_data, self.owner, self.weapon);
    self delete();
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x6682f378, Offset: 0xe00
// Size: 0x430
function trophyactive(owner) {
    owner endon(#"disconnect");
    self endon(#"death", #"hacked");
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
                if (is_false(self.trophysystemstationary) && is_true(grenade.trophysystemstationary)) {
                    continue;
                }
            }
            if (!isdefined(grenade.owner)) {
                grenade.owner = getmissileowner(grenade);
            }
            if (isdefined(grenade.owner)) {
                if (level.teambased) {
                    if (!grenade.owner util::isenemyteam(owner.team)) {
                        continue;
                    }
                } else if (grenade.owner == owner) {
                    continue;
                }
                if (bullettracepassed(grenade.origin, self.origin + (0, 0, 29), 0, self, grenade, 0, 1)) {
                    grenade notify(#"death");
                    if (isdefined(level.var_ccfcde75)) {
                        owner [[ level.var_ccfcde75 ]](self, grenade);
                    }
                    var_84c1f04c = grenade.origin - self.origin;
                    if (var_84c1f04c == (0, 0, 0)) {
                        var_84c1f04c = (1, 0, 0);
                    }
                    fxup = anglestoup(self.angles);
                    if (fxup == (0, 0, 0)) {
                        fxup = (0, 0, 1);
                    }
                    playfx(#"hash_4c43fb56657819c6", self.origin + (0, 0, 15), var_84c1f04c, fxup);
                    owner thread projectileexplode(grenade, self);
                    index--;
                    self playsound(#"wpn_trophy_alert");
                    if (getdvarint(#"player_sustainammo", 0) == 0) {
                        if (!isdefined(self.ammo)) {
                            self.ammo = 0;
                        }
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
// Checksum 0x58817dd8, Offset: 0x1238
// Size: 0x1c4
function projectileexplode(projectile, trophy) {
    self endon(#"death");
    projposition = projectile.origin;
    playfx(level.trophydetonationfx, projposition);
    projectile notify(#"trophy_destroyed");
    trophy radiusdamage(projposition, 128, 105, 10, self);
    scoreevents::processscoreevent(#"trophy_defense", self, projectile.owner, trophy.weapon);
    self function_3170d645(projectile, trophy);
    self challenges::trophy_defense(projposition, 512);
    if (isdefined(level.var_d3a438fb)) {
        if ([[ level.var_d3a438fb ]](trophy)) {
            self stats::function_dad108fa(#"hash_707d06184cf09b50", 1);
        }
    }
    if (self util::is_item_purchased(#"trophy_system")) {
        self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
    }
    self function_be7a08a8(trophy.weapon, 1);
    projectile delete();
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xde64513b, Offset: 0x1408
// Size: 0x4c
function _the_root_zurich_spawners(gameobject, trophy) {
    return distancesquared(gameobject.origin, trophy.origin) <= math::pow(512, 2);
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xd1ff70d4, Offset: 0x1460
// Size: 0x664
function function_3170d645(projectile, trophy) {
    player = self;
    entities = getentitiesinradius(trophy.origin, 512);
    var_48b7bfeb = 0;
    for (i = 0; i < entities.size; i++) {
        if (!isdefined(self)) {
            return;
        }
        ent = entities[i];
        if (isdefined(ent.owner) && !ent util::isenemyteam(player.team) && (ent.classname === "noclass" || ent.classname === "script_model" || ent.classname === "script_vehicle" || ent.archetype === #"mp_dog" || ent.archetype === #"human" || isdefined(ent.aitype)) && (ent.item !== level.weaponnone || ent.weapon !== level.weaponnone || ent.meleeweapon !== level.weaponnone || ent.turretweapon !== level.weaponnone) && is_true(ent.takedamage)) {
            if ((isdefined(ent.health) ? ent.health : 0) > 0) {
                var_48b7bfeb = 1;
                break;
            }
        }
    }
    if (var_48b7bfeb) {
        scoreevents::processscoreevent(#"hash_1ed8a05490cfe606", player, projectile.owner, trophy.weapon);
    }
    if (isdefined(level.flags)) {
        var_2e36557f = 0;
        foreach (flag in level.flags) {
            useobj = flag.useobj;
            if (!isdefined(useobj) || !_the_root_zurich_spawners(useobj, trophy)) {
                continue;
            }
            var_2e36557f |= useobj.userate && (useobj gameobjects::function_4b64b7fd(player.team) || useobj.interactteam === #"hash_33c49a99551acae7");
            if (var_2e36557f) {
                break;
            }
        }
        if (var_2e36557f) {
            scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
        }
    }
    if (isdefined(level.zones)) {
        var_2e36557f = 0;
        foreach (zone in level.zones) {
            useobj = zone.gameobject;
            if (!isdefined(useobj) || !_the_root_zurich_spawners(useobj, trophy)) {
                continue;
            }
            var_2e36557f |= useobj.userate && (useobj gameobjects::function_4b64b7fd(player.team) || useobj.interactteam === #"hash_33c49a99551acae7");
            if (var_2e36557f) {
                break;
            }
        }
        if (var_2e36557f) {
            scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
        }
    }
    if (isdefined(level.bombzones)) {
        var_2e36557f = 0;
        foreach (useobj in level.bombzones) {
            if (!isdefined(useobj) || !_the_root_zurich_spawners(useobj, trophy)) {
                continue;
            }
            var_2e36557f |= useobj.userate && (useobj gameobjects::function_4b64b7fd(player.team) || useobj.interactteam === #"hash_33c49a99551acae7");
            if (var_2e36557f) {
                break;
            }
        }
        if (var_2e36557f) {
            scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
        }
    }
}

// Namespace trophy_system/trophy_system
// Params 2, eflags: 0x0
// Checksum 0xf6324fc5, Offset: 0x1ad0
// Size: 0x14c
function trophydestroytacinsert(tacinsert, trophy) {
    self endon(#"death");
    tacpos = tacinsert.origin;
    playfx(level.trophydetonationfx, tacinsert.origin);
    if (isdefined(level.var_ef4e178e)) {
        tacinsert thread [[ level.var_ef4e178e ]](self, trophy);
    }
    trophy radiusdamage(tacpos, 128, 105, 10, self);
    scoreevents::processscoreevent(#"trophy_defense", self, undefined, trophy.weapon);
    if (self util::is_item_purchased(#"trophy_system")) {
        self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
    }
    self function_be7a08a8(trophy.weapon, 1);
}

// Namespace trophy_system/trophy_system
// Params 3, eflags: 0x0
// Checksum 0x789f60af, Offset: 0x1c28
// Size: 0x17c
function trophysystemdetonate(attacker, weapon, *target) {
    if (!isdefined(target) || !target.isemp) {
        playfx(level._equipment_explode_fx_lg, self.origin);
    }
    if (isdefined(weapon) && self.owner util::isenemyplayer(weapon)) {
        weapon challenges::destroyedequipment(target);
        scoreevents::processscoreevent(#"destroyed_trophy_system", weapon, self.owner, target);
        self battlechatter::function_d2600afc(weapon, self.owner, self.weapon, target);
        var_f3ab6571 = self.owner weaponobjects::function_8481fc06(self.weapon) > 1;
        self.owner thread globallogic_audio::function_6daffa93(self.weapon, var_f3ab6571);
    }
    playsoundatposition(#"exp_trophy_system", self.origin);
    self delete();
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x1e34f872, Offset: 0x1db0
// Size: 0x362
function watchtrophysystemdamage(watcher) {
    self endon(#"death");
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
        damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
        if (!isplayer(attacker)) {
            continue;
        }
        if (level.teambased) {
            if (!sessionmodeiswarzonegame() && !level.hardcoremode && isdefined(self.owner) && !attacker util::isenemyteam(self.owner.team) && self.owner != attacker) {
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
            if (util::function_fbce7263(attacker.team, self.team)) {
                killstreaks::function_e729ccee(attacker, weapon);
            }
            watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
            return;
        }
    }
}

// Namespace trophy_system/trophy_system
// Params 0, eflags: 0x0
// Checksum 0x26d5633e, Offset: 0x2120
// Size: 0x16
function ammo_reset() {
    self._trophy_system_ammo1 = undefined;
    self._trophy_system_ammo2 = undefined;
}

// Namespace trophy_system/trophy_system
// Params 1, eflags: 0x0
// Checksum 0x2c3a2987, Offset: 0x2140
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
// Checksum 0xeead467a, Offset: 0x21d0
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

