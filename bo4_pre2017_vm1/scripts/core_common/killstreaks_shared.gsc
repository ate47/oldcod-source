#using scripts/core_common/abilities/ability_player;
#using scripts/core_common/hostmigration_shared;
#using scripts/core_common/scoreevents_shared;
#using scripts/core_common/struct;
#using scripts/core_common/table_shared;
#using scripts/core_common/util_shared;
#using scripts/core_common/vehicles/raps;
#using scripts/core_common/weapons/tacticalinsertion;
#using scripts/core_common/weapons/weaponobjects;

#namespace killstreaks;

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x426a8c89, Offset: 0x320
// Size: 0x66
function is_killstreak_weapon(weapon) {
    if (weapon == level.weaponnone || weapon.notkillstreak) {
        return false;
    }
    if (weapon.isspecificuse || is_weapon_associated_with_killstreak(weapon)) {
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x3e9ccf2f, Offset: 0x390
// Size: 0x2e
function is_weapon_associated_with_killstreak(weapon) {
    return isdefined(level.killstreakweapons) && isdefined(level.killstreakweapons[weapon]);
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0x9ee16033, Offset: 0x3c8
// Size: 0x3b0
function switch_to_last_non_killstreak_weapon(immediate, awayfromball) {
    ball = getweapon("ball");
    if (isdefined(ball) && self hasweapon(ball) && !(isdefined(awayfromball) && awayfromball)) {
        self switchtoweaponimmediate(ball);
        self disableweaponcycling();
        self disableoffhandweapons();
    } else if (isdefined(self.laststand) && self.laststand) {
        if (isdefined(self.laststandpistol) && self hasweapon(self.laststandpistol)) {
            self switchtoweapon(self.laststandpistol);
        }
    } else if (isdefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
        if (self.lastnonkillstreakweapon.isheavyweapon) {
            if (self.lastnonkillstreakweapon.gadget_heroversion_2_0) {
                if (self.lastnonkillstreakweapon.isgadget && self getammocount(self.lastnonkillstreakweapon) > 0) {
                    slot = self gadgetgetslot(self.lastnonkillstreakweapon);
                    if (self ability_player::gadget_is_in_use(slot)) {
                        return self switchtoweapon(self.lastnonkillstreakweapon);
                    } else {
                        return 1;
                    }
                }
            } else if (self getammocount(self.lastnonkillstreakweapon) > 0) {
                return self switchtoweapon(self.lastnonkillstreakweapon);
            }
            if (isdefined(awayfromball) && awayfromball && isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
                self switchtoweapon(self.lastdroppableweapon);
            } else {
                self switchtoweapon();
            }
            return 1;
        } else if (isdefined(immediate) && immediate) {
            self switchtoweaponimmediate(self.lastnonkillstreakweapon);
        } else {
            self switchtoweapon(self.lastnonkillstreakweapon);
        }
    } else if (isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        self switchtoweapon(self.lastdroppableweapon);
    } else {
        return 0;
    }
    return 1;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xfa0f14d7, Offset: 0x780
// Size: 0x66
function get_killstreak_weapon(killstreak) {
    if (!isdefined(killstreak)) {
        return level.weaponnone;
    }
    /#
        assert(isdefined(level.killstreaks[killstreak]));
    #/
    return level.killstreaks[killstreak].weapon;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x2f377534, Offset: 0x7f0
// Size: 0x40
function isheldinventorykillstreakweapon(killstreakweapon) {
    switch (killstreakweapon.name) {
    case #"inventory_m32":
    case #"inventory_minigun":
        return true;
    }
    return false;
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0xc7821530, Offset: 0x838
// Size: 0xa8
function waitfortimecheck(duration, callback, endcondition1, endcondition2, endcondition3) {
    self endon(#"hacked");
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    hostmigration::migrationawarewait(duration);
    self notify(#"time_check");
    self [[ callback ]]();
}

// Namespace killstreaks/killstreaks_shared
// Params 0, eflags: 0x0
// Checksum 0x9fe4ad45, Offset: 0x8e8
// Size: 0x2a
function emp_isempd() {
    if (isdefined(level.enemyempactivefunc)) {
        return self [[ level.enemyempactivefunc ]]();
    }
    return 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 2, eflags: 0x0
// Checksum 0xc4ba139b, Offset: 0x920
// Size: 0x6c
function waittillemp(onempdcallback, arg) {
    self endon(#"death");
    self endon(#"delete");
    waitresult = self waittill("emp_deployed");
    if (isdefined(onempdcallback)) {
        [[ onempdcallback ]](waitresult.attacker, arg);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x92e69041, Offset: 0x998
// Size: 0x20
function hasuav(team_or_entnum) {
    return level.activeuavs[team_or_entnum] > 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x456f5dcf, Offset: 0x9c0
// Size: 0x20
function hassatellite(team_or_entnum) {
    return level.activesatellites[team_or_entnum] > 0;
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xc2ae3e4, Offset: 0x9e8
// Size: 0x12c
function destroyotherteamsequipment(attacker, weapon, radius) {
    foreach (team in level.teams) {
        if (team == attacker.team) {
            continue;
        }
        destroyequipment(attacker, team, weapon, radius);
        destroytacticalinsertions(attacker, team, radius);
    }
    destroyequipment(attacker, "free", weapon, radius);
    destroytacticalinsertions(attacker, "free", radius);
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x99f8f9ee, Offset: 0xb20
// Size: 0x1fe
function destroyequipment(attacker, team, weapon, radius) {
    radiussq = radius * radius;
    for (i = 0; i < level.missileentities.size; i++) {
        item = level.missileentities[i];
        if (!isdefined(item)) {
            continue;
        }
        if (distancesquared(item.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (!isdefined(item.weapon)) {
            continue;
        }
        if (!isdefined(item.owner)) {
            continue;
        }
        if (isdefined(team) && item.owner.team != team) {
            continue;
        } else if (item.owner == attacker) {
            continue;
        }
        if (!item.weapon.isequipment && !(isdefined(item.destroyedbyemp) && item.destroyedbyemp)) {
            continue;
        }
        watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);
        if (!isdefined(watcher)) {
            continue;
        }
        watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xeae82bf7, Offset: 0xd28
// Size: 0x126
function destroytacticalinsertions(attacker, victimteam, radius) {
    radiussq = radius * radius;
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (!isdefined(player.tacticalinsertion)) {
            continue;
        }
        if (level.teambased && player.team != victimteam) {
            continue;
        }
        if (attacker == player) {
            continue;
        }
        if (distancesquared(player.origin, attacker.origin) < radiussq) {
            player.tacticalinsertion thread tacticalinsertion::fizzle();
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 3, eflags: 0x0
// Checksum 0xeac16a91, Offset: 0xe58
// Size: 0xca
function destroyotherteamsactivevehicles(attacker, weapon, radius) {
    foreach (team in level.teams) {
        if (team == attacker.team) {
            continue;
        }
        destroyactivevehicles(attacker, team, weapon, radius);
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 4, eflags: 0x0
// Checksum 0x51f18143, Offset: 0xf30
// Size: 0xb48
function destroyactivevehicles(attacker, team, weapon, radius) {
    radiussq = radius * radius;
    targets = target_getarray();
    destroyentities(targets, attacker, team, weapon, radius);
    ai_tanks = getentarray("talon", "targetname");
    destroyentities(ai_tanks, attacker, team, weapon, radius);
    remotemissiles = getentarray("remote_missile", "targetname");
    destroyentities(remotemissiles, attacker, team, weapon, radius);
    remotedrone = getentarray("remote_drone", "targetname");
    destroyentities(remotedrone, attacker, team, weapon, radius);
    script_vehicles = getentarray("script_vehicle", "classname");
    foreach (vehicle in script_vehicles) {
        if (distancesquared(vehicle.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (isdefined(team) && vehicle.team == team && isvehicle(vehicle)) {
            if (isdefined(weapon.isempkillstreak) && isdefined(vehicle.detonateviaemp) && weapon.isempkillstreak) {
                vehicle [[ vehicle.detonateviaemp ]](attacker, weapon);
            }
            if (isdefined(vehicle.archetype)) {
                if (vehicle.archetype == "raps") {
                    vehicle raps::detonate(attacker);
                    continue;
                }
                if (vehicle.archetype == "turret" || vehicle.archetype == "rcbomb" || vehicle.archetype == "wasp") {
                    vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
                }
            }
        }
    }
    planemortars = getentarray("plane_mortar", "targetname");
    foreach (planemortar in planemortars) {
        if (distance2d(planemortar.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(planemortar.team)) {
            if (planemortar.team != team) {
                continue;
            }
        } else if (planemortar.owner == attacker) {
            continue;
        }
        planemortar notify(#"emp_deployed", {#attacker:attacker});
    }
    dronestrikes = getentarray("drone_strike", "targetname");
    foreach (dronestrike in dronestrikes) {
        if (distance2d(dronestrike.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(dronestrike.team)) {
            if (dronestrike.team != team) {
                continue;
            }
        } else if (dronestrike.owner == attacker) {
            continue;
        }
        dronestrike notify(#"emp_deployed", {#attacker:attacker});
    }
    counteruavs = getentarray("counteruav", "targetname");
    foreach (counteruav in counteruavs) {
        if (distance2d(counteruav.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(counteruav.team)) {
            if (counteruav.team != team) {
                continue;
            }
        } else if (counteruav.owner == attacker) {
            continue;
        }
        counteruav notify(#"emp_deployed", {#attacker:attacker});
    }
    satellites = getentarray("satellite", "targetname");
    foreach (satellite in satellites) {
        if (distance2d(satellite.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(satellite.team)) {
            if (satellite.team != team) {
                continue;
            }
        } else if (satellite.owner == attacker) {
            continue;
        }
        satellite notify(#"emp_deployed", {#attacker:attacker});
    }
    robots = getaiarchetypearray("robot");
    foreach (robot in robots) {
        if (distancesquared(robot.origin, attacker.origin) > radiussq) {
            continue;
        }
        if (robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isdefined(team) && robot.team == team) {
            if (!isdefined(robot.owner) || isdefined(attacker) && robot.owner util::isenemyplayer(attacker)) {
                scoreevents::processscoreevent("destroyed_combat_robot", attacker, robot.owner, weapon);
                luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_COMBAT_ROBOT, attacker.entnum);
            }
            robot kill();
        }
    }
    if (isdefined(level.missile_swarm_owner)) {
        if (level.missile_swarm_owner util::isenemyplayer(attacker)) {
            if (distancesquared(level.missile_swarm_owner.origin, attacker.origin) < radiussq) {
                level.missile_swarm_owner notify(#"emp_destroyed_missile_swarm", {#attacker:attacker});
            }
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 5, eflags: 0x0
// Checksum 0x6c962c00, Offset: 0x1a80
// Size: 0x256
function destroyentities(entities, attacker, team, weapon, radius) {
    meansofdeath = "MOD_EXPLOSIVE";
    damage = 5000;
    direction_vec = (0, 0, 0);
    point = (0, 0, 0);
    modelname = "";
    tagname = "";
    partname = "";
    radiussq = radius * radius;
    foreach (entity in entities) {
        if (isdefined(team) && isdefined(entity.team)) {
            if (entity.team != team) {
                continue;
            }
        } else if (isdefined(entity.owner) && entity.owner == attacker) {
            continue;
        }
        if (distancesquared(entity.origin, attacker.origin) < radiussq) {
            entity notify(#"damage", {#amount:damage, #attacker:attacker, #direction:direction_vec, #position:point, #mod:meansofdeath, #tag_name:tagname, #model_name:modelname, #part_name:partname, #weapon:weapon});
        }
    }
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0xea87d9fb, Offset: 0x1ce0
// Size: 0x56
function get_killstreak_for_weapon(weapon) {
    if (isdefined(level.killstreakweapons[weapon])) {
        return level.killstreakweapons[weapon];
    }
    return level.killstreakweapons[weapon.rootweapon];
}

// Namespace killstreaks/killstreaks_shared
// Params 1, eflags: 0x0
// Checksum 0x8e787aea, Offset: 0x1d40
// Size: 0x66
function is_killstreak_weapon_assist_allowed(weapon) {
    killstreak = get_killstreak_for_weapon(weapon);
    if (!isdefined(killstreak)) {
        return false;
    }
    if (level.killstreaks[killstreak].allowassists) {
        return true;
    }
    return false;
}

