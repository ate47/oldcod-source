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
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;

#namespace mini_turret;

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x6
// Checksum 0xd8fc1a17, Offset: 0x1f0
// Size: 0x44
function private autoexec __init__system__() {
    system::register(#"mini_turret", &function_70a657d8, undefined, undefined, #"zm_weapons");
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x5 linked
// Checksum 0x1b3cfe30, Offset: 0x240
// Size: 0xfc
function private function_70a657d8() {
    clientfield::register("vehicle", "mini_turret_open", 1, 1, "int");
    vehicle::add_main_callback("veh_mini_turret_zm", &initturret);
    weaponobjects::function_e6400478(#"mini_turret", &function_c41ea657, undefined);
    callback::on_revived(&on_player_revived);
    deployable::register_deployable(getweapon(#"mini_turret"), &function_2994c93, undefined, undefined, #"hash_2afe1c9235ce67ab");
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x44e3290f, Offset: 0x348
// Size: 0x78
function function_2994c93(v_origin, *v_angles, *player) {
    if (zm_utility::check_point_in_playable_area(player) && zm_utility::check_point_in_enabled_zone(player, 1) && ispointonnavmesh(player)) {
        return true;
    }
    return false;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x8856a73c, Offset: 0x3c8
// Size: 0x9c
function on_player_revived(s_params) {
    if (isdefined(s_params) && isplayer(s_params.e_revivee)) {
        e_revivee = s_params.e_revivee;
    } else if (isplayer(self)) {
        e_revivee = self;
    }
    if (isdefined(e_revivee)) {
        e_revivee thread weaponobjects::watchweaponobjectusage();
        e_revivee thread weaponobjects::watchweaponobjectspawn();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xae6eaa81, Offset: 0x470
// Size: 0xca
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
// Params 1, eflags: 0x1 linked
// Checksum 0x660267f7, Offset: 0x548
// Size: 0x3a
function function_c41ea657(watcher) {
    watcher.onspawn = &function_3be2d17f;
    watcher.ontimeout = &function_d3ea6abe;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x83917e6d, Offset: 0x590
// Size: 0x39c
function function_3be2d17f(watcher, player) {
    player endon(#"death", #"disconnect");
    level endon(#"game_ended");
    self endon(#"death");
    slot = player gadgetgetslot(self.weapon);
    if (is_true(player.b_talisman_extra_miniturret)) {
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
    player stats::function_e24eec31(self.weapon, #"used", 1);
    self deployable::function_dd266e08(player);
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
        self.vehicle thread weaponobjects::function_d9c08e94(self.weapon.fusetime, &function_99f0804f);
        self.vehicle clientfield::set("mini_turret_open", 1);
    }
    self ghost();
    self thread function_24910d60();
    self.vehicle thread function_7f9eb7f();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x3b525340, Offset: 0x938
// Size: 0x34
function function_d3ea6abe() {
    if (isdefined(self) && isdefined(self.vehicle)) {
        self.vehicle thread function_99f0804f();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x37d7ef57, Offset: 0x978
// Size: 0x7c
function function_24910d60() {
    vehicle = self.vehicle;
    waitresult = self waittill(#"death");
    if (waitresult._notify != "death") {
        return;
    }
    if (isdefined(vehicle)) {
        vehicle function_45ffb470(undefined, undefined);
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xe8e0102c, Offset: 0xa00
// Size: 0xb4
function function_7f9eb7f() {
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
// Params 1, eflags: 0x1 linked
// Checksum 0x8cbab17c, Offset: 0xac0
// Size: 0x4a4
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
        turret.vehicle thread function_31477582();
        turret.vehicle thread util::ghost_wait_show(0.05);
        turret.vehicle.var_63d65a8d = "arc";
        turret.vehicle notsolid();
        if (issentient(turret.vehicle) == 0) {
            turret.vehicle makesentient();
        }
        player stats::function_e24eec31(getweapon(#"mini_turret"), #"used", 1);
    }
    turret.vehicle playloopsound(#"hash_69240c6db92da5bf", 0.25);
    turret.vehicle.turret_enabled = 1;
    target_set(turret.vehicle, (0, 0, 36));
    turret.vehicle unlink();
    turret.vehicle vehicle::connect_paths();
    turret.vehicle thread turretscanning();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 15, eflags: 0x1 linked
// Checksum 0xfcc9c681, Offset: 0xf70
// Size: 0x188
function onturretdamage(einflictor, eattacker, idamage, *idflags, smeansofdeath, weapon, *vpoint, vdir, shitloc, *vdamageorigin, psoffsettime, *damagefromunderneath, *modelindex, *partname, *vsurfacenormal) {
    empdamage = int(vdamageorigin + self.healthdefault * 1 + 0.5);
    var_820fb5ae = self.damagetaken;
    self.damagetaken += vdamageorigin;
    if (self.damagetaken > 100 && 100 >= var_820fb5ae) {
        playfxontag(#"hash_3215f91a276a69ec", self, "tag_fx");
    }
    if (self.damagetaken > self.maxhealth && !isdefined(self.will_die)) {
        self.will_die = 1;
        self thread ondeathafterframeend(vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    return vdamageorigin;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 8, eflags: 0x1 linked
// Checksum 0xb9085c37, Offset: 0x1100
// Size: 0x6c
function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 8, eflags: 0x1 linked
// Checksum 0xcd550ac5, Offset: 0x1178
// Size: 0x74
function ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    waittillframeend();
    if (isdefined(self)) {
        self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 8, eflags: 0x1 linked
// Checksum 0x45a79f02, Offset: 0x11f8
// Size: 0x2d4
function ondeath(*einflictor, eattacker, *idamage, *smeansofdeath, *weapon, *vdir, *shitloc, *psoffsettime) {
    turretvehicle = self;
    turretvehicle notify(#"death_started");
    if (turretvehicle.dead === 1) {
        return;
    }
    turretvehicle.dead = 1;
    turretvehicle disabledriverfiring(1);
    turretvehicle.turret_enabled = 0;
    psoffsettime = self [[ level.figure_out_attacker ]](psoffsettime);
    if (isdefined(turretvehicle.parentstruct)) {
        turretvehicle.parentstruct placeables::forceshutdown();
    }
    if (isdefined(level.var_d2600afc)) {
        self [[ level.var_d2600afc ]](psoffsettime, self.owner, self.turretweapon);
    }
    turretvehicle stoploopsound(0.5);
    turretvehicle playsound("mpl_turret_exp");
    playfx(level._equipment_explode_fx_lg, self.origin);
    if (isdefined(self.owner) && isdefined(level.playequipmentdestroyedonplayer)) {
        self.owner [[ level.playequipmentdestroyedonplayer ]]();
    }
    var_980fde21 = self.turret;
    wait 0.1;
    if (isdefined(turretvehicle)) {
        turretvehicle ghost();
        turretvehicle notsolid();
        turretvehicle waittilltimeout(2, #"remote_weapon_end", #"death");
    }
    if (isdefined(turretvehicle)) {
        while (isdefined(turretvehicle) && (turretvehicle.controlled || !isdefined(turretvehicle.owner))) {
            waitframe(1);
        }
        if (isdefined(turretvehicle)) {
            turretvehicle.dontfreeme = undefined;
            wait 0.5;
        }
        if (isdefined(turretvehicle)) {
            turretvehicle delete();
        }
    }
    if (isdefined(var_980fde21)) {
        var_980fde21 delete();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x54d94759, Offset: 0x14d8
// Size: 0x20
function onshutdown(turret) {
    turret notify(#"mini_turret_shutdown");
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xa6f77ab1, Offset: 0x1500
// Size: 0x114
function turret_watch_owner_events() {
    self notify(#"turret_watch_owner_events_singleton");
    self endon(#"death", #"turret_watch_owner_events_singleton");
    self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
    self makevehicleusable();
    self.controlled = 0;
    if (isdefined(self.owner)) {
        self.owner unlink();
    }
    self makevehicleunusable();
    self.abandoned = 1;
    onshutdown(self);
    self function_99f0804f();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xe991706d, Offset: 0x1620
// Size: 0xd8
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
// Params 0, eflags: 0x1 linked
// Checksum 0x752470b2, Offset: 0x1700
// Size: 0xae
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
// Params 1, eflags: 0x1 linked
// Checksum 0xcfc67e3, Offset: 0x17b8
// Size: 0xac
function target_death_watch(turretvehicle) {
    target = self;
    target endon(#"abort_death_watch");
    turretvehicle endon(#"death");
    target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
    turretvehicle clearenemy();
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xca3445aa, Offset: 0x1870
// Size: 0x7e8
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
            if (isvehicle(veh.enemy) && issentient(veh.enemy) && !(veh.enemy.var_232915af === 1)) {
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
                    var_fc9f290e = veh.enemy;
                    veh vehicle_ai::fire_for_time(fire_time, 0, veh.enemy);
                    var_afae28e0 = !isdefined(var_fc9f290e) || !isalive(var_fc9f290e);
                    if (0.34 > 0 && !var_afae28e0) {
                        pause_time = 0.34 > 0.34 ? 0.34 : randomfloatrange(0.34, 0.34);
                        waitresult = veh.turret_target waittilltimeout(pause_time, #"death", #"disconnect");
                        var_afae28e0 = waitresult._notify === "death";
                    }
                } else {
                    var_fc9f290e = veh.enemy;
                    veh vehicle_ai::fire_for_rounds(10, 0, veh.enemy);
                    var_afae28e0 = !isdefined(var_fc9f290e) || !isalive(var_fc9f290e);
                }
                if (var_afae28e0 && isdefined(veh.turret_target) && isdefined(veh.turret_target.var_e78602fc) && veh.turret_target.var_e78602fc == veh) {
                    veh.owner playsoundtoplayer(#"hash_7ea486136cd776c", veh.owner);
                    veh.turretrotscale = 1;
                    wait randomfloatrange(0.05, 0.2);
                }
            } else {
                wait 0.25;
            }
            continue;
        }
        var_4ec572ee = isdefined(veh.turret_target);
        var_bb861d93 = 0;
        if (var_4ec572ee) {
            var_bb861d93 = isalive(veh.turret_target);
            veh setpersonalignore(veh.turret_target, 1.5);
        }
        veh clearenemy();
        veh.turret_target = undefined;
        veh.turretrotscale = 1;
        if (var_4ec572ee && var_bb861d93) {
            veh playsoundtoteam("mpl_turret_lost", veh.team);
        }
        if (veh.var_63d65a8d == "arc") {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1bc15faf, Offset: 0x2060
// Size: 0x26
function has_active_enemy() {
    if (!isdefined(self.enemylastseentime)) {
        return false;
    }
    return gettime() < self.enemylastseentime + 1000;
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x6dba1a4f, Offset: 0x2090
// Size: 0x1c
function function_99f0804f() {
    self thread function_45ffb470(undefined, undefined);
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 2, eflags: 0x1 linked
// Checksum 0xa3f7afea, Offset: 0x20b8
// Size: 0xe4
function function_45ffb470(*attacker, *callback_data) {
    if (!isdefined(self)) {
        return;
    }
    if (self.dead === 1) {
        return;
    }
    playfx(level._equipment_explode_fx_lg, self.origin);
    self playsound("mpl_turret_exp");
    self stoploopsound(0.5);
    turret = self.turret;
    self delete();
    if (isdefined(self.turret)) {
        self.turret delete();
    }
}

// Namespace mini_turret/zm_weap_mini_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x3031dd0, Offset: 0x21a8
// Size: 0x1bc
function function_31477582() {
    self endon(#"death");
    waitframe(1);
    var_463c449d = 386.089 * float(function_60d95f53()) / 1000;
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
            max_delta += var_463c449d;
            waitframe(1);
            continue;
        }
        max_delta = 1;
        wait 1;
    }
}
