#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;

#namespace mini_turret;

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x2
// Checksum 0x4cbe20e1, Offset: 0x1c0
// Size: 0x44
function autoexec __init__system__() {
    system::register(#"mini_turret", &__init__, undefined, #"zm_weapons");
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x8908b6e5, Offset: 0x210
// Size: 0xdc
function __init__() {
    clientfield::register("vehicle", "mini_turret_open", 1, 1, "int");
    vehicle::add_main_callback("veh_mini_turret_zm", &initturret);
    weaponobjects::function_f298eae6(#"mini_turret", &function_638912cb, undefined);
    callback::on_revived(&on_player_revived);
    deployable::register_deployable(getweapon("mini_turret"), undefined);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x0
// Checksum 0x12dfe2f5, Offset: 0x2f8
// Size: 0x3c
function on_player_revived(s_params) {
    if (self != level) {
        self endon(#"disconnect");
        self thread weaponobjects::watchweaponobjectusage();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x6f61258b, Offset: 0x340
// Size: 0xde
function initturret() {
    turretvehicle = self;
    turretvehicle.dontfreeme = 1;
    turretvehicle.damage_on_death = 0;
    turretvehicle.delete_on_death = undefined;
    turretvehicle.maxhealth = 2000;
    turretvehicle.damagetaken = 0;
    turretvehicle.health = turretvehicle.maxhealth;
    turretvehicle.maxsightdistsqrd = 2500 * 2500;
    turretvehicle turretsetontargettolerance(0, 15);
    turretvehicle.soundmod = "mini_turret";
    turretvehicle.overridevehicledamage = &onturretdamage;
    turretvehicle.overridevehiclekilled = &onturretdeath;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x0
// Checksum 0x8fe9fb4d, Offset: 0x428
// Size: 0x4e
function function_638912cb(watcher) {
    watcher.onspawn = &function_83353a1b;
    watcher.deleteonplayerspawn = 0;
    watcher.ontimeout = &function_7304f968;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 2, eflags: 0x0
// Checksum 0x8d82775a, Offset: 0x480
// Size: 0x3cc
function function_83353a1b(watcher, player) {
    player endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    slot = player gadgetgetslot(self.weapon);
    if (isdefined(player.b_talisman_extra_miniturret) && player.b_talisman_extra_miniturret) {
        n_charge = player gadgetpowerget(slot);
        player gadgetpowerset(slot, n_charge - 50);
    } else {
        player gadgetpowerreset(slot);
        player gadgetpowerset(slot, 0);
    }
    self weaponobjects::onspawnuseweaponobject(watcher, player);
    self hide();
    if (isdefined(player)) {
        player val::set(#"mini_turret", "freezecontrols");
    }
    self waittill(#"stationary");
    player stats::function_4f10b697(self.weapon, #"used", 1);
    self deployable::function_c334d8f9(player);
    self.origin += (0, 0, 2);
    player onplaceturret(self);
    if (isdefined(player)) {
        player val::reset(#"mini_turret", "freezecontrols");
    }
    if (!isdefined(player.mini_turrets)) {
        player.mini_turrets = [];
    }
    if (!isdefined(player.mini_turrets)) {
        player.mini_turrets = [];
    } else if (!isarray(player.mini_turrets)) {
        player.mini_turrets = array(player.mini_turrets);
    }
    player.mini_turrets[player.mini_turrets.size] = self.vehicle;
    if (isdefined(self.weapon) && isdefined(self.vehicle)) {
        self.vehicle thread weaponobjects::function_15617e5c(self.weapon.fusetime, &function_72f74807);
        self.vehicle clientfield::set("mini_turret_open", 1);
    }
    self ghost();
    self thread function_69af0157();
    self.vehicle thread function_b84173e2();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x229ce9c5, Offset: 0x858
// Size: 0x1c
function function_7304f968() {
    self.vehicle thread function_72f74807();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x32d86cfb, Offset: 0x880
// Size: 0x74
function function_69af0157() {
    vehicle = self.vehicle;
    waitresult = self waittill(#"death");
    if (waitresult._notify != "death") {
        return;
    }
    if (isdefined(vehicle)) {
        vehicle function_92cab0d3(undefined, undefined);
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x2568f75a, Offset: 0x900
// Size: 0xbc
function function_b84173e2() {
    owner = self.owner;
    owner endon(#"disconnect");
    waitresult = self waittill(#"death", #"death_started");
    if (!isdefined(self)) {
        arrayremovevalue(owner.mini_turrets, undefined);
        return;
    }
    if (self.damagetaken > self.health) {
        arrayremovevalue(owner.mini_turrets, self);
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x0
// Checksum 0x99118c85, Offset: 0x9c8
// Size: 0x4f4
function onplaceturret(turret) {
    player = self;
    assert(isplayer(player));
    if (isdefined(turret.vehicle)) {
        turret.vehicle.origin = turret.origin;
        turret.vehicle.angles = turret.angles;
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle playsound(#"mpl_turret_startup");
    } else {
        turret.vehicle = spawnvehicle("veh_mini_turret_zm", turret.origin, turret.angles, "dynamic_spawn_ai");
        turret.vehicle.owner = player;
        turret.vehicle setowner(player);
        turret.vehicle.ownerentnum = player.entnum;
        turret.vehicle.parentstruct = turret;
        turret.vehicle.controlled = 0;
        turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
        turret.vehicle.ignore_team_kills = 1;
        turret.vehicle.deal_no_crush_damage = 1;
        turret.vehicle.turret = turret;
        turret.vehicle.team = player.team;
        turret.vehicle setteam(player.team);
        turret.vehicle turret::set_team(player.team, 0);
        turret.vehicle turret::set_torso_targetting(0);
        turret.vehicle turret::set_target_leading(0);
        turret.vehicle.use_non_teambased_enemy_selection = 1;
        turret.vehicle.waittill_turret_on_target_delay = 0.25;
        turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
        turret.vehicle thread turret_watch_owner_events();
        turret.vehicle thread turret_laser_watch();
        turret.vehicle thread setup_death_watch_for_new_targets();
        turret.vehicle thread function_695b5a53();
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle.var_85970f89 = "arc";
        turret.vehicle notsolid();
        if (issentient(turret.vehicle) == 0) {
            turret.vehicle makesentient();
        }
        player stats::function_4f10b697(getweapon("mini_turret"), #"used", 1);
    }
    turret.vehicle playloopsound(#"hash_69240c6db92da5bf", 0.25);
    turret.vehicle.turret_enabled = 1;
    target_set(turret.vehicle, (0, 0, 36));
    turret.vehicle unlink();
    turret.vehicle vehicle::connect_paths();
    turret.vehicle thread turretscanning();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 15, eflags: 0x0
// Checksum 0x6421f1dd, Offset: 0xec8
// Size: 0x1c8
function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    empdamage = int(idamage + self.healthdefault * 1 + 0.5);
    var_34a70b9a = self.damagetaken;
    self.damagetaken += idamage;
    if (self.controlled) {
        self.owner vehicle::update_damage_as_occupant(self.damagetaken, self.maxhealth);
    }
    if (self.damagetaken > 100 && 100 >= var_34a70b9a) {
        playfxontag(#"hash_3215f91a276a69ec", self, "tag_fx");
    }
    if (self.damagetaken > self.maxhealth && !isdefined(self.will_die)) {
        self.will_die = 1;
        self thread ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    return idamage;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 8, eflags: 0x0
// Checksum 0x220e4ead, Offset: 0x1098
// Size: 0x74
function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 8, eflags: 0x0
// Checksum 0x1ca17d4c, Offset: 0x1118
// Size: 0x84
function ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    waittillframeend();
    if (isdefined(self)) {
        self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 8, eflags: 0x0
// Checksum 0x43244c87, Offset: 0x11a8
// Size: 0x2b4
function ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    turretvehicle = self;
    turretvehicle notify(#"death_started");
    if (turretvehicle.dead === 1) {
        return;
    }
    turretvehicle.dead = 1;
    turretvehicle disabledriverfiring(1);
    turretvehicle.turret_enabled = 0;
    eattacker = self [[ level.figure_out_attacker ]](eattacker);
    if (isdefined(turretvehicle.parentstruct)) {
        turretvehicle.parentstruct placeables::forceshutdown();
    }
    if (isdefined(level.var_b31e16d4)) {
        self [[ level.var_b31e16d4 ]](eattacker, self.owner, self.turretweapon);
    }
    turretvehicle stoploopsound(0.5);
    turretvehicle playsound("mpl_m_turret_exp");
    playfx(level._equipment_explode_fx_lg, self.origin);
    if (isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    var_9fe8e1bb = self.turret;
    wait 0.1;
    turretvehicle ghost();
    turretvehicle notsolid();
    turretvehicle waittilltimeout(2, #"remote_weapon_end");
    if (isdefined(turretvehicle)) {
        while (isdefined(turretvehicle) && (turretvehicle.controlled || !isdefined(turretvehicle.owner))) {
            waitframe(1);
        }
        turretvehicle.dontfreeme = undefined;
        wait 0.5;
        if (isdefined(turretvehicle)) {
            turretvehicle delete();
        }
    }
    if (isdefined(var_9fe8e1bb)) {
        var_9fe8e1bb delete();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x0
// Checksum 0x9c9e7374, Offset: 0x1468
// Size: 0x20
function onshutdown(turret) {
    turret notify(#"mini_turret_shutdown");
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x30a322c5, Offset: 0x1490
// Size: 0x114
function turret_watch_owner_events() {
    self notify(#"turret_watch_owner_events_singleton");
    self endon(#"turret_watch_owner_events_singleton");
    self endon(#"death");
    self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
    self makevehicleusable();
    self.controlled = 0;
    if (isdefined(self.owner)) {
        self.owner unlink();
    }
    self makevehicleunusable();
    self.abandoned = 1;
    onshutdown(self);
    self function_72f74807();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x339da0ad, Offset: 0x15b0
// Size: 0xe0
function turret_laser_watch() {
    veh = self;
    veh endon(#"death");
    while (true) {
        laser_should_be_on = !veh.controlled && isdefined(veh.enemy);
        if (laser_should_be_on) {
            if (islaseron(veh) == 0) {
                veh vehicle::enable_laser(1, 0);
            }
        } else if (islaseron(veh)) {
            veh vehicle::enable_laser(0, 0);
        }
        wait 0.25;
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0xdfd6a040, Offset: 0x1698
// Size: 0xa6
function setup_death_watch_for_new_targets() {
    turretvehicle = self;
    turretvehicle endon(#"death");
    for (old_target = undefined; true; old_target = waitresult.target) {
        waitresult = turretvehicle waittill(#"has_new_target");
        if (isdefined(old_target)) {
            old_target notify(#"abort_death_watch");
        }
        waitresult.target thread target_death_watch(turretvehicle);
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x0
// Checksum 0xd6dc0721, Offset: 0x1748
// Size: 0xac
function target_death_watch(turretvehicle) {
    target = self;
    target endon(#"abort_death_watch");
    turretvehicle endon(#"death");
    target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
    turretvehicle clearenemy();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0x99583f5e, Offset: 0x1800
// Size: 0x848
function turretscanning() {
    veh = self;
    veh endon(#"death", #"death_started", #"end_turret_scanning");
    veh.turret_target = undefined;
    veh.do_not_clear_targets_during_think = 1;
    wait 0.8;
    veh playsound(#"mpl_turret_startup");
    veh playloopsound(#"hash_69240c6db92da5bf");
    while (true) {
        if (veh.controlled || !veh.turret_enabled) {
            wait 0.5;
            continue;
        }
        if (isdefined(veh.enemy)) {
            if (isvehicle(veh.enemy) && issentient(veh.enemy) && !(veh.enemy.var_304c2e6e === 1)) {
                veh setignoreent(veh.enemy, 1);
                wait 0.1;
                continue;
            }
        }
        if (veh has_active_enemy() && isdefined(veh.enemy) && isalive(veh.enemy)) {
            veh.turretrotscale = getdvarfloat(#"hash_7a767607be3081e9", 3);
            if (!isdefined(veh.turret_target) || veh.turret_target != veh.enemy) {
                veh vehicle_ai::setturrettarget(veh.enemy, 0, (0, 0, -15));
                veh.turret_target = veh.enemy;
                veh playsoundtoteam("mpl_turret_alert", veh.team);
            }
            if (veh.turretontarget) {
                if (true) {
                    fire_time = 0.33 > 0.33 ? 0.33 : randomfloatrange(0.33, 0.33);
                    var_e6c7ec56 = veh.enemy;
                    veh vehicle_ai::fire_for_time(fire_time, 0, veh.enemy);
                    var_1f7b58dc = !isdefined(var_e6c7ec56) || !isalive(var_e6c7ec56);
                    if (0.34 > 0 && !var_1f7b58dc) {
                        pause_time = 0.34 > 0.34 ? 0.34 : randomfloatrange(0.34, 0.34);
                        waitresult = veh.turret_target waittilltimeout(pause_time, #"death", #"disconnect");
                        var_1f7b58dc = waitresult._notify === "death";
                    }
                } else {
                    var_e6c7ec56 = veh.enemy;
                    veh vehicle_ai::fire_for_rounds(10, 0, veh.enemy);
                    var_1f7b58dc = !isdefined(var_e6c7ec56) || !isalive(var_e6c7ec56);
                }
                if (var_1f7b58dc && isdefined(veh.turret_target) && isdefined(veh.turret_target.var_eb95f255) && veh.turret_target.var_eb95f255 == veh) {
                    veh.owner playsoundtoplayer(#"hash_7ea486136cd776c", veh.owner);
                    veh.turretrotscale = 1;
                    wait randomfloatrange(0.05, 0.2);
                }
            } else {
                wait 0.25;
            }
            continue;
        }
        var_cd349918 = isdefined(veh.turret_target);
        var_d3e33850 = 0;
        if (var_cd349918) {
            var_d3e33850 = isalive(veh.turret_target);
            veh setpersonalignore(veh.turret_target, 1.5);
        }
        veh clearenemy();
        veh.turret_target = undefined;
        veh.turretrotscale = 1;
        if (var_cd349918 && var_d3e33850) {
            veh playsoundtoteam("mpl_turret_lost", veh.team);
        }
        if (veh.var_85970f89 == "arc") {
            if (veh.scanpos === "left") {
                veh turretsettargetangles(0, (-20, 40, 0));
                veh.scanpos = "right";
            } else {
                veh turretsettargetangles(0, (-20, -40, 0));
                veh.scanpos = "left";
            }
        } else if (veh.scanpos === "left") {
            veh turretsettargetangles(0, (-20, 180, 0));
            veh.scanpos = "left2";
        } else if (veh.scanpos === "left2") {
            veh turretsettargetangles(0, (-20, 360, 0));
            veh.scanpos = "right";
        } else if (veh.scanpos === "right") {
            veh turretsettargetangles(0, (-20, -180, 0));
            veh.scanpos = "right2";
        } else {
            veh turretsettargetangles(0, (-20, -360, 0));
            veh.scanpos = "left";
        }
        veh waittilltimeout(3.5, #"enemy");
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0xedcdba09, Offset: 0x2050
// Size: 0x26
function has_active_enemy() {
    if (!isdefined(self.enemylastseentime)) {
        return false;
    }
    return gettime() < self.enemylastseentime + 1000;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0xcfe38c4f, Offset: 0x2080
// Size: 0x1c
function function_72f74807() {
    self thread function_92cab0d3(undefined, undefined);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 2, eflags: 0x0
// Checksum 0xb3338697, Offset: 0x20a8
// Size: 0xe4
function function_92cab0d3(attacker, callback_data) {
    if (!isdefined(self)) {
        return;
    }
    if (self.dead === 1) {
        return;
    }
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound("dst_trophy_smash");
    self stoploopsound(0.5);
    turret = self.turret;
    self delete();
    if (isdefined(self.turret)) {
        self.turret delete();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x0
// Checksum 0xcad318d, Offset: 0x2198
// Size: 0x1cc
function function_695b5a53() {
    self endon(#"death");
    waitframe(1);
    var_1e3cc337 = 386.089 * float(function_f9f48566()) / 1000;
    max_delta = 1;
    while (true) {
        if (!isdefined(self.turret)) {
            wait 1;
            continue;
        }
        trace = physicstrace(self.origin + (0, 0, 0), self.origin + (0, 0, -10), (-3, -3, -1), (3, 3, 1), self.turret, 1 | 16);
        if (trace[#"fraction"] > 0) {
            new_origin = trace[#"position"];
            self.origin = (new_origin[0], new_origin[1], self.origin[2] - min(max_delta, self.origin[2] - new_origin[2]));
            max_delta += var_1e3cc337;
            waitframe(1);
            continue;
        }
        max_delta = 1;
        wait 1;
    }
}

