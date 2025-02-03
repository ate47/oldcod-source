#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\killstreaks\emp_shared;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weaponobjects;

#namespace emp;

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x33cbe7c0, Offset: 0x278
// Size: 0x1fc
function init_shared() {
    if (!isdefined(level.emp_shared)) {
        level.emp_shared = {};
        level.emp_shared.activeplayeremps = [];
        level.emp_shared.activeemps = [];
        foreach (team, _ in level.teams) {
            level.emp_shared.activeemps[team] = 0;
        }
        level.emp_shared.enemyempactivefunc = &enemyempactive;
        level thread emptracker();
        clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int");
        clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int");
        callback::on_spawned(&onplayerspawned);
        callback::on_connect(&onplayerconnect);
        vehicle::add_main_callback("emp_turret", &initturretvehicle);
        callback::add_callback(#"hash_7c6da2f2c9ef947a", &fx_flesh_hit_neck_fatal);
    }
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0xd7a7fe63, Offset: 0x480
// Size: 0x120
function fx_flesh_hit_neck_fatal(params) {
    foreach (player in params.players) {
        if (player hasactiveemp()) {
            scoregiven = scoreevents::processscoreevent(#"emp_assist", player, undefined, undefined);
            if (isdefined(scoregiven)) {
                player challenges::earnedempassistscore(scoregiven);
                killstreakindex = level.killstreakindices[#"emp"];
                killstreaks::killstreak_assist(player, self, killstreakindex);
            }
        }
    }
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x1a11e29e, Offset: 0x5a8
// Size: 0xd0
function initturretvehicle() {
    turretvehicle = self;
    turretvehicle killstreaks::setup_health("emp");
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle clientfield::set("enemyvehicle", 1);
    turretvehicle.soundmod = "drone_land";
    turretvehicle.overridevehiclekilled = &onturretdeath;
    target_set(turretvehicle, (0, 0, 36));
    if (isdefined(level.var_389a99a4)) {
        turretvehicle [[ level.var_389a99a4 ]]();
    }
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x89368712, Offset: 0x680
// Size: 0x2c
function onplayerspawned() {
    self endon(#"disconnect");
    self updateemp();
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x78dc73d0, Offset: 0x6b8
// Size: 0x3c
function onplayerconnect() {
    self.entnum = self getentitynumber();
    level.emp_shared.activeplayeremps[self.entnum] = 0;
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0xceccb3cb, Offset: 0x700
// Size: 0x1dc
function deployempturret(emp) {
    player = self;
    player endon(#"disconnect", #"joined_team", #"joined_spectators");
    emp endon(#"death");
    emp.vehicle useanimtree("generic");
    emp.vehicle setanim(#"o_turret_emp_core_deploy", 1);
    length = getanimlength(#"o_turret_emp_core_deploy");
    emp.vehicle clientfield::set("emp_turret_deploy", 1);
    wait length * 0.75;
    emp.vehicle thread playempfx();
    emp.vehicle playsound(#"mpl_emp_turret_activate");
    emp.vehicle setanim(#"o_turret_emp_core_spin", 1);
    player thread emp_jamenemies(emp, 0);
    wait length * 0.25;
    emp.vehicle clearanim(#"o_turret_emp_core_deploy", 0);
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0xcc940f95, Offset: 0x8e8
// Size: 0x6c
function doneempfx(fxtagorigin) {
    params = getscriptbundle("killstreak_bundle");
    playfx(params.ksexplosionfx, fxtagorigin);
    playsoundatposition(#"mpl_emp_turret_deactivate", fxtagorigin);
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0xebfc4f8e, Offset: 0x960
// Size: 0x3a
function playempfx() {
    emp_vehicle = self;
    emp_vehicle playloopsound(#"mpl_emp_turret_loop_close");
    waitframe(1);
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0xbf199898, Offset: 0x9a8
// Size: 0x7c
function on_timeout() {
    emp = self;
    if (isdefined(emp.vehicle)) {
        fxtagorigin = emp.vehicle gettagorigin("tag_fx");
        doneempfx(fxtagorigin);
    }
    shutdownemp(emp);
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0x37745207, Offset: 0xa30
// Size: 0x3c
function oncancelplacement(emp) {
    stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
}

// Namespace emp/emp_shared
// Params 8, eflags: 0x0
// Checksum 0x13f31256, Offset: 0xa78
// Size: 0x5c
function onturretdeath(*inflictor, attacker, *idamage, *smeansofdeath, weapon, *vdir, *shitloc, *psoffsettime) {
    self ondeath(shitloc, psoffsettime);
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0x71850575, Offset: 0xae0
// Size: 0x3c
function ondeathafterframeend(attacker, weapon) {
    waittillframeend();
    if (isdefined(self)) {
        self ondeath(attacker, weapon);
    }
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0x2349de0a, Offset: 0xb28
// Size: 0x9c
function ondeath(attacker, weapon) {
    emp_vehicle = self;
    fxtagorigin = self gettagorigin("tag_fx");
    doneempfx(fxtagorigin);
    if (isdefined(level.var_b1ffcff8)) {
        self [[ level.var_b1ffcff8 ]](attacker, weapon);
    }
    shutdownemp(emp_vehicle.parentstruct);
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0x3e8234c9, Offset: 0xbd0
// Size: 0x24
function onshutdown(emp) {
    shutdownemp(emp);
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0x7bccb923, Offset: 0xc00
// Size: 0xfc
function shutdownemp(emp) {
    if (!isdefined(emp)) {
        return;
    }
    if (isdefined(emp.already_shutdown)) {
        return;
    }
    emp.already_shutdown = 1;
    if (isdefined(emp.vehicle)) {
        emp.vehicle clientfield::set("emp_turret_deploy", 0);
    }
    stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
    if (isdefined(emp.othermodel)) {
        emp.othermodel delete();
    }
    if (isdefined(emp.vehicle)) {
        emp.vehicle delete();
    }
    emp delete();
}

// Namespace emp/emp_shared
// Params 4, eflags: 0x0
// Checksum 0xc53cb91f, Offset: 0xd08
// Size: 0x54
function stopemp(currentteam, currentownerentnum, originalteam, killstreakid) {
    stopempeffect(currentteam, currentownerentnum);
    stopemprule(originalteam, killstreakid);
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0x935e7988, Offset: 0xd68
// Size: 0x58
function stopempeffect(team, ownerentnum) {
    level.emp_shared.activeemps[team] = 0;
    level.emp_shared.activeplayeremps[ownerentnum] = 0;
    level notify(#"emp_updated");
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0xdc804475, Offset: 0xdc8
// Size: 0x34
function stopemprule(killstreakoriginalteam, killstreakid) {
    killstreakrules::killstreakstop("emp", killstreakoriginalteam, killstreakid);
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x3742cbfe, Offset: 0xe08
// Size: 0x1c
function hasactiveemp() {
    return level.emp_shared.activeplayeremps[self.entnum];
}

// Namespace emp/emp_shared
// Params 1, eflags: 0x0
// Checksum 0x6d11b006, Offset: 0xe30
// Size: 0x28
function teamhasactiveemp(team) {
    return level.emp_shared.activeemps[team] > 0;
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x6c8d718d, Offset: 0xe60
// Size: 0x192
function getenemies() {
    enemies = [];
    combatants = level.players;
    if (sessionmodeiscampaigngame()) {
        combatants = arraycombine(combatants, getactorarray(), 0, 0);
    }
    foreach (combatant in combatants) {
        if (combatant.team === #"spectator") {
            continue;
        }
        if (level.teambased && util::function_fbce7263(combatant.team, self.team) || !level.teambased && combatant != self) {
            if (!isdefined(enemies)) {
                enemies = [];
            } else if (!isarray(enemies)) {
                enemies = array(enemies);
            }
            enemies[enemies.size] = combatant;
        }
    }
    return enemies;
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x97f0b75f, Offset: 0x1000
// Size: 0x10
function function_d12cde1c() {
    return isdefined(level.emp_shared);
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x50f7af54, Offset: 0x1018
// Size: 0x182
function enemyempactive() {
    if (!function_d12cde1c()) {
        return false;
    }
    if (level.teambased) {
        foreach (team, _ in level.teams) {
            if (util::function_fbce7263(team, self.team) && teamhasactiveemp(team)) {
                return true;
            }
        }
    } else {
        enemies = self getenemies();
        foreach (player in enemies) {
            if (player hasactiveemp()) {
                return true;
            }
        }
    }
    return false;
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x3a6474c3, Offset: 0x11a8
// Size: 0xb2
function enemyempowner() {
    enemies = self getenemies();
    foreach (player in enemies) {
        if (player hasactiveemp()) {
            return player;
        }
    }
    return undefined;
}

// Namespace emp/emp_shared
// Params 2, eflags: 0x0
// Checksum 0x6d01c828, Offset: 0x1268
// Size: 0x23c
function emp_jamenemies(empent, hacked) {
    level endon(#"game_ended");
    self endon(#"killstreak_hacked");
    if (level.teambased) {
        if (hacked) {
            level.emp_shared.activeemps[empent.originalteam] = 0;
        }
        level.emp_shared.activeemps[self.team] = 1;
    }
    if (hacked) {
        level.emp_shared.activeplayeremps[empent.originalownerentnum] = 0;
    }
    level.emp_shared.activeplayeremps[self.entnum] = 1;
    level notify(#"emp_updated");
    level notify(#"emp_deployed");
    visionsetnaked("flash_grenade", 1.5);
    wait 0.1;
    visionsetnaked("flash_grenade", 0);
    visionsetnaked("default", 5);
    radius = isdefined(level.empkillstreakbundle.ksdamageradius) ? level.empkillstreakbundle.ksdamageradius : 750;
    empkillstreakweapon = getweapon(#"emp");
    empkillstreakweapon.isempkillstreak = 1;
    level destroyotherteamsactivevehicles(self, empkillstreakweapon, radius);
    level destroyotherteamsequipment(self, empkillstreakweapon, radius);
    level weaponobjects::destroy_other_teams_supplemental_watcher_objects(self, empkillstreakweapon, radius);
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x9b8e662a, Offset: 0x14b0
// Size: 0xc4
function emptracker() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"emp_updated");
        foreach (player in level.players) {
            player updateemp();
        }
    }
}

// Namespace emp/emp_shared
// Params 0, eflags: 0x0
// Checksum 0x5938650e, Offset: 0x1580
// Size: 0xa0
function updateemp() {
    player = self;
    enemy_emp_active = player enemyempactive();
    player setempjammed(enemy_emp_active);
    emped = player isempjammed();
    player clientfield::set_to_player("empd_monitor_distance", emped);
    if (emped) {
        player notify(#"emp_jammed");
    }
}

// Namespace emp/emp_shared
// Params 3, eflags: 0x0
// Checksum 0xfbc2a187, Offset: 0x1628
// Size: 0x12c
function destroyotherteamsequipment(attacker, weapon, radius) {
    foreach (team, _ in level.teams) {
        if (!util::function_fbce7263(team, attacker.team)) {
            continue;
        }
        destroyequipment(attacker, team, weapon, radius);
        destroytacticalinsertions(attacker, team, radius);
    }
    destroyequipment(attacker, #"none", weapon, radius);
    destroytacticalinsertions(attacker, #"none", radius);
}

// Namespace emp/emp_shared
// Params 4, eflags: 0x0
// Checksum 0x5ef78343, Offset: 0x1760
// Size: 0x1cc
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
        if (isdefined(team) && util::function_fbce7263(item.owner.team, team)) {
            continue;
        } else if (item.owner == attacker) {
            continue;
        }
        if (!item.weapon.isequipment && !is_true(item.destroyedbyemp)) {
            continue;
        }
        watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);
        if (!isdefined(watcher)) {
            continue;
        }
        watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
    }
}

// Namespace emp/emp_shared
// Params 3, eflags: 0x0
// Checksum 0xd77cc09c, Offset: 0x1938
// Size: 0x118
function destroytacticalinsertions(attacker, victimteam, radius) {
    radiussq = radius * radius;
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (!isdefined(player.tacticalinsertion)) {
            continue;
        }
        if (level.teambased && util::function_fbce7263(player.team, victimteam)) {
            continue;
        }
        if (attacker == player) {
            continue;
        }
        if (distancesquared(player.origin, attacker.origin) < radiussq) {
            if (isdefined(level.var_8ee772a3)) {
                player.tacticalinsertion thread [[ level.var_8ee772a3 ]]();
            }
        }
    }
}

// Namespace emp/emp_shared
// Params 3, eflags: 0x0
// Checksum 0xf434e5fc, Offset: 0x1a58
// Size: 0xd0
function destroyotherteamsactivevehicles(attacker, weapon, radius) {
    foreach (team, _ in level.teams) {
        if (!util::function_fbce7263(team, attacker.team)) {
            continue;
        }
        destroyactivevehicles(attacker, team, weapon, radius);
    }
}

// Namespace emp/emp_shared
// Params 4, eflags: 0x4
// Checksum 0x320d0e6f, Offset: 0x1b30
// Size: 0xc04
function private destroyactivevehicles(attacker, team, weapon, radius) {
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
        if (isdefined(team) && !util::function_fbce7263(vehicle.team, team) && isvehicle(vehicle)) {
            if (isdefined(vehicle.detonateviaemp) && is_true(weapon.isempkillstreak)) {
                vehicle [[ vehicle.detonateviaemp ]](attacker, weapon);
            }
            if (isdefined(vehicle.archetype)) {
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
            if (util::function_fbce7263(planemortar.team, team)) {
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
            if (util::function_fbce7263(dronestrike.team, team)) {
                continue;
            }
        } else if (dronestrike.owner == attacker) {
            continue;
        }
        dronestrike notify(#"emp_deployed", {#attacker:attacker});
    }
    var_eca5110 = getentarray("guided_artillery_shell", "targetname");
    foreach (shell in var_eca5110) {
        if (distance2d(shell.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(shell.team)) {
            if (util::function_fbce7263(shell.team, team)) {
                continue;
            }
        } else if (shell.owner == attacker) {
            continue;
        }
        shell notify(#"emp_deployed", {#attacker:attacker});
    }
    counteruavs = getentarray("counteruav", "targetname");
    foreach (counteruav in counteruavs) {
        if (distance2d(counteruav.origin, attacker.origin) > radius) {
            continue;
        }
        if (isdefined(team) && isdefined(counteruav.team)) {
            if (util::function_fbce7263(counteruav.team, team)) {
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
            if (util::function_fbce7263(satellite.team, team)) {
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
        if (robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isdefined(team) && !util::function_fbce7263(robot.team, team)) {
            if (isdefined(attacker) && (!isdefined(robot.owner) || robot.owner util::isenemyplayer(attacker))) {
                scoreevents::processscoreevent(#"destroyed_combat_robot", attacker, robot.owner, weapon);
                luinotifyevent(#"player_callout", 2, #"hash_3b274c8c3c961f3", attacker.entnum);
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

// Namespace emp/emp_shared
// Params 5, eflags: 0x4
// Checksum 0x5e68185e, Offset: 0x2740
// Size: 0x26c
function private destroyentities(entities, attacker, team, weapon, radius) {
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
            if (util::function_fbce7263(entity.team, team)) {
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

